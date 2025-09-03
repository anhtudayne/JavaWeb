package org.example.javaweb.controllers;

import org.example.javaweb.services.UserService;
import org.example.javaweb.services.UserServiceImpl;
import org.example.javaweb.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("home");
            return;
        }
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String userName = request.getParameter("userName");
        String password = request.getParameter("passWord");
        
        if (userName == null || userName.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin đăng nhập");
            request.setAttribute("userName", userName);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        String validationError = userService.validateLogin(userName, password);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("userName", userName);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        User user = userService.loginUser(userName, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getUserName());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("roleId", user.getRoleId());
            response.sendRedirect("home");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.setAttribute("userName", userName);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
