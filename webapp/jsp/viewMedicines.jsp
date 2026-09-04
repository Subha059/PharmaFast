<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnection" %>

<!DOCTYPE html>
<html>
<head>

    <title>View Medicines</title>
    <style>
        body {
            font-family: Arial;
            background: #f8f9fa;
            padding: 40px;
        }

        h2 {
            margin-bottom: 15px;
        }

        .search-box {
            background: white;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 6px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        input[type="text"] {
            width: 300px;
            padding: 7px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            padding: 7px 14px;
            background: #0a5c6b;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: bold;
            border-radius: 4px;
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
            background: #0a5c6b;
            color: white;
        }

        .order-btn {
            padding: 6px 12px;
            background: #0d6efd;
            color: white;
            border: none;
            cursor: pointer;
        }

        .qty {
            width: 60px;
            text-align: center;
        }
    </style>
</head>

<body>

<h2>Available Medicines</h2>

<!-- SEARCH BOX -->
<div class="search-box">
    <form method="get">
        <label>Search Medicine:</label>
        <input type="text" name="keyword" placeholder="Enter name or description">
        <input type="submit" value="Search">
        <a href="viewMedicines.jsp" style="margin-left:15px;">Reset</a>
    </form>
</div>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Stock</th>
        <th>Quantity</th>
        <th>Action</th>
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
                "SELECT * FROM medicines WHERE medicine_name LIKE ? OR description LIKE ?"
            );
            String value = "%" + keyword + "%";
            ps.setString(1, value);
            ps.setString(2, value);
        } else {
            ps = con.prepareStatement("SELECT * FROM medicines");
        }

        rs = ps.executeQuery();

        boolean found = false;

        while (rs.next()) {
            found = true;
%>
    <tr>
        <td><%= rs.getInt("medicine_id") %></td>
        <td><%= rs.getString("medicine_name") %></td>
        <td><%= rs.getString("description") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getInt("stock") %></td>

<td>
    <form action="orderMedicine.jsp" method="post">
        <input type="hidden" name="patientId"
               value="<%= session.getAttribute("patientId") %>">

        <input type="number" name="quantity" class="qty"
               min="1" max="<%= rs.getInt("stock") %>" required>
</td>

<td>
        <input type="hidden" name="medicine_id" value="<%= rs.getInt("medicine_id") %>">
        <input type="hidden" name="medicine_name" value="<%= rs.getString("medicine_name") %>">
        <input type="submit" value="Order" class="order-btn">
    </form>
</td>


       
    </tr>
    
<%
        }

        if (!found) {
%>
    <tr>
        <td colspan="7">No medicines found</td>
    </tr>
<%
        }

    } catch (Exception e) {
%>
    <tr>
        <td colspan="7">Error loading medicines</td>
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