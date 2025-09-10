<%@ taglib uri="http://www.sitemesh.org/decorator" prefix="decorator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<decorator:title>Đăng ký</decorator:title>
<decorator:head />
<div class="row justify-content-center">
  <div class="col-md-8 col-lg-6">
    <div class="card shadow-sm">
      <div class="card-body">
        <h5 class="card-title mb-3">Đăng ký tài khoản</h5>
        <% if (request.getAttribute("error") != null) { %>
          <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
          <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>
        <form action="register" method="post">
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input class="form-control" type="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required />
          </div>
          <div class="mb-3">
            <label class="form-label">Tên đăng nhập</label>
            <input class="form-control" type="text" name="userName" value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>" required />
          </div>
          <div class="mb-3">
            <label class="form-label">Họ và tên</label>
            <input class="form-control" type="text" name="fullName" value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>" required />
          </div>
          <div class="row g-2">
            <div class="col-md-6">
              <label class="form-label">Mật khẩu</label>
              <input class="form-control" type="password" name="passWord" required />
            </div>
            <div class="col-md-6">
              <label class="form-label">Xác nhận mật khẩu</label>
              <input class="form-control" type="password" name="confirmPassword" required />
            </div>
          </div>
          <div class="mb-3 mt-2">
            <label class="form-label">Số điện thoại</label>
            <input class="form-control" type="tel" name="phone" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>" />
          </div>
          <div class="d-grid gap-2">
            <button class="btn btn-primary" type="submit">Đăng ký</button>
          </div>
        </form>
        <div class="mt-3">
          <a href="login">Đã có tài khoản? Đăng nhập</a>
        </div>
      </div>
    </div>
  </div>
</div>
