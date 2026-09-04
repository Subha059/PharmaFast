<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnection" %>
<%@ page import="model.Doctor" %>

<%
    Doctor doctor = (Doctor) session.getAttribute("doctor");
    if (doctor == null) {
        response.sendRedirect("../jsp/doctorLogin.jsp");
        return;
    }

    int doctorId = doctor.getDoctorId();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Appointments</title>
    <style>
        body { font-family: Arial; background: #f4f6f8; padding: 40px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #0a5c6b; color: white; }
        .approve { background: green; color: white; padding: 6px 10px; border: none; }
        .reject { background: red; color: white; padding: 6px 10px; border: none; }
    </style>
</head>
<body>

<h2>Manage Pending Appointments</h2>

<table>
<tr>
    <th>ID</th>
    <th>Patient</th>
    <th>Date</th>
    <th>Time</th>
    <th>Problem</th>
    <th>Action</th>
</tr>

<%
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT a.*, p.name FROM appointments a " +
        "JOIN patients p ON a.patient_id = p.patient_id " +
        "WHERE a.doctor_id = ? AND a.status = 'PENDING'"
    );

    ps.setInt(1, doctorId);
    ResultSet rs = ps.executeQuery();

    boolean found = false;

    while (rs.next()) {
        found = true;
%>

<tr>
    <td><%= rs.getInt("appointment_id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getDate("appointment_date") %></td>
    <td><%= rs.getTime("appointment_time") %></td>
    <td><%= rs.getString("problem_description") %></td>

    <td>

        <form action="../AppointmentActionServlet" method="post" style="display:inline;">
            <input type="hidden" name="appointment_id"
                   value="<%= rs.getInt("appointment_id") %>">

            <input type="hidden" name="action" value="APPROVE">

            <input type="submit" value="Approve" class="approve">
        </form>

        <form action="../AppointmentActionServlet" method="post" style="display:inline;">
            <input type="hidden" name="appointment_id"
                   value="<%= rs.getInt("appointment_id") %>">

            <input type="hidden" name="action" value="REJECT">

            <input type="submit" value="Reject" class="reject">
        </form>

    </td>
</tr>

<%
    }

    if (!found) {
%>

<tr>
    <td colspan="6">No pending appointments</td>
</tr>

<%
    }

    rs.close();
    ps.close();
    con.close();
%>

</table>

</body>
</html>