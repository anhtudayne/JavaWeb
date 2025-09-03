package org.example.javaweb.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import org.example.javaweb.dao.ClothCategoryDao;
import org.example.javaweb.dao.ClothCategoryDAOImpl;
import org.example.javaweb.models.ClothCategory;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj != null) {
            int userId = Integer.parseInt(userIdObj.toString());
            ClothCategoryDao dao = new ClothCategoryDAOImpl();
            List<ClothCategory> categories = dao.findByUserId(userId);
            request.setAttribute("categories", categories);
        }
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}
