import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/login")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Khi user truy cập GET /login thì forward sang trang login.jsp
        RequestDispatcher rd = req.getRequestDispatcher("/pages/login.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Lấy username & password từ form login.jsp
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        if ("vovantu".equals(user) && "123".equals(pass)) {
            // Nếu đúng thì set username và chuyển sang home.jsp
            req.setAttribute("username", user);
            RequestDispatcher rd = req.getRequestDispatcher("/pages/home.jsp");
            rd.forward(req, resp);
        } else {
            // Nếu sai thì quay lại login.jsp với thông báo lỗi
            req.setAttribute("error", "Sai username hoặc password!");
            RequestDispatcher rd = req.getRequestDispatcher("/pages/login.jsp");
            rd.forward(req, resp);
        }
    }
}
