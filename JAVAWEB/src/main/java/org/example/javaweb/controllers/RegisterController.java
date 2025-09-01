package org.example.javaweb.controllers;

import org.example.javaweb.services.UserService;
import org.example.javaweb.services.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hiển thị form đăng ký
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý đăng ký
        request.setCharacterEncoding("UTF-8");
        
        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String userName = request.getParameter("userName");
        String fullName = request.getParameter("fullName");
        String passWord = request.getParameter("passWord");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        
        // Validate cơ bản
        if (email == null || email.trim().isEmpty() ||
            userName == null || userName.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty() ||
            passWord == null || passWord.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            request.setAttribute("email", email);
            request.setAttribute("userName", userName);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra mật khẩu xác nhận
        if (!passWord.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.setAttribute("email", email);
            request.setAttribute("userName", userName);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Validate thông tin đăng ký
        String validationError = userService.validateRegistration(email, userName, fullName, passWord);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("email", email);
            request.setAttribute("userName", userName);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email và userName đã tồn tại chưa
        if (userService.isEmailExists(email)) {
            request.setAttribute("error", "Email đã được sử dụng. Vui lòng chọn email khác");
            request.setAttribute("email", "");
            request.setAttribute("userName", userName);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        if (userService.isUserNameExists(userName)) {
            request.setAttribute("error", "UserName đã được sử dụng. Vui lòng chọn userName khác");
            request.setAttribute("email", email);
            request.setAttribute("userName", "");
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Thực hiện đăng ký
        boolean success = userService.registerUser(email, userName, fullName, passWord, phone);
        
        if (success) {
            // Đăng ký thành công
            request.setAttribute("success", "Đăng ký thành công! Bạn có thể đăng nhập ngay bây giờ.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        } else {
            // Đăng ký thất bại
            request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại sau.");
            request.setAttribute("email", email);
            request.setAttribute("userName", userName);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
