<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách khách hàng</title>
</head>
<body>
    <h2>Top 5 Customers</h2>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <p style="color:red;">Lỗi: <%= error %></p>
    <%
        } else {
            java.util.List<String> list = (java.util.List<String>) request.getAttribute("customers");
            if (list != null) {
                for (String name : list) {
    %>
                    <div><%= name %></div>
    <%
                }
            }
        }
    %>
</body>
</html>
