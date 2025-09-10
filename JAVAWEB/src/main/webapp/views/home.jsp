<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.javaweb.models.ClothCategory" %>
<%@ page import="org.example.javaweb.models.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sidebar { min-height: 100vh; border-right: 1px solid #e5e7eb; }
        .sidebar .nav-link { color: #4b5563; }
        .sidebar .nav-link.active, .sidebar .nav-link:hover { color: #111827; background: #eef2ff; border-radius: .5rem; }
        .thumb { width: 44px; height: 44px; object-fit: cover; border-radius: .5rem; border: 1px solid #e5e7eb; }
        .inline-form .form-control { min-width: 160px; }
        .sticky-sidebar { position: sticky; top: 0; }
    </style>
    <script>
        function showTab(tab){
            document.querySelectorAll('.tab-pane').forEach(el => el.classList.remove('show','active'));
            document.getElementById(tab).classList.add('show','active');
            document.querySelectorAll('.sidebar .nav-link').forEach(a => a.classList.remove('active'));
            const nav = document.getElementById('nav-'+tab); if(nav) nav.classList.add('active');
            localStorage.setItem('home.activeTab', tab);
        }
        function toggleEditRow(id){
            const row=document.getElementById(id); if(row){ row.style.display = row.style.display==='none'?'table-row':'none'; }
        }
        function keepClothesTab(){ try{ localStorage.setItem('home.activeTab','clothes'); }catch(e){} }
        window.addEventListener('DOMContentLoaded', ()=>{
            const saved = localStorage.getItem('home.activeTab') || 'profile';
            showTab(saved);
        });
        function toggleProfileEdit(){
            const el = document.getElementById('profile-edit');
            if (el) { el.style.display = el.style.display === 'none' ? 'block' : 'none'; }
        }
    </script>
</head>
<body class="bg-light">
<%
    Object fullNameObj = session.getAttribute("fullName");
    String fullName = fullNameObj != null ? fullNameObj.toString() : "";
    Object userNameObj = session.getAttribute("userName");
    String userName = userNameObj != null ? userNameObj.toString() : "";
    List<ClothCategory> categories = (List<ClothCategory>) request.getAttribute("categories");
    User userDetail = (User) request.getAttribute("userDetail");
    String initials = (fullName != null && !fullName.isEmpty()) ? fullName.trim().replaceAll("\\s+"," ").split(" ")[0].substring(0,1).toUpperCase() : (userName != null && !userName.isEmpty()? userName.substring(0,1).toUpperCase() : "U");
%>
<div class="container-fluid">
    <div class="row">
        <aside class="col-12 col-md-3 col-lg-2 bg-white sidebar p-3 sticky-sidebar">
            <div class="d-flex align-items-center gap-2 mb-3">
                <div class="rounded-circle d-inline-flex align-items-center justify-content-center bg-primary text-white" style="width:38px;height:38px;font-weight:700;"> <%= initials %> </div>
                <div>
                    <div class="fw-bold"><%= (fullName != null && !fullName.isEmpty()) ? fullName : userName %></div>
                    <div class="text-muted small">Welcome back ✨</div>
                </div>
            </div>
            <nav class="nav flex-column">
                <a id="nav-profile" class="nav-link" href="#" onclick="showTab('profile'); return false;">Xem thông tin cá nhân</a>
                <a id="nav-clothes" class="nav-link" href="#" onclick="showTab('clothes'); return false;">Quản lí quần áo</a>
                <a class="btn btn-danger mt-3" href="logout">Đăng xuất</a>
            </nav>
        </aside>
        <main class="col-12 col-md-9 col-lg-10 p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <div class="fw-bold">Bảng điều khiển</div>
                    <div class="text-muted small">Quản lý tài khoản và danh mục quần áo</div>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <div class="rounded-circle d-inline-flex align-items-center justify-content-center bg-primary text-white" style="width:36px;height:36px;font-weight:700;"> <%= initials %> </div>
                    <div class="text-muted small"><%= (fullName != null && !fullName.isEmpty()) ? fullName : userName %></div>
                </div>
            </div>

            <div class="tab-content">
                <div class="tab-pane fade" id="profile">
                    <div class="card shadow-sm mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="card-title mb-0">Thông tin cá nhân</h5>
                                <button class="btn btn-sm btn-outline-primary" type="button" onclick="toggleProfileEdit()">Chỉnh sửa</button>
                            </div>
                            <div class="row g-3 align-items-center mb-3 mt-1">
                                <div class="col-auto">
                                    <div class="rounded-circle d-inline-flex align-items-center justify-content-center bg-secondary text-white" style="width:64px;height:64px;font-weight:700;">
                                        <%= initials %>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <% if (userDetail != null && userDetail.getAvatar() != null && !userDetail.getAvatar().isEmpty()) { %>
                                        <img src="<%= userDetail.getAvatar() %>" alt="avatar" class="rounded" style="width:64px;height:64px;object-fit:cover;border:1px solid #e5e7eb;" />
                                    <% } %>
                                </div>
                            </div>
                            <div class="table-responsive mb-3">
                                <table class="table table-striped align-middle">
                                    <thead>
                                        <tr><th>Thuộc tính</th><th>Giá trị</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr><td>ID</td><td class="text-muted"><%= (userDetail != null) ? userDetail.getId() : "" %></td></tr>
                                        <tr><td>Tên đăng nhập</td><td class="text-muted"><%= (userDetail != null) ? userDetail.getUserName() : userName %></td></tr>
                                        <tr><td>Họ và tên</td><td class="text-muted"><%= (userDetail != null) ? userDetail.getFullName() : fullName %></td></tr>
                                        <tr><td>Email</td><td class="text-muted"><%= (userDetail != null) ? userDetail.getEmail() : "" %></td></tr>
                                        <tr><td>Số điện thoại</td><td class="text-muted"><%= (userDetail != null && userDetail.getPhone() != null) ? userDetail.getPhone() : "" %></td></tr>
                                        <tr><td>Vai trò</td><td><span class="badge text-bg-secondary"><%= (userDetail != null) ? userDetail.getRoleId() : String.valueOf(session.getAttribute("roleId")) %></span></td></tr>
                                        <tr><td>Ngày tạo</td><td class="text-muted"><%= (userDetail != null && userDetail.getCreatedDate() != null) ? userDetail.getCreatedDate() : "" %></td></tr>
                                        <tr><td>Avatar</td><td class="text-muted"><%= (userDetail != null && userDetail.getAvatar() != null) ? userDetail.getAvatar() : "" %></td></tr>
                                    </tbody>
                                </table>
                            </div>

                            <div id="profile-edit" style="display:none;">
                                <h6 class="mb-2">Chỉnh sửa thông tin</h6>
                                <form class="row g-3" action="profile" method="post" enctype="multipart/form-data">
                                    <div class="col-md-6">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" name="email" value="<%= (userDetail != null) ? userDetail.getEmail() : "" %>" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Tên đăng nhập</label>
                                        <input type="text" class="form-control" name="userName" value="<%= (userDetail != null) ? userDetail.getUserName() : userName %>" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Họ và tên</label>
                                        <input type="text" class="form-control" name="fullName" value="<%= (userDetail != null) ? userDetail.getFullName() : fullName %>" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="text" class="form-control" name="phone" value="<%= (userDetail != null && userDetail.getPhone() != null) ? userDetail.getPhone() : "" %>">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Avatar (URL)</label>
                                        <input type="url" class="form-control" name="avatar" value="<%= (userDetail != null && userDetail.getAvatar() != null) ? userDetail.getAvatar() : "" %>">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Tải ảnh lên (JPEG/PNG)</label>
                                        <input type="file" class="form-control" name="avatarFile" accept="image/*">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Mật khẩu mới (để trống nếu không đổi)</label>
                                        <input type="password" class="form-control" name="passWord" placeholder="Nhập mật khẩu mới nếu muốn đổi">
                                    </div>
                                    <div class="col-12 d-flex gap-2">
                                        <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
                                        <button class="btn btn-outline-secondary" type="button" onclick="toggleProfileEdit()">Hủy</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="clothes">
                    <div class="card shadow-sm mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Thêm danh mục</h5>
                            <form class="row g-2 align-items-end" action="categories" method="post" onsubmit="keepClothesTab()">
                                <input type="hidden" name="action" value="create" />
                                <div class="col-sm-4">
                                    <label class="form-label">Tên danh mục</label>
                                    <input type="text" class="form-control" name="name" placeholder="Tên danh mục" required>
                                </div>
                                <div class="col-sm-4">
                                    <label class="form-label">Mô tả</label>
                                    <input type="text" class="form-control" name="description" placeholder="Mô tả (không bắt buộc)">
                                </div>
                                <div class="col-sm-4">
                                    <label class="form-label">Link hình ảnh</label>
                                    <input type="url" class="form-control" name="imageUrl" placeholder="https://...">
                                </div>
                                <div class="col-12">
                                    <button class="btn btn-primary" type="submit">Thêm</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Danh mục quần áo của bạn</h5>
                                <span class="badge text-bg-light">Tổng: <%= (categories != null) ? categories.size() : 0 %></span>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
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
                                                    <img class="thumb" src="<%= c.getImageUrl() %>" alt="image" />
                                                <% } else { %>
                                                    <span class="text-muted">Không ảnh</span>
                                                <% } %>
                                            </td>
                                            <td><%= c.getName() %></td>
                                            <td class="text-muted"><%= c.getDescription() != null ? c.getDescription() : "" %></td>
                                            <td class="text-muted"><%= c.getCreatedAt() != null ? c.getCreatedAt() : "" %></td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <button class="btn btn-sm btn-outline-primary" type="button" onclick="toggleEditRow('edit-<%= c.getId() %>');">Sửa</button>
                                                    <form action="categories" method="post" onsubmit="keepClothesTab(); return confirm('Xóa danh mục này?');">
                                                        <input type="hidden" name="action" value="delete" />
                                                        <input type="hidden" name="id" value="<%= c.getId() %>" />
                                                        <button class="btn btn-sm btn-outline-danger" type="submit">Xóa</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="edit-<%= c.getId() %>" style="display:none;">
                                            <td colspan="6">
                                                <form class="row g-2 align-items-end" action="categories" method="post" onsubmit="keepClothesTab()">
                                                    <input type="hidden" name="action" value="update" />
                                                    <input type="hidden" name="id" value="<%= c.getId() %>" />
                                                    <div class="col-sm-4">
                                                        <label class="form-label">Tên danh mục</label>
                                                        <input type="text" class="form-control" name="name" value="<%= c.getName() %>" required>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label class="form-label">Mô tả</label>
                                                        <input type="text" class="form-control" name="description" value="<%= c.getDescription() != null ? c.getDescription() : "" %>">
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label class="form-label">Link hình ảnh</label>
                                                        <input type="url" class="form-control" name="imageUrl" value="<%= c.getImageUrl() != null ? c.getImageUrl() : "" %>">
                                                    </div>
                                                    <div class="col-12">
                                                        <button class="btn btn-primary" type="submit">Lưu</button>
                                                    </div>
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
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
