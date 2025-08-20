package vn.iotstar.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/WelcomeSession")
public class WelcomeSession extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // không tạo mới nếu chưa có
        String name = (session != null) ? (String) session.getAttribute("username") : null;

        response.setContentType("text/html;charset=UTF-8");
        if (name != null) {
            response.getWriter().println("<h2>Xin chào " + name + " (Session)</h2>");
            response.getWriter().println("<a href='LogoutSession'>Đăng xuất</a>");
        } else {
            response.getWriter().println("<h3>Bạn chưa đăng nhập!</h3>");
            response.getWriter().println("<a href='login_session.html'>Login</a>");
        }
    }
}
