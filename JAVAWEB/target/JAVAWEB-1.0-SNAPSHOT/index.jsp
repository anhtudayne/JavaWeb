<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Tự động chuyển hướng đến trang register
    response.sendRedirect("register");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Java Web Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin: 10px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .redirect-message {
            background-color: #e3f2fd;
            color: #1976d2;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #bbdefb;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="redirect-message">
            <p>Đang chuyển hướng đến trang đăng ký...</p>
            <p>Nếu không tự động chuyển hướng, vui lòng <a href="register">click vào đây</a></p>
        </div>
        
        <h1>Java Web Application</h1>
        <p>Chào mừng bạn đến với ứng dụng quản lý User!</p>
        
        <a href="register" class="btn">Đăng ký tài khoản</a>
        <a href="users" class="btn btn-secondary">Xem danh sách Users</a>
    </div>
    
    <script>
        // Tự động chuyển hướng sau 2 giây
        setTimeout(function() {
            window.location.href = 'register';
        }, 2000);
    </script>
</body>
</html>