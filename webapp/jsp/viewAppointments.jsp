<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnection" %>
<%@ page import="model.Doctor" %>

<%
    Doctor doctor = (Doctor) session.getAttribute("doctor");
    if (doctor == null) {
        response.sendRedirect("doctorLogin.jsp");
        return;
    }

    int doctorId = doctor.getDoctorId();
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Appointments</title>
    <style>
        body { font-family: Arial; background: #f4f6f8; padding: 40px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #003d4d; color: white; }
        .pending { color: orange; font-weight: bold; }
        .approved { color: green; font-weight: bold; }
        .rejected { color: red; font-weight: bold; }
    </style>
</head>
<body>

<h2>All Appointments</h2>

<table>
<tr>
    <th>ID</th>
    <th>Patient</th>
    <th>Date</th>
    <th>Time</th>
    <th>Problem</th>
    <th>Status</th>
    <th>video call</th>
</tr>

<%
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT a.*, p.name FROM appointments a " +
        "JOIN patients p ON a.patient_id = p.patient_id " +
        "WHERE a.doctor_id = ? ORDER BY a.appointment_date DESC"
    );
    ps.setInt(1, doctorId);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        String status = rs.getString("status");
%>
<tr>
    <td><%= rs.getInt("appointment_id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getDate("appointment_date") %></td>
    <td><%= rs.getTime("appointment_time") %></td>
    <td><%= rs.getString("problem_description") %></td>
    
    
    <td class="<%= status.toLowerCase() %>"><%= status %></td>
    <td>
    <a href="videoConsultation.jsp?room=pharmafast_appointment_<%= rs.getInt("appointment_id") %>"
       target="_blank"
       style="padding:6px 12px; background:green; color:white; text-decoration:none; border-radius:5px;">
        Start Call
    </a>
</td>
    
</tr>
<%
    }
    rs.close(); ps.close(); con.close();
%>
</table>

</body>
</html>