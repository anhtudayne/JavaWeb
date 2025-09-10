<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-lg-8 col-xl-7">
            <div class="text-center mb-4">
                <h1 class="h3 mb-1">Đăng ký tài khoản</h1>
                <p class="text-muted">Tạo tài khoản mới để bắt đầu sử dụng hệ thống</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success" role="alert"><%= request.getAttribute("success") %></div>
            <% } %>

            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <form action="register" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
                            </div>
                            <div class="col-md-6">
                                <label for="userName" class="form-label">Tên đăng nhập <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="userName" name="userName" value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>" required>
                            </div>
                            <div class="col-12">
                                <label for="fullName" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>" required>
                            </div>
                            <div class="col-md-6">
                                <label for="passWord" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="passWord" name="passWord" required>
                            </div>
                            <div class="col-md-6">
                                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            </div>
                            <div class="col-12">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input type="tel" class="form-control" id="phone" name="phone" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mt-3">Đăng ký</button>
                    </form>
                </div>
            </div>

            <div class="text-center mt-3">
                <a class="text-decoration-none" href="login">Đã có tài khoản? Đăng nhập</a> ·
                <a class="text-decoration-none" href="index.jsp">Trang chủ</a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelector('form')?.addEventListener('submit', function(e){
        const p = document.getElementById('passWord').value;
        const c = document.getElementById('confirmPassword').value;
        if (p !== c) {
            e.preventDefault();
            alert('Mật khẩu xác nhận không khớp!');
        }
    });
</script>
</body>
</html>
