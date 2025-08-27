<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách khách hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ffecd2, #fcb69f);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .home-container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #ff6600;
            margin-bottom: 20px;
        }

        .welcome {
            font-size: 18px;
            color: #333;
            font-weight: bold;
        }

        .error {
            font-size: 16px;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="home-container">
        <h2>HOME PAGE</h2>
        <%
            String username = (String) request.getAttribute("username");

            if (username != null && !username.equals("guest")) {
        %>
            <div class="welcome">Welcome home, <%= username %>!</div>
        <%
            } else {
        %>
            <div class="error">Let come to Login page!!!</div>
        <%
            }
        %>
    </div>
</body>
</html>
