<%@ taglib uri="http://www.sitemesh.org/decorator" prefix="decorator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title><decorator:title default="Trang" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <decorator:head />
    <style>
        body { background-color:#f6f7fb; }
        .layout { display:grid; grid-template-columns: 260px 1fr; min-height:100vh; }
        @media (max-width: 992px){ .layout{ grid-template-columns:1fr } }
        .sidebar{ background:#ffffff; border-right:1px solid #e5e7eb; }
        .content{ padding: 24px; }
    </style>
</head>
<body>
<div class="layout">
    <aside class="sidebar">
        <%@ include file="left.jsp" %>
    </aside>
    <main class="content">
        <%@ include file="header.jsp" %>
        <div class="container-fluid">
            <decorator:body />
        </div>
        <%@ include file="footer.jsp" %>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
