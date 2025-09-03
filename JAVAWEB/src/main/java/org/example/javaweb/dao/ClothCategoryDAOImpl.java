package org.example.javaweb.dao;

import org.example.javaweb.configs.DBConnection;
import org.example.javaweb.models.ClothCategory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClothCategoryDAOImpl implements ClothCategoryDao {
    @Override
    public List<ClothCategory> findByUserId(int userId) {
        List<ClothCategory> list = new ArrayList<>();
        String sql = "SELECT id, userId, name, description, imageUrl, createdAt, updatedAt FROM ClothCategory WHERE userId = ? ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ClothCategory c = map(rs);
                    list.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public ClothCategory findByIdAndUser(int id, int userId) {
        String sql = "SELECT id, userId, name, description, imageUrl, createdAt, updatedAt FROM ClothCategory WHERE id = ? AND userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(ClothCategory category) {
        String sql = "INSERT INTO ClothCategory (userId, name, description, imageUrl, createdAt, updatedAt) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, category.getUserId());
            ps.setString(2, category.getName());
            ps.setString(3, category.getDescription());
            ps.setString(4, category.getImageUrl());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) { if (keys.next()) category.setId(keys.getInt(1)); }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(ClothCategory category) {
        String sql = "UPDATE ClothCategory SET name = ?, description = ?, imageUrl = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ? AND userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getImageUrl());
            ps.setInt(4, category.getId());
            ps.setInt(5, category.getUserId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteByIdAndUser(int id, int userId) {
        String sql = "DELETE FROM ClothCategory WHERE id = ? AND userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private ClothCategory map(ResultSet rs) throws SQLException {
        ClothCategory c = new ClothCategory();
        c.setId(rs.getInt("id"));
        c.setUserId(rs.getInt("userId"));
        c.setName(rs.getString("name"));
        c.setDescription(rs.getString("description"));
        c.setImageUrl(rs.getString("imageUrl"));
        Timestamp ca = rs.getTimestamp("createdAt");
        Timestamp ua = rs.getTimestamp("updatedAt");
        if (ca != null) c.setCreatedAt(ca.toLocalDateTime());
        if (ua != null) c.setUpdatedAt(ua.toLocalDateTime());
        return c;
    }
}
