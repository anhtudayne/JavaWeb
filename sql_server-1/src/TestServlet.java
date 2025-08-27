import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/sqlTest")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = "jdbc:sqlserver://localhost:1433;databaseName=NORTHWND;encrypt=true;trustServerCertificate=true";
        String user = "sa";
        String password = "vovantu123456";

        List<String> customers = new ArrayList<>();

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection(url, user, password);

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT TOP 5 CompanyName FROM Customers");

            while (rs.next()) {
                customers.add(rs.getString("CompanyName"));
            }

            conn.close();
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        // Đẩy danh sách khách hàng sang JSP
        request.setAttribute("customers", customers);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/customers.jsp");
        rd.forward(request, response);
    }
}
