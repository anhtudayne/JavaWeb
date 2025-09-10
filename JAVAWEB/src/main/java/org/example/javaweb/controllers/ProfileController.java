package org.example.javaweb.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import org.example.javaweb.models.User;
import org.example.javaweb.services.UserService;
import org.example.javaweb.services.UserServiceImpl;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class ProfileController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }
        int userId = Integer.parseInt(String.valueOf(session.getAttribute("userId")));
        String email = request.getParameter("email");
        String userName = request.getParameter("userName");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String avatar = request.getParameter("avatar"); // optional URL
        String password = request.getParameter("passWord"); // optional

        // Handle uploaded avatar file (if any)
        String uploadedAvatarUrl = null;
        try {
            Part filePart = request.getPart("avatarFile");
            if (filePart != null && filePart.getSize() > 0) {
                // Create uploads directory inside webapp
                String uploadsRoot = request.getServletContext().getRealPath("/uploads");
                if (uploadsRoot == null) {
                    // Fallback: use temp dir if running in some containers
                    uploadsRoot = System.getProperty("java.io.tmpdir") + File.separator + "uploads";
                }
                File userDir = new File(uploadsRoot, String.valueOf(userId));
                if (!userDir.exists()) {
                    userDir.mkdirs();
                }
                // Sanitize filename
                String submitted = filePart.getSubmittedFileName();
                String fileName = System.currentTimeMillis() + "_" + submitted.replaceAll("[^a-zA-Z0-9._-]", "_");
                File dest = new File(userDir, fileName);
                Files.copy(filePart.getInputStream(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
                // Build public URL under /uploads/<userId>/<file>
                uploadedAvatarUrl = request.getContextPath() + "/uploads/" + userId + "/" + fileName;
            }
        } catch (Exception ignore) {
        }

        User u = new User();
        u.setId(userId);
        u.setEmail(email);
        u.setUserName(userName);
        u.setFullName(fullName);
        u.setPhone(phone);
        // Priority: uploaded file > manual URL > keep existing (handled in service by empty)
        if (uploadedAvatarUrl != null) {
            u.setAvatar(uploadedAvatarUrl);
        } else if (avatar != null && !avatar.trim().isEmpty()) {
            u.setAvatar(avatar.trim());
        } else {
            u.setAvatar(null); // will keep old if service chooses
        }
        u.setPassWord(password); // may be null/empty -> service keeps old
        u.setRoleId(Integer.parseInt(String.valueOf(session.getAttribute("roleId"))));

        boolean ok = userService.updateProfile(u);
        if (ok) {
            // update session
            session.setAttribute("fullName", fullName);
            session.setAttribute("userName", userName);
            session.setAttribute("email", email);
            response.sendRedirect("home");
        } else {
            request.setAttribute("error", "Cập nhật thông tin thất bại. Vui lòng kiểm tra dữ liệu.");
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }
}
