<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-7 col-lg-6">
            <div class="text-center mb-4">
                <h1 class="h3 mb-1">Quên mật khẩu</h1>
                <p class="text-muted">Xác thực email và đặt lại mật khẩu mới</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success" role="alert"><%= request.getAttribute("success") %></div>
            <% } %>

            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <% String step = (String) request.getAttribute("step"); if (step == null) step = "email"; %>
                    <% if ("email".equals(step)) { %>
                        <form action="forgot-password" method="post">
                            <input type="hidden" name="action" value="verifyEmail" />
                            <div class="mb-3">
                                <label for="email" class="form-label">Nhập email đã đăng ký</label>
                                <input type="email" class="form-control" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Tiếp tục</button>
                        </form>
                    <% } else if ("reset".equals(step)) { %>
                        <form action="forgot-password" method="post">
                            <input type="hidden" name="action" value="resetPassword" />
                            <input type="hidden" name="email" value="<%= request.getAttribute("email") %>" />
                            <div class="mb-3">
                                <label for="password" class="form-label">Mật khẩu mới</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Nhập lại mật khẩu mới</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Cập nhật mật khẩu</button>
                        </form>
                    <% } else if ("done".equals(step)) { %>
                        <div class="text-center">
                            <a class="btn btn-success" href="login">Đến trang đăng nhập</a>
                        </div>
                    <% } %>
                </div>
            </div>

            <div class="text-center mt-3">
                <a class="text-decoration-none" href="login">Quay lại đăng nhập</a> ·
                <a class="text-decoration-none" href="index.jsp">Trang chủ</a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const pass = document.getElementById('password');
    const confirm = document.getElementById('confirmPassword');
    function validate(){ if(pass && confirm){ confirm.setCustomValidity(pass.value!==confirm.value? 'Mật khẩu xác nhận không khớp' : ''); } }
    pass && pass.addEventListener('input', validate);
    confirm && confirm.addEventListener('input', validate);
</script>
</body>
</html>
