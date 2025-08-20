package vn.iotstar.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LoginCookie")
public class LoginCookie extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        response.setContentType("text/html;charset=UTF-8");

        // Giả sử user=admin, pass=123
        if ("admin".equals(user) && "123".equals(pass)) {
            // Tạo cookie username
            Cookie ck = new Cookie("username", user);
            ck.setMaxAge(60*5); // tồn tại 5 phút
            response.addCookie(ck);

            response.getWriter().println("<h3>Đăng nhập thành công bằng Cookie!</h3>");
            response.getWriter().println("<a href='WelcomeCookie'>Vào trang Welcome</a><br>");
            response.getWriter().println("<a href='LogoutCookie'>Đăng xuất</a>");
        } else {
            response.getWriter().println("<h3>Sai username hoặc password!</h3>");
            response.getWriter().println("<a href='login.html'>Thử lại</a>");
        }
    }
}
