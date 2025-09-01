<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản</title>
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
            max-width: 500px;
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
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        
        .btn:active {
            transform: translateY(0);
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
        
        .login-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e1e5e9;
        }
        
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .required {
            color: #e74c3c;
        }
        
        @media (max-width: 600px) {
            .container {
                padding: 30px 20px;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Đăng ký tài khoản</h1>
            <p>Tạo tài khoản mới để bắt đầu sử dụng hệ thống</p>
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
        
        <form action="register" method="post">
            <div class="form-group">
                <label for="email">Email <span class="required">*</span></label>
                <input type="email" id="email" name="email" 
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                       required>
            </div>
            
            <div class="form-group">
                <label for="userName">Tên đăng nhập <span class="required">*</span></label>
                <input type="text" id="userName" name="userName" 
                       value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>"
                       required>
            </div>
            
            <div class="form-group">
                <label for="fullName">Họ và tên <span class="required">*</span></label>
                <input type="text" id="fullName" name="fullName" 
                       value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>"
                       required>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="passWord">Mật khẩu <span class="required">*</span></label>
                    <input type="password" id="passWord" name="passWord" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu <span class="required">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="tel" id="phone" name="phone" 
                       value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">
            </div>
            
            <button type="submit" class="btn">Đăng ký</button>
        </form>
        
        
    </div>
    
    <script>
        // Validate form trước khi submit
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('passWord').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
                return false;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return false;
            }
        });
        
        // Real-time validation
        document.getElementById('passWord').addEventListener('input', function() {
            const password = this.value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (confirmPassword && password !== confirmPassword) {
                document.getElementById('confirmPassword').classList.add('error');
            } else {
                document.getElementById('confirmPassword').classList.remove('error');
            }
        });
        
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('passWord').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.classList.add('error');
            } else {
                this.classList.remove('error');
            }
        });
    </script>
</body>
</html>
