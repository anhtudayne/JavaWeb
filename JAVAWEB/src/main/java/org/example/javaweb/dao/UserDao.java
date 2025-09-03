package org.example.javaweb.dao;

import org.example.javaweb.models.User;
import java.util.List;

public interface UserDao {
    
    /**
     * Lấy tất cả users từ database
     * @return List<User> - Danh sách tất cả users
     */
    List<User> findAll();
    
    /**
     * Tìm user theo ID
     * @param id - ID của user cần tìm
     * @return User - User tìm được hoặc null nếu không tìm thấy
     */
    User findById(int id);
    
    /**
     * Tìm user theo email
     * @param email - Email của user cần tìm
     * @return User - User tìm được hoặc null nếu không tìm thấy
     */
    User findByEmail(String email);
    
    /**
     * Tìm user theo userName
     * @param userName - UserName của user cần tìm
     * @return User - User tìm được hoặc null nếu không tìm thấy
     */
    User findByUserName(String userName);
    
    /**
     * Thêm user mới vào database
     * @param user - User cần thêm
     * @return boolean - true nếu thêm thành công, false nếu thất bại
     */
    boolean insert(User user);
    
    /**
     * Cập nhật thông tin user
     * @param user - User cần cập nhật
     * @return boolean - true nếu cập nhật thành công, false nếu thất bại
     */
    boolean update(User user);
    
    /**
     * Xóa user theo ID
     * @param id - ID của user cần xóa
     * @return boolean - true nếu xóa thành công, false nếu thất bại
     */
    boolean delete(int id);
    
    /**
     * Kiểm tra email đã tồn tại chưa
     * @param email - Email cần kiểm tra
     * @return boolean - true nếu email đã tồn tại, false nếu chưa
     */
    boolean isEmailExists(String email);
    
    /**
     * Kiểm tra userName đã tồn tại chưa
     * @param userName - UserName cần kiểm tra
     * @return boolean - true nếu userName đã tồn tại, false nếu chưa
     */
    boolean isUserNameExists(String userName);
    
    /**
     * Xác thực user đăng nhập bằng userName và password 
     * @param userName - UserName của user
     * @param password - Mật khẩu của user
     * @return User - User nếu xác thực thành công, null nếu thất bại
     */
    User authenticateUser(String userName, String password);
    
    // Forgot password: update password by email
    boolean updatePasswordByEmail(String email, String newPassword);
}
