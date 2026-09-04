<%@ page session="true" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .box {
            background: white;
            padding: 30px;
            width: 400px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            text-align: center;
        }

        h2 {
            margin-bottom: 25px;
            color: #003b44;
        }

        a {
            display: block;
            margin: 12px 0;
            padding: 10px;
            text-decoration: none;
            font-weight: bold;
            color: #0a5c6b;
            border: 1px solid #0a5c6b;
            border-radius: 6px;
            transition: background 0.3s ease, color 0.3s ease;
        }

        a:hover {
            background: #0a5c6b;
            color: white;
        }

        .logout {
            border-color: #dc3545;
            color: #dc3545;
        }

        .logout:hover {
            background: #dc3545;
            color: white;
        }
    </style>
</head>

<body>

<div class="box">
    <h2>Welcome Admin</h2>

    <a href="viewPatient.jsp">View Patients</a>
    <a href="viewDoctor.jsp">View Doctors</a>
    <a href="viewMedicines.jsp">View Medicines</a>
    <a href="manageStock.jsp">Manage Stock</a>
    <a href="logout.jsp" class="logout">Logout</a>
</div>

</body>
</html>
