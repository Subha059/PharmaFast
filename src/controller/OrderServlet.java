package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DBConnection;

public class OrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer patientId = null;

        // 1️⃣ Try from request (hidden field)
        String pid = request.getParameter("patientId");
        if (pid != null && !pid.equals("null") && !pid.isEmpty()) {
            patientId = Integer.parseInt(pid);
        }

        // 2️⃣ If not found, try session
        if (patientId == null) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                patientId = (Integer) session.getAttribute("patientId");
            }
        }

        // 3️⃣ Still null → login
        if (patientId == null) {
            response.sendRedirect("patientLogin.jsp");
            return;
        }

        int medicineId = Integer.parseInt(request.getParameter("medicine_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO orders (patient_id, medicine_id, quantity, order_date) " +
                "VALUES (?, ?, ?, CURDATE())"
            );

            ps.setInt(1, patientId);
            ps.setInt(2, medicineId);
            ps.setInt(3, quantity);

            ps.executeUpdate();
            
            String medicineName = request.getParameter("medicine_name");

            request.getSession().setAttribute("lastOrderedMedicine", medicineName);


            response.sendRedirect("orderMedicine.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Order Failed");
        }
    }
}
