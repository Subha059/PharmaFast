<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnection" %>
<%@ page import="model.Doctor" %>

<%
    if (session == null || session.getAttribute("doctor") == null) {
        response.sendRedirect("doctorLogin.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
    <title>View Patients</title>
    <style>
        body {
            font-family: Arial;
            background: #f8f9fa;
            padding: 40px;
        }
        .search-box {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        input[type="text"] {
            width: 300px;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            padding: 8px 16px;
            background: #0a5c6b;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background: #003d4d;
            color: white;
        }
    </style>
</head>

<body>

<h2>Patients</h2>

<!-- SEARCH BOX -->
<div class="search-box">
    <form method="get">
        <label>Search by Name / Email / Phone:</label>
        <input type="text" name="keyword" placeholder="Enter keyword">
        <input type="submit" value="Search">
        <a href="viewPatients.jsp" style="margin-left:15px;">Reset</a>
    </form>
</div>

<table>
    <tr>
        <th>Patient ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
    </tr>

<%
    String keyword = request.getParameter("keyword");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();

        if (keyword != null && !keyword.trim().isEmpty()) {
            ps = con.prepareStatement(
                "SELECT patient_id, name, email, phone FROM patients " +
                "WHERE name LIKE ? OR email LIKE ? OR phone LIKE ?"
            );
            String value = "%" + keyword + "%";
            ps.setString(1, value);
            ps.setString(2, value);
            ps.setString(3, value);
        } else {
            ps = con.prepareStatement(
                "SELECT patient_id, name, email, phone FROM patients"
            );
        }

        rs = ps.executeQuery();
        boolean found = false;

        while (rs.next()) {
            found = true;
%>
    <tr>
        <td><%= rs.getInt("patient_id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("phone") %></td>
    </tr>
<%
        }

        if (!found) {
%>
    <tr>
        <td colspan="4">No patients found</td>
    </tr>
<%
        }

    } catch (Exception e) {
%>
    <tr>
        <td colspan="4">Error loading patients</td>
    </tr>
<%
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

</table>

</body>
</html>