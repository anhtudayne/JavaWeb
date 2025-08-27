import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;


@WebServlet("/home")
public class Home extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = "guest";
        
        request.setAttribute("username", username);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/home.jsp");
        rd.forward(request, response);
    }
}
