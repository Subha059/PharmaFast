<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnection" %>

<%
    Integer patientId = (Integer) session.getAttribute("patientId");

    if (patientId == null) {
        response.sendRedirect("patientLogin.jsp");
        return;
    }

    int medicineId = Integer.parseInt(request.getParameter("medicine_id"));
    String medicineName = request.getParameter("medicine_name");
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    Connection con = null;
    PreparedStatement psSelect = null;
    PreparedStatement psInsert = null;
    PreparedStatement psUpdate = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        con.setAutoCommit(false);   // 🔴 Transaction start

        // 1️⃣ Get stock
        psSelect = con.prepareStatement(
            "SELECT stock FROM medicines WHERE medicine_id=?"
        );
        psSelect.setInt(1, medicineId);
        rs = psSelect.executeQuery();

        if (!rs.next()) {
            out.println("Medicine not found");
            return;
        }

        int stock = rs.getInt("stock");

        // 2️⃣ Check stock
        if (stock < quantity) {
            out.println("Not enough stock available");
            return;
        }

        // 3️⃣ Insert order
        psInsert = con.prepareStatement(
            "INSERT INTO orders (patient_id, medicine_id, quantity, order_date) VALUES (?,?,?,CURDATE())"
        );
        psInsert.setInt(1, patientId);
        psInsert.setInt(2, medicineId);
        psInsert.setInt(3, quantity);
        psInsert.executeUpdate();

        // 4️⃣ Reduce stock
        psUpdate = con.prepareStatement(
            "UPDATE medicines SET stock = stock - ? WHERE medicine_id = ?"
        );
        psUpdate.setInt(1, quantity);
        psUpdate.setInt(2, medicineId);
        psUpdate.executeUpdate();

        con.commit();   // ✅ Success

        // confirmation data
        session.setAttribute("lastOrderedMedicine", medicineName);

    } catch (Exception e) {
        if (con != null) con.rollback();  // ❌ rollback
        e.printStackTrace();
        out.println("Order Failed");
        return;
    } finally {
        if (rs != null) rs.close();
        if (psSelect != null) psSelect.close();
        if (psInsert != null) psInsert.close();
        if (psUpdate != null) psUpdate.close();
        if (con != null) con.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial;
            background: #e9f7ef;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        h2 {
            color: green;
        }
    </style>
</head>

<body>

<div class="box">
    <h2>Order Successful ✅</h2>

    <p>
        You have ordered :
        <strong><%= session.getAttribute("lastOrderedMedicine") %></strong>
    </p>

    <a href="viewMedicines.jsp">← Back to Medicines</a><br><br>
    <a href="orderHistory.jsp">← Watch your Order History</a>
</div>

</body>
</html>
