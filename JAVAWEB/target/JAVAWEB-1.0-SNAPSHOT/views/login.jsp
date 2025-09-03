<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .header p {
            color: #666;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .form-group input.error {
            border-color: #e74c3c;
            background: #fdf2f2;
        }
        
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(76, 175, 80, 0.3);
        }
        
        .btn:active {
            transform: translateY(0);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin-top: 15px;
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268 0%, #495057 100%);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        
        .message {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
        }
        
        .error {
            background-color: #fdf2f2;
            color: #e74c3c;
            border: 1px solid #fecaca;
        }
        
        .success {
            background-color: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }
        
        .register-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e1e5e9;
        }
        
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .register-link a:hover {
            text-decoration: underline;
        }
        
        .required {
            color: #e74c3c;
        }
        
        .forgot-password {
            text-align: right;
            margin-top: 10px;
        }
        
        .forgot-password a {
            color: #667eea;
            text-decoration: none;
            font-size: 12px;
        }
        
        .forgot-password a:hover {
            text-decoration: underline;
        }
        
        @media (max-width: 600px) {
            .container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Đăng nhập</h1>
            <p>Đăng nhập vào tài khoản của bạn</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("success") != null) { %>
            <div class="message success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="userName">Tên đăng nhập <span class="required">*</span></label>
                <input type="text" id="userName" name="userName" 
                       value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>"
                       required>
            </div>
            
            <div class="form-group">
                <label for="passWord">Mật khẩu <span class="required">*</span></label>
                <input type="password" id="passWord" name="passWord" required>
                <div class="forgot-password">
                    <a href="forgot-password">Quên mật khẩu?</a>
                </div>
            </div>
            
            <button type="submit" class="btn">Đăng nhập</button>
        </form>
        
        <div class="register-link">
            <p>Chưa có tài khoản? <a href="register">Đăng ký ngay</a></p>
            
        </div>
        
        <div style="text-align: center; margin-top: 20px;">
            <a href="index.jsp" style="color: #667eea; text-decoration: none; font-weight: 600;">← Quay lại trang chủ</a>
        </div>
    </div>
    
    <script>
        // Focus vào input đầu tiên khi trang load
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('userName').focus();
        });
        
        // Validate form trước khi submit
        document.querySelector('form').addEventListener('submit', function(e) {
            const userName = document.getElementById('userName').value.trim();
            const passWord = document.getElementById('passWord').value.trim();
            
            if (!userName) {
                e.preventDefault();
                alert('Vui lòng nhập tên đăng nhập hoặc email!');
                document.getElementById('userName').focus();
                return false;
            }
            
            if (!passWord) {
                e.preventDefault();
                alert('Vui lòng nhập mật khẩu!');
                document.getElementById('passWord').focus();
                return false;
            }
        });
    </script>
</body>
</html>
