package vn.iotstar.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginSession")
public class LoginSession extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        response.setContentType("text/html;charset=UTF-8");

        // Giả sử tài khoản đúng là admin/123
        if ("admin".equals(user) && "123".equals(pass)) {
            // Tạo session
            HttpSession session = request.getSession();
            session.setAttribute("username", user); // lưu username vào session

            response.getWriter().println("<h3>Đăng nhập thành công bằng Session!</h3>");
            response.getWriter().println("<a href='WelcomeSession'>Vào trang Welcome</a><br>");
            response.getWriter().println("<a href='LogoutSession'>Đăng xuất</a>");
        } else {
            response.getWriter().println("<h3>Sai username hoặc password!</h3>");
            response.getWriter().println("<a href='login_session.html'>Thử lại</a>");
        }
    }
}
