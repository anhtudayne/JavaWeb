package org.example.javaweb.models;

import java.time.LocalDateTime;

public class User {
    private int id;
    private String email;
    private String userName;
    private String fullName;
    private String passWord;
    private String avatar;
    private int roleId;
    private String phone;
    private LocalDateTime createdDate;
    
    // Constructor mặc định
    public User() {}
    
    // Constructor với tham số cơ bản
    public User(String email, String userName, String fullName, String passWord, int roleId) {
        this.email = email;
        this.userName = userName;
        this.fullName = fullName;
        this.passWord = passWord;
        this.roleId = roleId;
    }
    
    // Constructor đầy đủ
    public User(int id, String email, String userName, String fullName, String passWord, 
                String avatar, int roleId, String phone, LocalDateTime createdDate) {
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.fullName = fullName;
        this.passWord = passWord;
        this.avatar = avatar;
        this.roleId = roleId;
        this.phone = phone;
        this.createdDate = createdDate;
    }
    
    // Getters và Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getPassWord() {
        return passWord;
    }
    
    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }
    
    public String getAvatar() {
        return avatar;
    }
    
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    public int getRoleId() {
        return roleId;
    }
    
    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public LocalDateTime getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", userName='" + userName + '\'' +
                ", fullName='" + fullName + '\'' +
                ", passWord='" + passWord + '\'' +
                ", avatar='" + avatar + '\'' +
                ", roleId=" + roleId +
                ", phone='" + phone + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }
}
