package org.example.javaweb.services;

import org.example.javaweb.dao.UserDao;
import org.example.javaweb.dao.UserDAOImpl;
import org.example.javaweb.models.User;
import java.util.List;

public class UserServiceImpl implements UserService {
    
    private UserDao userDao;
    
    public UserServiceImpl() {
        this.userDao = new UserDAOImpl();
    }
    
    @Override
    public List<User> getAllUsers() {
        return userDao.findAll();
    }
    
    @Override
    public User getUserById(int id) {
        return userDao.findById(id);
    }
    
    @Override
    public User getUserByEmail(String email) {
        return userDao.findByEmail(email);
    }
    
    @Override
    public User getUserByUserName(String userName) {
        return userDao.findByUserName(userName);
    }
    
    @Override
    public boolean registerUser(User user) {
        // Validate dữ liệu trước khi đăng ký
        String validationError = validateRegistration(
            user.getEmail(), 
            user.getUserName(), 
            user.getFullName(), 
            user.getPassWord()
        );
        
        if (validationError != null) {
            System.err.println("Lỗi validation: " + validationError);
            return false;
        }
        
        // Kiểm tra email và userName đã tồn tại chưa
        if (userDao.isEmailExists(user.getEmail())) {
            System.err.println("Email đã tồn tại: " + user.getEmail());
            return false;
        }
        
        if (userDao.isUserNameExists(user.getUserName())) {
            System.err.println("UserName đã tồn tại: " + user.getUserName());
            return false;
        }
        
        // Mặc định roleId = 2 (user thường), roleId = 1 là admin
        if (user.getRoleId() == 0) {
            user.setRoleId(2);
        }
        
        // Thực hiện đăng ký
        return userDao.insert(user);
    }
    
    @Override
    public boolean registerUser(String email, String userName, String fullName, String passWord, String phone) {
        User user = new User(email, userName, fullName, passWord, 2); // roleId = 2 (user thường)
        user.setPhone(phone);
        return registerUser(user);
    }
    
    @Override
    public boolean updateUser(User user) {
        // Validate dữ liệu cơ bản
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            return false;
        }
        
        if (user.getPassWord() == null || user.getPassWord().trim().isEmpty()) {
            return false;
        }
        
        return userDao.update(user);
    }
    
    @Override
    public boolean deleteUser(int id) {
        return userDao.delete(id);
    }
    
    @Override
    public boolean isEmailExists(String email) {
        return userDao.isEmailExists(email);
    }
    
    @Override
    public boolean isUserNameExists(String userName) {
        return userDao.isUserNameExists(userName);
    }
    
    @Override
    public String validateRegistration(String email, String userName, String fullName, String passWord) {
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống";
        }
        
        if (!isValidEmail(email.trim())) {
            return "Email không hợp lệ";
        }
        
        // Validate userName
        if (userName == null || userName.trim().isEmpty()) {
            return "UserName không được để trống";
        }
        
        if (userName.trim().length() < 3) {
            return "UserName phải có ít nhất 3 ký tự";
        }
        
        if (userName.trim().length() > 50) {
            return "UserName không được quá 50 ký tự";
        }
        
        if (!userName.trim().matches("^[a-zA-Z0-9_]+$")) {
            return "UserName chỉ được chứa chữ cái, số và dấu gạch dưới";
        }
        
        // Validate fullName
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Họ tên không được để trống";
        }
        
        if (fullName.trim().length() < 2) {
            return "Họ tên phải có ít nhất 2 ký tự";
        }
        
        if (fullName.trim().length() > 100) {
            return "Họ tên không được quá 100 ký tự";
        }
        
        // Validate password
        if (passWord == null || passWord.trim().isEmpty()) {
            return "Mật khẩu không được để trống";
        }
        
        if (passWord.trim().length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }
        
        if (passWord.trim().length() > 255) {
            return "Mật khẩu không được quá 255 ký tự";
        }
        
        return null; // Không có lỗi
    }
    
    /**
     * Kiểm tra email có hợp lệ không
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
}
