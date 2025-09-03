<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0; padding: 20px; }
        .container { background: white; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); padding: 40px; width: 100%; max-width: 500px; }
        h1 { color: #333; margin-bottom: 20px; text-align: center; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #333; font-weight: 600; }
        input[type="email"], input[type="password"] { width: 100%; padding: 12px 16px; border: 2px solid #e1e5e9; border-radius: 10px; font-size: 14px; background: #f8f9fa; }
        input:focus { outline: none; border-color: #667eea; background: white; box-shadow: 0 0 0 3px rgba(102,126,234,0.1); }
        .btn { width: 100%; padding: 14px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; font-size: 16px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(102,126,234,0.3); }
        .message { padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; text-align: center; }
        .error { background-color: #fdf2f2; color: #e74c3c; border: 1px solid #fecaca; }
        .success { background-color: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        .nav { text-align: center; margin-top: 20px; }
        .nav a { color: #667eea; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Quên mật khẩu</h1>

        <% if (request.getAttribute("error") != null) { %>
            <div class="message error"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="message success"><%= request.getAttribute("success") %></div>
        <% } %>

        <% String step = (String) request.getAttribute("step"); if (step == null) step = "email"; %>

        <% if ("email".equals(step)) { %>
            <form action="forgot-password" method="post">
                <input type="hidden" name="action" value="verifyEmail" />
                <div class="form-group">
                    <label for="email">Nhập email đã đăng ký</label>
                    <input type="email" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
                </div>
                <button type="submit" class="btn">Tiếp tục</button>
            </form>
        <% } else if ("reset".equals(step)) { %>
            <form action="forgot-password" method="post">
                <input type="hidden" name="action" value="resetPassword" />
                <input type="hidden" name="email" value="<%= request.getAttribute("email") %>" />
                <div class="form-group">
                    <label for="password">Mật khẩu mới</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Nhập lại mật khẩu mới</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn">Cập nhật mật khẩu</button>
            </form>
        <% } else if ("done".equals(step)) { %>
            <div class="nav">
                <a href="login">Đến trang đăng nhập</a>
            </div>
        <% } %>

        <div class="nav" style="margin-top: 20px;">
            <a href="login">Quay lại đăng nhập</a> | <a href="index.jsp">Trang chủ</a>
        </div>
    </div>

    <script>
    const step = '<%= step %>';
    if (step === 'reset') {
        const pass = document.getElementById('password');
        const confirm = document.getElementById('confirmPassword');
        function validate() {
            if (pass.value && confirm.value && pass.value !== confirm.value) {
                confirm.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                confirm.setCustomValidity('');
            }
        }
        pass && pass.addEventListener('input', validate);
        confirm && confirm.addEventListener('input', validate);
    }
    </script>
</body>
</html>
