<%@ taglib uri="http://www.sitemesh.org/decorator" prefix="decorator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<decorator:title>Quên mật khẩu</decorator:title>
<decorator:head />
<div class="row justify-content-center">
  <div class="col-md-6 col-lg-5">
    <div class="card shadow-sm">
      <div class="card-body">
        <h5 class="card-title mb-3">Quên mật khẩu</h5>
        <% if (request.getAttribute("error") != null) { %>
          <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
          <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>
        <% String step = (String) request.getAttribute("step"); if (step == null) step = "email"; %>
        <% if ("email".equals(step)) { %>
          <form action="forgot-password" method="post">
            <input type="hidden" name="action" value="verifyEmail" />
            <div class="mb-3">
              <label class="form-label">Email đã đăng ký</label>
              <input class="form-control" type="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required />
            </div>
            <div class="d-grid gap-2">
              <button class="btn btn-primary" type="submit">Tiếp tục</button>
            </div>
          </form>
        <% } else if ("reset".equals(step)) { %>
          <form action="forgot-password" method="post">
            <input type="hidden" name="action" value="resetPassword" />
            <input type="hidden" name="email" value="<%= request.getAttribute("email") %>" />
            <div class="mb-3">
              <label class="form-label">Mật khẩu mới</label>
              <input class="form-control" type="password" id="password" name="password" required />
            </div>
            <div class="mb-3">
              <label class="form-label">Nhập lại mật khẩu</label>
              <input class="form-control" type="password" id="confirmPassword" name="confirmPassword" required />
            </div>
            <div class="d-grid gap-2">
              <button class="btn btn-primary" type="submit">Cập nhật</button>
            </div>
          </form>
        <% } else if ("done".equals(step)) { %>
          <div class="alert alert-success">Cập nhật mật khẩu thành công. <a href="login">Đến trang đăng nhập</a></div>
        <% } %>
      </div>
    </div>
  </div>
</div>
<script>
  const step = '<%= step %>';
  if (step === 'reset') {
    const pass = document.getElementById('password');
    const confirm = document.getElementById('confirmPassword');
    function validate(){ confirm.setCustomValidity(pass.value && confirm.value && pass.value !== confirm.value ? 'Mật khẩu xác nhận không khớp' : ''); }
    pass && pass.addEventListener('input', validate);
    confirm && confirm.addEventListener('input', validate);
  }
</script>
