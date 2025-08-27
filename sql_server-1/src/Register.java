import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class Register extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Khi user truy cập GET /login thì forward sang trang login.jsp
        RequestDispatcher rd = req.getRequestDispatcher("/pages/register.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=sql_test_1;encrypt=true;trustServerCertificate=true;";
        String dbUser = "sa";
        String dbPass = "vovantu123456";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Kết nối
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            // Câu lệnh insert
            String sql = "INSERT INTO Users(username, password) VALUES (?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user);
            stmt.setString(2, pass);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                resp.getWriter().println("Add user successfull!");
            } else {
                resp.getWriter().println("Add user failure!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

}
