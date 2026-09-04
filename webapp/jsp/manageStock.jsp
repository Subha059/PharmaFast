<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnection" %>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Stock Management</title>
    <style>
        body { font-family: Arial; background: #f4f6f8; padding: 40px; }
        table { width: 100%; background: white; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #003d4d; color: white; }
        .low { color: red; font-weight: bold; }
        input[type=number] { width: 80px; }
        .btn { padding: 6px 12px; background: #0a5c6b; color: white; border: none; }
    </style>
</head>

<body>

<h2>Medicine Stock Management</h2>

<table>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Price</th>
    <th>Current Stock</th>
    <th>Add Stock</th>
    <th>Action</th>
</tr>

<%
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM medicines");
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        int stock = rs.getInt("stock");
%>
<tr>
    <td><%= rs.getInt("medicine_id") %></td>
    <td><%= rs.getString("medicine_name") %></td>
    <td>₹<%= rs.getDouble("price") %></td>
    <td class="<%= stock < 20 ? "low" : "" %>">
        <%= stock %>
        <%= stock < 20 ? " (Low)" : "" %>
    </td>

    <td>
        <form action="UpdateStockServlet" method="post">
            <input type="number" name="add_stock" min="1" required>
            <input type="hidden" name="medicine_id" value="<%= rs.getInt("medicine_id") %>">
    </td>

    <td>
            <input type="submit" value="Update" class="btn">
        </form>
    </td>
</tr>
<%
    }
    rs.close();
    ps.close();
    con.close();
%>

</table>
<h2>Add New Medicine</h2>

<style>
.add-medicine-card {
    max-width: 1500px;
    margin: 30px 0;
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}

.add-medicine-card h3 {
    margin-bottom: 20px;
    color: #003d4d;
    text-align: center;
}

.add-medicine-card label {
    font-weight: bold;
    color: #333;
}

.add-medicine-card input[type="text"],
.add-medicine-card input[type="number"],
.add-medicine-card textarea {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 14px;
}

.add-medicine-card textarea {
    resize: none;
}

.add-medicine-card .btn {
    width: 100%;
    padding: 12px;
    margin-top: 15px;
    background: #0a5c6b;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.add-medicine-card .btn:hover {
    background: #084d59;
}
</style>

<div class="add-medicine-card">
    <h3>Add New Medicine</h3>

    <form action="AddMedicineServlet" method="post">

        <label>Medicine Name</label><br>
        <input type="text" name="medicine_name" required><br><br>

        <label>Description</label><br>
        <textarea name="description" rows="3"></textarea><br><br>

        <label>Price</label><br>
        <input type="number" step="0.01" name="price" required><br><br>

        <label>Initial Stock</label><br>
        <input type="number" name="stock" min="1" required><br><br>

        <input type="submit" value="Add Medicine" class="btn">

    </form>
</div>

</body>
</html>