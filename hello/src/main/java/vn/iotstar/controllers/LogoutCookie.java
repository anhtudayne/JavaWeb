package vn.iotstar.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LogoutCookie")
public class LogoutCookie extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Xóa cookie bằng cách setMaxAge=0
        Cookie ck = new Cookie("username", "");
        ck.setMaxAge(0);
        response.addCookie(ck);

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<h3>Đã logout (Cookie)</h3>");
        response.getWriter().println("<a href='login.html'>Login lại</a>");
    }
}
