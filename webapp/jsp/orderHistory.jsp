<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnection" %>

<%
    // ✅ session থেকে ঠিক key পড়া হচ্ছে
    Integer patientId = (Integer) session.getAttribute("patientId");
    String patientName = (String) session.getAttribute("patient"); // 🔥 FIX HERE

    if (patientId == null) {
        response.sendRedirect("patientLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order History</title>
    <style>
        body {
            margin: 0;
            font-family: Arial;
            background-color: #f4f6f8;
        }
        .header {
            background: #003b44;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #0a5c6b;
            color: white;
        }
        .no-data {
            text-align: center;
            color: red;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="header">
    <h2>Order History</h2>
    <p>Patient: <b><%= patientName %></b></p>
</div>

<div class="container">
<table>
    <tr>
        <th>Order ID</th>
        <th>Medicine</th>
        <th>Quantity</th>
        
        <th>Date</th>
    </tr>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    boolean found = false;

    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement(
        	    "SELECT o.order_id, m.medicine_name, o.quantity, " +
        	    " o.order_date " +
        	    "FROM orders o " +
        	    "JOIN medicines m ON o.medicine_id = m.medicine_id " +
        	    "WHERE o.patient_id = ? " +
        	    "ORDER BY o.order_id DESC"
        	);


        ps.setInt(1, patientId);
        rs = ps.executeQuery();

        while (rs.next()) {
            found = true;
%>
    <tr>
        <td><%= rs.getInt("order_id") %></td>
        <td><%= rs.getString("medicine_name") %></td>
        <td><%= rs.getInt("quantity") %></td>
    
        <td><%= rs.getDate("order_date") %></td>
    </tr>
<%
        }

        if (!found) {
%>
    <tr>
        <td colspan="5" class="no-data">No orders found</td>
    </tr>
<%
        }
    } catch (Exception e) {
%>
    <tr>
        <td colspan="5" class="no-data">Error loading orders</td>
    </tr>
<%
        e.printStackTrace();
    }
%>

</table>
</div>

</body>
</html>
