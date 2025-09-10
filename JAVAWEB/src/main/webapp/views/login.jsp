<%@ taglib uri="http://www.sitemesh.org/decorator" prefix="decorator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<decorator:title>Đăng nhập</decorator:title>
<decorator:head />
<div class="row justify-content-center">
  <div class="col-md-6 col-lg-4">
    <div class="card shadow-sm">
      <div class="card-body">
        <h5 class="card-title mb-3">Đăng nhập</h5>
        <% if (request.getAttribute("error") != null) { %>
          <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
          <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>
        <form action="login" method="post">
          <div class="mb-3">
            <label class="form-label">Tên đăng nhập</label>
            <input class="form-control" type="text" name="userName" value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>" required />
          </div>
          <div class="mb-3">
            <label class="form-label">Mật khẩu</label>
            <input class="form-control" type="password" name="passWord" required />
          </div>
          <div class="d-grid gap-2">
            <button class="btn btn-primary" type="submit">Đăng nhập</button>
          </div>
        </form>
        <div class="mt-3 d-flex justify-content-between">
          <a href="register">Đăng ký</a>
          <a href="forgot-password">Quên mật khẩu?</a>
        </div>
      </div>
    </div>
  </div>
</div>
