package org.example.javaweb.services;

import org.example.javaweb.models.User;
import java.util.List;

public interface UserService {
    
    /**
     * Lấy tất cả users
     * @return List<User> - Danh sách tất cả users
     */
    List<User> getAllUsers();
    
    /**
     * Tìm user theo ID
     * @param id - ID của user cần tìm
     * @return User - User tìm được hoặc null nếu không tìm thấy
     */
    User getUserById(int id);
    
    /**
     * Tìm user theo email
     * @param email - Email của user cần tìm
     * @return User - User tìm được hoặc null nếu không tìm thấy
     */
    User getUserByEmail(String email);
    
    /**
     * Tìm user theo userName
     * @param userName - UserName của user cần tìm
     * @return User - User tìm được hoặc null nếu không tìm thấy
     */
    User getUserByUserName(String userName);
    
    /**
     * Đăng ký user mới
     * @param user - User cần đăng ký
     * @return boolean - true nếu đăng ký thành công, false nếu thất bại
     */
    boolean registerUser(User user);
    
    /**
     * Đăng ký user mới với thông tin cơ bản
     * @param email - Email của user
     * @param userName - UserName của user
     * @param fullName - Họ tên đầy đủ
     * @param passWord - Mật khẩu
     * @param phone - Số điện thoại (có thể null)
     * @return boolean - true nếu đăng ký thành công, false nếu thất bại
     */
    boolean registerUser(String email, String userName, String fullName, String passWord, String phone);
    
    /**
     * Cập nhật thông tin user
     * @param user - User cần cập nhật
     * @return boolean - true nếu cập nhật thành công, false nếu thất bại
     */
    boolean updateUser(User user);
    
    /**
     * Xóa user
     * @param id - ID của user cần xóa
     * @return boolean - true nếu xóa thành công, false nếu thất bại
     */
    boolean deleteUser(int id);
    
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
     * Validate thông tin đăng ký
     * @param email - Email cần validate
     * @param userName - UserName cần validate
     * @param fullName - Họ tên cần validate
     * @param passWord - Mật khẩu cần validate
     * @return String - Thông báo lỗi hoặc null nếu hợp lệ
     */
    String validateRegistration(String email, String userName, String fullName, String passWord);
    
    /**
     * Đăng nhập user bằng userName và password (không dùng email)
     * @param userName - UserName của user
     * @param password - Mật khẩu của user
     * @return User - User nếu đăng nhập thành công, null nếu thất bại
     */
    User loginUser(String userName, String password);
    
    /**
     * Validate thông tin đăng nhập bằng userName và password
     * @param userName - UserName cần validate
     * @param password - Mật khẩu cần validate
     * @return String - Thông báo lỗi hoặc null nếu hợp lệ
     */
    String validateLogin(String userName, String password);
    
    // Quên mật khẩu
    String forgotPassword(String email);
    String validateForgotPasswordEmail(String email);
    boolean updatePasswordByEmail(String email, String newPassword);
    String validateNewPassword(String password, String confirmPassword);
}
