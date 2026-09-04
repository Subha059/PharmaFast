<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
if (session == null || session.getAttribute("patient") == null) {
    response.sendRedirect("patientLogin.jsp");
    return;
}
String patientName = (String) session.getAttribute("patient");

%>

<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .dashboard-header {
            background-color: #003d4d;
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        .dashboard-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .dashboard-card {
            padding: 20px;
            margin: 15px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .dashboard-card a {
            text-decoration: none;
            color: #007b74;
            font-weight: bold;
            font-size: 18px;
        }
        .logout {
            margin-top: 25px;
            text-align: right;
        }
        .logout a {
            text-decoration: none;
            color: #dc3545;
            font-weight: bold;
        }
        .logout a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="dashboard-header">
    <h1>Welcome, <%= patientName %></h1>
</div>

<div class="dashboard-container">
    <div class="dashboard-card">
        <a href="bookAppointment.jsp">Book Appointment</a>
    </div>
    <div class="dashboard-card">
        <a href="viewMedicines.jsp">View Medicines</a>
    </div>
    <div class="dashboard-card">
        <a href="orderHistory.jsp">View Order History</a>
    </div>
    <div class="dashboard-card">
        <a href="emergencyHelpline.jsp">Emergency Helpline</a>
    </div>
    <div class="logout">
        <a href="logout.jsp">Logout</a>
    </div>
</div>

</body>
</html>