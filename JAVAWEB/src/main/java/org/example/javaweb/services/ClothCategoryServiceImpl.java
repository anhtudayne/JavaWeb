package org.example.javaweb.services;

import org.example.javaweb.dao.ClothCategoryDao;
import org.example.javaweb.dao.ClothCategoryDAOImpl;
import org.example.javaweb.models.ClothCategory;
import java.util.List;

public class ClothCategoryServiceImpl implements ClothCategoryService {
    private final ClothCategoryDao dao;

    public ClothCategoryServiceImpl() {
        this.dao = new ClothCategoryDAOImpl();
    }

    @Override
    public List<ClothCategory> getByUser(int userId) {
        return dao.findByUserId(userId);
    }

    @Override
    public ClothCategory getOne(int id, int userId) {
        return dao.findByIdAndUser(id, userId);
    }

    @Override
    public boolean create(int userId, String name, String description, String imageUrl) {
        if (name == null || name.trim().isEmpty()) return false;
        ClothCategory c = new ClothCategory();
        c.setUserId(userId);
        c.setName(name.trim());
        c.setDescription(description != null ? description.trim() : null);
        c.setImageUrl(imageUrl != null ? imageUrl.trim() : null);
        return dao.insert(c);
    }

    @Override
    public boolean update(int id, int userId, String name, String description, String imageUrl) {
        if (name == null || name.trim().isEmpty()) return false;
        ClothCategory c = new ClothCategory();
        c.setId(id);
        c.setUserId(userId);
        c.setName(name.trim());
        c.setDescription(description != null ? description.trim() : null);
        c.setImageUrl(imageUrl != null ? imageUrl.trim() : null);
        return dao.update(c);
    }

    @Override
    public boolean delete(int id, int userId) {
        return dao.deleteByIdAndUser(id, userId);
    }
}
