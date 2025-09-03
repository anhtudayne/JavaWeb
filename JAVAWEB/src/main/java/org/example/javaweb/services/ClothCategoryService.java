package org.example.javaweb.services;

import org.example.javaweb.models.ClothCategory;
import java.util.List;

public interface ClothCategoryService {
    List<ClothCategory> getByUser(int userId);
    ClothCategory getOne(int id, int userId);
    boolean create(int userId, String name, String description, String imageUrl);
    boolean update(int id, int userId, String name, String description, String imageUrl);
    boolean delete(int id, int userId);
}
