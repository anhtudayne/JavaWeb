package vn.iotstar.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/WelcomeCookie")
public class WelcomeCookie extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Cookie[] cookies = request.getCookies();
        String name = null;
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("username")) {
                    name = c.getValue();
                }
            }
        }

        response.setContentType("text/html;charset=UTF-8");
        if (name != null) {
            response.getWriter().println("<h2>Xin chào " + name + " (Cookie)</h2>");
            response.getWriter().println("<a href='LogoutCookie'>Đăng xuất</a>");
        } else {
            response.getWriter().println("<h3>Bạn chưa đăng nhập!</h3>");
            response.getWriter().println("<a href='login.html'>Đăng nhập</a>");
        }
    }
}
