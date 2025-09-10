<%@ taglib uri="http://www.sitemesh.org/decorator" prefix="decorator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.javaweb.models.ClothCategory" %>
<decorator:title>Trang chủ</decorator:title>
<decorator:head />
<%
    Object fullNameObj = session.getAttribute("fullName");
    String fullName = fullNameObj != null ? fullNameObj.toString() : "";
    Object userNameObj = session.getAttribute("userName");
    String userName = userNameObj != null ? userNameObj.toString() : "";
    List<ClothCategory> categories = (List<ClothCategory>) request.getAttribute("categories");
%>
<div class="d-flex align-items-center justify-content-between mb-3">
  <div>
    <h4 class="mb-0">Bảng điều khiển</h4>
    <div class="text-muted">Xin chào, <strong><%= (fullName != null && !fullName.isEmpty()) ? fullName : userName %></strong></div>
  </div>
  <a class="btn btn-outline-danger" href="logout">Đăng xuất</a>
</div>

<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab">Thông tin cá nhân</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="pills-clothes-tab" data-bs-toggle="pill" data-bs-target="#pills-clothes" type="button" role="tab">Danh mục quần áo</button>
  </li>
</ul>
<div class="tab-content" id="pills-tabContent">
  <div class="tab-pane fade show active" id="pills-profile" role="tabpanel">
    <div class="card">
      <div class="card-body">
        <h6 class="card-title">Thông tin cá nhân</h6>
        <table class="table table-sm">
          <tr><th>Thuộc tính</th><th>Giá trị</th></tr>
          <tr><td>Tên đăng nhập</td><td class="text-muted"><%= userName %></td></tr>
          <tr><td>Họ và tên</td><td class="text-muted"><%= fullName %></td></tr>
        </table>
      </div>
    </div>
  </div>
  <div class="tab-pane fade" id="pills-clothes" role="tabpanel">
    <div class="card">
      <div class="card-body">
        <h6 class="card-title">Danh mục quần áo của bạn</h6>
        <form class="row g-2 mb-3" action="categories" method="post">
          <input type="hidden" name="action" value="create" />
          <div class="col-md-3"><input class="form-control" type="text" name="name" placeholder="Tên danh mục" required /></div>
          <div class="col-md-4"><input class="form-control" type="text" name="description" placeholder="Mô tả" /></div>
          <div class="col-md-4"><input class="form-control" type="url" name="imageUrl" placeholder="Link hình ảnh" /></div>
          <div class="col-md-1 d-grid"><button class="btn btn-primary" type="submit">Thêm</button></div>
        </form>
        <div class="table-responsive">
          <table class="table align-middle">
            <thead>
              <tr>
                <th>#</th>
                <th>Hình ảnh</th>
                <th>Tên danh mục</th>
                <th>Mô tả</th>
                <th>Ngày tạo</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
            <%
              if (categories != null && !categories.isEmpty()) {
                int i = 1;
                for (ClothCategory c : categories) {
            %>
              <tr>
                <td><%= i %></td>
                <td>
                  <% if (c.getImageUrl() != null && !c.getImageUrl().isEmpty()) { %>
                    <img src="<%= c.getImageUrl() %>" alt="img" style="width:44px;height:44px;border-radius:8px;object-fit:cover;border:1px solid #e5e7eb;" />
                  <% } else { %>
                    <span class="text-muted">Không ảnh</span>
                  <% } %>
                </td>
                <td><%= c.getName() %></td>
                <td class="text-muted"><%= c.getDescription() != null ? c.getDescription() : "" %></td>
                <td class="text-muted"><%= c.getCreatedAt() != null ? c.getCreatedAt() : "" %></td>
                <td>
                  <div class="d-flex gap-2">
                    <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="collapse" data-bs-target="#edit-<%= c.getId() %>">Sửa</button>
                    <form action="categories" method="post" onsubmit="return confirm('Xóa danh mục này?');">
                      <input type="hidden" name="action" value="delete" />
                      <input type="hidden" name="id" value="<%= c.getId() %>" />
                      <button class="btn btn-sm btn-outline-danger" type="submit">Xóa</button>
                    </form>
                  </div>
                </td>
              </tr>
              <tr class="collapse" id="edit-<%= c.getId() %>">
                <td colspan="6">
                  <form class="row g-2" action="categories" method="post">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" value="<%= c.getId() %>" />
                    <div class="col-md-3"><input class="form-control" type="text" name="name" value="<%= c.getName() %>" required /></div>
                    <div class="col-md-4"><input class="form-control" type="text" name="description" value="<%= c.getDescription() != null ? c.getDescription() : "" %>" /></div>
                    <div class="col-md-4"><input class="form-control" type="url" name="imageUrl" value="<%= c.getImageUrl() != null ? c.getImageUrl() : "" %>" /></div>
                    <div class="col-md-1 d-grid"><button class="btn btn-primary" type="submit">Lưu</button></div>
                  </form>
                </td>
              </tr>
            <%
                  i++;
                }
              } else {
            %>
              <tr>
                <td colspan="6" class="text-muted">Chưa có danh mục nào. Hãy thêm mới!</td>
              </tr>
            <% } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
