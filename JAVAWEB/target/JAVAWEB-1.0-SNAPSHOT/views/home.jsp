<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.javaweb.models.ClothCategory" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --bg: #f6f7fb;           /* light page background */
            --panel: #ffffff;        /* white panels */
            --surface: #ffffff;      /* white cards */
            --surface-2: #f3f4f6;    /* subtle gray */
            --text: #0f172a;         /* slate-900 */
            --muted: #4b5563;        /* gray-600 */
            --brand: #4f46e5;        /* indigo-600 */
            --brand-2: #06b6d4;      /* cyan-500 */
            --danger: #ef4444;       /* red-500 */
            --ok: #10b981;           /* emerald-500 */
            --card: #ffffff;         /* solid white */
            --glass: rgba(15,23,42,0.04);
            --ring: rgba(79,70,229,0.35);
        }
        *{ box-sizing: border-box }
        html, body{ height:100% }
        body { margin: 0; font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial; background: var(--bg); color: var(--text); }
        a{ color: inherit }

        .layout { display: grid; grid-template-columns: 280px 1fr; min-height: 100vh; gap: 24px; padding: 24px; }

        /* Sidebar */
        .sidebar { position: sticky; top: 24px; height: calc(100vh - 48px); border-radius: 16px; background: var(--panel); border: 1px solid #e5e7eb; padding: 20px; box-shadow: 0 8px 24px rgba(15,23,42,0.06); }
        .brand { display:flex; align-items:center; gap: 12px; padding: 8px 10px; margin-bottom: 16px; }
        .brand-logo { width: 38px; height: 38px; border-radius: 10px; background: linear-gradient(135deg, var(--brand), var(--brand-2)); display: grid; place-items: center; font-weight: 800; color: #ffffff; }
        .brand-name { font-weight: 700; letter-spacing: .3px; }
        .nav { margin-top: 10px; }
        .nav a { display:flex; align-items:center; gap:10px; color: var(--muted); text-decoration:none; padding: 10px 12px; border-radius: 10px; margin-bottom: 8px; transition: .2s ease; border: 1px solid transparent; }
        .nav a:hover { color: var(--text); background: #f3f4f6; border-color: #e5e7eb; box-shadow: 0 0 0 4px rgba(79,70,229,.08) inset; }
        .nav a.active { color:#111827; background: #eef2ff; border-color: #c7d2fe; }
        .logout { margin-top: 14px; display:block; text-align:center; padding: 10px 14px; border-radius: 10px; background: linear-gradient(135deg, rgba(239,68,68,1), rgba(251,113,133,0.95)); color:#ffffff; font-weight:700; text-decoration:none; }
        .logout:hover { filter: brightness(1.05); }

        /* Content */
        .content { padding-right: 8px; }
        .header { display:flex; justify-content: space-between; align-items:center; margin-bottom: 18px; }
        .title { font-size: 18px; font-weight: 800; letter-spacing: .4px; }
        .sub { color: var(--muted); font-size: 14px; }
        .user-chip { display:flex; align-items:center; gap:10px; padding:8px 10px; border-radius: 999px; border:1px solid #e5e7eb; background: #ffffff; box-shadow: 0 2px 8px rgba(15,23,42,0.06); }
        .avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--brand), var(--brand-2)); color:#ffffff; display:grid; place-items:center; font-weight: 800; }

        .card { border-radius: 14px; background: var(--card); border: 1px solid #e5e7eb; box-shadow: 0 10px 28px rgba(15,23,42,.06); padding: 18px; }
        .card h3 { margin: 0 0 12px; font-size: 16px; letter-spacing:.3px; color:#111827 }

        /* Table */
        table { width: 100%; border-collapse: collapse; overflow:hidden; border-radius: 12px; border: 1px solid #e5e7eb; background:#fff }
        th, td { padding: 12px 14px; text-align: left; vertical-align: top; }
        th { background: #f3f4f6; color: #111827; font-weight: 700; font-size: 13px }
        tbody tr { background: #ffffff; border-bottom: 1px solid #f1f5f9; }
        tbody tr:hover { background: #f8fafc; }
        .badge { padding: 6px 10px; border-radius: 999px; background: #eef2ff; color:#3730a3; font-size: 12px; border:1px solid #c7d2fe }
        .thumb { width: 44px; height: 44px; border-radius: 10px; object-fit: cover; border: 1px solid #e5e7eb; background: #f3f4f6; }
        .muted { color: var(--muted); font-size: 13px }
        .actions { display:flex; gap:8px }
        .btn { padding:6px 10px; border-radius:8px; border:1px solid #e5e7eb; background:#fff; cursor:pointer }
        .btn-primary { background:#eef2ff; border-color:#c7d2fe; color:#3730a3 }
        .btn-danger { background:#fee2e2; border-color:#fecaca; color:#b91c1c }
        .inline-form { display:grid; grid-template-columns: 1fr 1fr 1fr auto; gap:8px; }
        .inline-form input { padding:8px 10px; border:1px solid #e5e7eb; border-radius:8px }

        /* Tabs */
        .tabs { display:flex; gap:8px; margin-bottom:12px }
        .tab-btn { padding: 8px 12px; border-radius: 10px; border:1px solid #e5e7eb; background: #ffffff; color: #111827; cursor: pointer; box-shadow: 0 2px 8px rgba(15,23,42,0.04) }
        .tab-btn.active { border-color: #c7d2fe; background: #eef2ff }
        .tab { display:none }

        /* Responsive */
        @media (max-width: 992px){ .layout{ grid-template-columns: 1fr } .sidebar{ position: static; height:auto } .inline-form{ grid-template-columns: 1fr } }
    </style>
    <script>
        function showTab(tab) {
            document.querySelectorAll('.tab').forEach(el => el.style.display = 'none');
            document.getElementById(tab).style.display = 'block';
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.getElementById('btn-' + tab).classList.add('active');
            document.querySelectorAll('.nav a').forEach(a => a.classList.remove('active'));
            document.getElementById('nav-' + tab).classList.add('active');
            localStorage.setItem('home.activeTab', tab);
        }
        function toggleEditRow(rowId){
            const row = document.getElementById(rowId);
            if(row) row.style.display = row.style.display === 'none' ? 'table-row' : 'none';
        }
        function keepClothesTab(){
            try { localStorage.setItem('home.activeTab','clothes'); } catch(e){}
        }
        window.addEventListener('DOMContentLoaded', () => {
            const saved = localStorage.getItem('home.activeTab') || 'profile';
            showTab(saved);
        });
    </script>
</head>
<body>
<%
    Object fullNameObj = session.getAttribute("fullName");
    String fullName = fullNameObj != null ? fullNameObj.toString() : "";
    Object userNameObj = session.getAttribute("userName");
    String userName = userNameObj != null ? userNameObj.toString() : "";
    Object emailObj = session.getAttribute("email");
    String email = emailObj != null ? emailObj.toString() : "";
    List<ClothCategory> categories = (List<ClothCategory>) request.getAttribute("categories");
    String initials = (fullName != null && !fullName.isEmpty()) ? fullName.trim().replaceAll("\\s+", " ").split(" ")[0].substring(0,1).toUpperCase() : (userName != null && !userName.isEmpty() ? userName.substring(0,1).toUpperCase() : "U");
%>
<div class="layout">
    <aside class="sidebar">
        <div class="brand">
            <div class="brand-logo"><%= initials %></div>
            <div>
                <div class="brand-name"><%= (fullName != null && !fullName.isEmpty()) ? fullName : userName %></div>
                <div class="muted" style="font-size:12px;">Welcome back ✨</div>
            </div>
        </div>
        <nav class="nav">
            <a href="#" id="nav-profile" onclick="showTab('profile'); return false;">Xem thông tin cá nhân</a>
            <a href="#" id="nav-clothes" onclick="showTab('clothes'); return false;">Quản lí quần áo</a>
            <a class="logout" href="logout">Đăng xuất</a>
        </nav>
    </aside>
    <main class="content">
        <div class="header">
            <div>
                <div class="title">Bảng điều khiển</div>
                <div class="sub">Quản lý tài khoản và danh mục quần áo</div>
            </div>
            <div class="user-chip">
                <div class="avatar"><%= initials %></div>
                <div class="muted"><%= (fullName != null && !fullName.isEmpty()) ? fullName : userName %></div>
            </div>
        </div>

        <div class="tabs">
            <button id="btn-profile" class="tab-btn" onclick="showTab('profile')">Thông tin cá nhân</button>
            <button id="btn-clothes" class="tab-btn" onclick="showTab('clothes')">Danh mục quần áo</button>
        </div>

        <section class="card tab" id="profile">
            <h3>Thông tin cá nhân</h3>
            <table>
                <tr><th>Thuộc tính</th><th>Giá trị</th></tr>
                <tr><td>Tên đăng nhập</td><td class="muted"><%= userName %></td></tr>
                <tr><td>Họ và tên</td><td class="muted"><%= fullName %></td></tr>
            </table>
        </section>

        <section class="card tab" id="clothes">
            <h3>Danh mục quần áo của bạn</h3>
            <div style="margin: 6px 0 14px;">
                <form class="inline-form" action="categories" method="post" onsubmit="keepClothesTab()">
                    <input type="hidden" name="action" value="create" />
                    <input type="text" name="name" placeholder="Tên danh mục" required />
                    <input type="text" name="description" placeholder="Mô tả (không bắt buộc)" />
                    <input type="url" name="imageUrl" placeholder="Link hình ảnh (tùy chọn)" />
                    <button class="btn btn-primary" type="submit">Thêm</button>
                </form>
            </div>
            <table>
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
                                <img class="thumb" src="<%= c.getImageUrl() %>" alt="image" />
                            <% } else { %>
                                <span class="muted">Không ảnh</span>
                            <% } %>
                        </td>
                        <td><%= c.getName() %></td>
                        <td class="muted"><%= c.getDescription() != null ? c.getDescription() : "" %></td>
                        <td class="muted"><%= c.getCreatedAt() != null ? c.getCreatedAt() : "" %></td>
                        <td>
                            <div class="actions">
                                <button class="btn btn-primary" type="button" onclick="toggleEditRow('edit-<%= c.getId() %>');">Sửa</button>
                                <form action="categories" method="post" onsubmit="keepClothesTab(); return confirm('Xóa danh mục này?');">
                                    <input type="hidden" name="action" value="delete" />
                                    <input type="hidden" name="id" value="<%= c.getId() %>" />
                                    <button class="btn btn-danger" type="submit">Xóa</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <tr id="edit-<%= c.getId() %>" style="display:none; background:#fafafa;">
                        <td colspan="6">
                            <form class="inline-form" action="categories" method="post" onsubmit="keepClothesTab()">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="id" value="<%= c.getId() %>" />
                                <input type="text" name="name" placeholder="Tên danh mục" value="<%= c.getName() %>" required />
                                <input type="text" name="description" placeholder="Mô tả" value="<%= c.getDescription() != null ? c.getDescription() : "" %>" />
                                <input type="url" name="imageUrl" placeholder="Link hình ảnh" value="<%= c.getImageUrl() != null ? c.getImageUrl() : "" %>" />
                                <button class="btn btn-primary" type="submit">Lưu</button>
                            </form>
                        </td>
                    </tr>
                <%
                            i++;
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6" class="muted">Chưa có danh mục nào. Hãy thêm mới!</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </section>
    </main>
</div>
</body>
</html>
