<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>PharmaFast - Patient Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

```
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #003d4d, #004f5f);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .login-card {
        background-color: white;
        padding: 35px;
        border-radius: 12px;
        width: 400px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        text-align: center;
    }

    .login-card h2 {
        color: #003d4d;
        margin-bottom: 25px;
    }

    .login-card .form-label {
        text-align: left;
        font-weight: 600;
        margin-bottom: 5px;
    }

    .login-card input[type="text"],
    .login-card input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 18px;
        border-radius: 6px;
        border: 1px solid #ccc;
    }

    .login-card input[type="submit"] {
        width: 100%;
        padding: 12px;
        background-color: #198754;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
    }

    .login-card input[type="submit"]:hover {
        background-color: #146c43;
    }

    .error-msg {
        color: red;
        margin-bottom: 15px;
    }

    .register-link {
        margin-top: 12px;
    }

    .register-link a {
        color: #0a5c6b;
        font-weight: 600;
        text-decoration: none;
    }

    .register-link a:hover {
        text-decoration: underline;
    }
</style>
```

</head>

<body>

<div class="login-card">

```
<h2>Patient Login</h2>

<% if(request.getParameter("error") != null){ %>
    <div class="error-msg">
        <%= request.getParameter("error") %>
    </div>
<% } %>

<form action="../PatientLoginServlet" method="post" autocomplete="off">

    <input type="text" style="display:none">
    <input type="password" style="display:none">

    <label class="form-label">Email or Phone:</label>
    <input type="text"
           name="email"
           placeholder="Enter email or phone"
           required>

    <label class="form-label">Password:</label>
    <input type="password"
           name="password"
           placeholder="Enter password"
           required>

    <input type="submit" value="Login">

</form>

<div class="register-link">
    Don't have an account?
    <a href="patientRegister.jsp">Register Here</a>
</div>
```

</div>

</body>
</html>
