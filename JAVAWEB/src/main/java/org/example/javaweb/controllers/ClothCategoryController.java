package org.example.javaweb.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import org.example.javaweb.services.ClothCategoryService;
import org.example.javaweb.services.ClothCategoryServiceImpl;

@WebServlet(name = "ClothCategoryController", urlPatterns = {"/categories"})
public class ClothCategoryController extends HttpServlet {
    private ClothCategoryService service;

    @Override
    public void init() throws ServletException {
        service = new ClothCategoryServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }
        int userId = Integer.parseInt(String.valueOf(session.getAttribute("userId")));
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            service.create(userId, name, description, imageUrl);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            service.update(id, userId, name, description, imageUrl);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            service.delete(id, userId);
        }
        response.sendRedirect("home");
    }
}
