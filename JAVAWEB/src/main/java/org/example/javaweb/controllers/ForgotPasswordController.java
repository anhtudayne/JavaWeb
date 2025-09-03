package org.example.javaweb.controllers;

import org.example.javaweb.services.UserService;
import org.example.javaweb.services.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("step", "email");
        request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("verifyEmail".equals(action)) {
            String email = request.getParameter("email");
            String error = userService.validateForgotPasswordEmail(email);
            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("email", email);
                request.setAttribute("step", "email");
                request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
                return;
            }
            String ok = userService.forgotPassword(email);
            if (ok == null) {
                request.setAttribute("error", "Email không tồn tại trong hệ thống");
                request.setAttribute("email", email);
                request.setAttribute("step", "email");
                request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
                return;
            }
            request.setAttribute("email", email);
            request.setAttribute("step", "reset");
            request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
            return;
        }

        if ("resetPassword".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            String error = userService.validateNewPassword(password, confirmPassword);
            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("email", email);
                request.setAttribute("step", "reset");
                request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
                return;
            }

            boolean updated = userService.updatePasswordByEmail(email, password);
            if (updated) {
                request.setAttribute("success", "Cập nhật mật khẩu thành công. Vui lòng đăng nhập lại.");
                request.setAttribute("step", "done");
            } else {
                request.setAttribute("error", "Cập nhật mật khẩu thất bại. Vui lòng thử lại.");
                request.setAttribute("email", email);
                request.setAttribute("step", "reset");
            }
            request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
        }
    }
}
