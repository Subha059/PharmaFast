<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.Doctor" %>

<%
    Doctor doctor = (Doctor) session.getAttribute("doctor");

    if (doctor == null) {
        response.sendRedirect("doctorLogin.jsp");
        return;
    }

    String doctorName = doctor.getName();
    String specialization = doctor.getSpecialization();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard</title>
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
            padding: 25px 0;
            text-align: center;
        }
        .dashboard-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .dashboard-card {
            padding: 25px;
            margin: 15px 0;
            border: 1px solid #ccc;
            border-radius: 10px;
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
            margin-top: 30px;
            text-align: right;
        }
        .logout a {
            text-decoration: none;
            color: #dc3545;
            font-weight: bold;
            font-size: 16px;
        }
        .logout a:hover {
            text-decoration: underline;
        }
        .sub-text {
            font-size: 15px;
            color: #dcdcdc;
        }
    </style>
</head>

<body>

<div class="dashboard-header">
    <h1>Welcome Dr. <%= doctorName %></h1>
    <div class="sub-text">Specialization: <%= specialization %></div>
</div>

<div class="dashboard-container">

    <div class="dashboard-card">
        <a href="viewAppointments.jsp">View Appointments</a>
    </div>

    <div class="dashboard-card">
        <a href="manageAppointment.jsp">Manage Appointments</a>
    </div>

    <div class="dashboard-card">
        <a href="viewPatient.jsp">View Patients</a>
    </div>

    <div class="dashboard-card">
        <a href="viewMedicines.jsp">View Medicines</a>
    </div>

    <div class="logout">
        <a href="logout.jsp">Logout</a>
    </div>

</div>

</body>
</html>