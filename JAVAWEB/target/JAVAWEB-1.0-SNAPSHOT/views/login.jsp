<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-6 col-lg-5">
            <div class="text-center mb-4">
                <h1 class="h3 mb-1">Đăng nhập</h1>
                <p class="text-muted">Đăng nhập vào tài khoản của bạn</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success" role="alert"><%= request.getAttribute("success") %></div>
            <% } %>

            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <form action="login" method="post">
                        <div class="mb-3">
                            <label for="userName" class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="userName" name="userName" value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>" required>
                        </div>
                        <div class="mb-2">
                            <label for="passWord" class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" id="passWord" name="passWord" required>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <div></div>
                            <a class="small" href="forgot-password">Quên mật khẩu?</a>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                    </form>
                </div>
            </div>

            <div class="text-center mt-3">
                <p class="mb-2">Chưa có tài khoản? <a href="register">Đăng ký ngay</a></p>
                <a class="text-decoration-none" href="index.jsp">← Quay lại trang chủ</a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function(){
        document.getElementById('userName').focus();
    });
</script>
</body>
</html>
