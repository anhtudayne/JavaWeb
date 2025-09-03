package org.example.javaweb.dao;

import org.example.javaweb.configs.DBConnection;
import org.example.javaweb.models.User;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDao {
    
    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, email, userName, fullName, passWord, avatar, roleId, phone, createdDate FROM users ORDER BY id";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("userName"));
                user.setFullName(rs.getString("fullName"));
                user.setPassWord(rs.getString("passWord"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                user.setPhone(rs.getString("phone"));
                
                Timestamp timestamp = rs.getTimestamp("createdDate");
                if (timestamp != null) {
                    user.setCreatedDate(timestamp.toLocalDateTime());
                }
                
                users.add(user);
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy danh sách users: " + e.getMessage());
            e.printStackTrace();
        }
        
        return users;
    }
    
    @Override
    public User findById(int id) {
        String sql = "SELECT id, email, userName, fullName, passWord, avatar, roleId, phone, createdDate FROM users WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("userName"));
                user.setFullName(rs.getString("fullName"));
                user.setPassWord(rs.getString("passWord"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                user.setPhone(rs.getString("phone"));
                
                Timestamp timestamp = rs.getTimestamp("createdDate");
                if (timestamp != null) {
                    user.setCreatedDate(timestamp.toLocalDateTime());
                }
                
                return user;
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm user với ID " + id + ": " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public User findByEmail(String email) {
        String sql = "SELECT id, email, userName, fullName, passWord, avatar, roleId, phone, createdDate FROM users WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("userName"));
                user.setFullName(rs.getString("fullName"));
                user.setPassWord(rs.getString("passWord"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                user.setPhone(rs.getString("phone"));
                
                Timestamp timestamp = rs.getTimestamp("createdDate");
                if (timestamp != null) {
                    user.setCreatedDate(timestamp.toLocalDateTime());
                }
                
                return user;
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm user với email " + email + ": " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public User findByUserName(String userName) {
        String sql = "SELECT id, email, userName, fullName, passWord, avatar, roleId, phone, createdDate FROM users WHERE userName = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userName);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("userName"));
                user.setFullName(rs.getString("fullName"));
                user.setPassWord(rs.getString("passWord"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                user.setPhone(rs.getString("phone"));
                
                Timestamp timestamp = rs.getTimestamp("createdDate");
                if (timestamp != null) {
                    user.setCreatedDate(timestamp.toLocalDateTime());
                }
                
                return user;
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm user với userName " + userName + ": " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public boolean insert(User user) {
        String sql = "INSERT INTO users (email, userName, fullName, passWord, avatar, roleId, phone, createdDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getUserName());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPassWord());
            stmt.setString(5, user.getAvatar());
            stmt.setInt(6, user.getRoleId());
            stmt.setString(7, user.getPhone());
            
            // Sử dụng thời gian hiện tại nếu không có
            LocalDateTime createdDate = user.getCreatedDate();
            if (createdDate == null) {
                createdDate = LocalDateTime.now();
            }
            stmt.setTimestamp(8, Timestamp.valueOf(createdDate));
            
            int rowsInserted = stmt.executeUpdate();
            
            if (rowsInserted > 0) {
                // Lấy ID được tạo tự động
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                }
                return true;
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi thêm user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public boolean update(User user) {
        String sql = "UPDATE users SET email = ?, userName = ?, fullName = ?, passWord = ?, avatar = ?, roleId = ?, phone = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getUserName());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPassWord());
            stmt.setString(5, user.getAvatar());
            stmt.setInt(6, user.getRoleId());
            stmt.setString(7, user.getPhone());
            stmt.setInt(8, user.getId());
            
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
            
        } catch (Exception e) {
            System.err.println("Lỗi khi cập nhật user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
            
        } catch (Exception e) {
            System.err.println("Lỗi khi xóa user với ID " + id + ": " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi kiểm tra email tồn tại: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public boolean isUserNameExists(String userName) {
        String sql = "SELECT COUNT(*) FROM users WHERE userName = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userName);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi kiểm tra userName tồn tại: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public User authenticateUser(String userName, String password) {
        // Tìm user theo userName và password 
        String sql = "SELECT id, email, userName, fullName, passWord, avatar, roleId, phone, createdDate FROM users WHERE userName = ? AND passWord = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userName);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("userName"));
                user.setFullName(rs.getString("fullName"));
                user.setPassWord(rs.getString("passWord"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                user.setPhone(rs.getString("phone"));
                
                Timestamp timestamp = rs.getTimestamp("createdDate");
                if (timestamp != null) {
                    user.setCreatedDate(timestamp.toLocalDateTime());
                }
                
                return user;
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi xác thực user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE users SET passWord = ? WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Lỗi khi cập nhật mật khẩu theo email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
