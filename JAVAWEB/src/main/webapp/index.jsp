<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Java Web Application</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 32px;
        }
        .subtitle {
            color: #666;
            margin-bottom: 40px;
            font-size: 16px;
            line-height: 1.6;
        }
        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 10px;
            display: inline-block;
            margin: 15px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            min-width: 150px;
        }
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        .btn:active {
            transform: translateY(-1px);
        }
        .btn-login {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
        }
        .btn-login:hover {
            box-shadow: 0 10px 25px rgba(76, 175, 80, 0.3);
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .btn-register:hover {
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        .buttons-container {
            margin-top: 30px;
        }
        .welcome-icon {
            font-size: 48px;
            margin-bottom: 20px;
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome-icon">👋</div>
        <h1>Chào mừng bạn!</h1>
        <p class="subtitle">
            Chào mừng bạn đến với Web quản lí quần áo<br>
            Vui lòng chọn một trong các tùy chọn bên dưới để tiếp tục.
        </p>
        
        <div class="buttons-container">
            <a href="login" class="btn btn-login">Đăng nhập</a>
            <a href="register" class="btn btn-register">Đăng ký</a>
        </div>
        
        <div style="margin-top: 40px; padding-top: 20px; border-top: 1px solid #e1e5e9;">
            
        </div>
    </div>
</body>
</html>