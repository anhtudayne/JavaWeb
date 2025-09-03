package org.example.javaweb.dao;

import org.example.javaweb.models.ClothCategory;
import java.util.List;

public interface ClothCategoryDao {
    List<ClothCategory> findByUserId(int userId);
    ClothCategory findByIdAndUser(int id, int userId);
    boolean insert(ClothCategory category);
    boolean update(ClothCategory category);
    boolean deleteByIdAndUser(int id, int userId);
}
