package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import model.DBConnection;

public class AppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");

        if (patientId == null) {
            response.sendRedirect(
                request.getContextPath() + "/jsp/patientLogin.jsp"
            );
            return;
        }

        // Form data
        int doctorId = Integer.parseInt(request.getParameter("doctor_id"));
        LocalDate date = LocalDate.parse(
            request.getParameter("appointment_date")
        );
        LocalTime time = LocalTime.parse(
            request.getParameter("appointment_time")
        );
        String problem = request.getParameter("problem_description");

        // Date validation
        if (date.isBefore(LocalDate.now())) {
            response.sendRedirect(
                request.getContextPath() +
                "/jsp/bookAppointment.jsp?error=Invalid+Date"
            );
            return;
        }

        Connection con = null;
        PreparedStatement psCheck = null;
        PreparedStatement psInsert = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            // Check duplicate slot
            String checkSql =
                "SELECT COUNT(*) FROM appointments " +
                "WHERE doctor_id=? AND appointment_date=? AND appointment_time=?";

            psCheck = con.prepareStatement(checkSql);

            psCheck.setInt(1, doctorId);
            psCheck.setDate(2, java.sql.Date.valueOf(date));
            psCheck.setTime(3, java.sql.Time.valueOf(time));

            rs = psCheck.executeQuery();
            rs.next();

            if (rs.getInt(1) > 0) {
                response.sendRedirect(
                    request.getContextPath() +
                    "/jsp/bookAppointment.jsp?error=Slot+Already+Booked"
                );
                return;
            }

            // Insert appointment
            String insertSql =
                "INSERT INTO appointments " +
                "(patient_id, doctor_id, appointment_date, appointment_time, problem_description) " +
                "VALUES (?,?,?,?,?)";

            psInsert = con.prepareStatement(insertSql);

            psInsert.setInt(1, patientId);
            psInsert.setInt(2, doctorId);
            psInsert.setDate(3, java.sql.Date.valueOf(date));
            psInsert.setTime(4, java.sql.Time.valueOf(time));
            psInsert.setString(5, problem);

            psInsert.executeUpdate();

            // Success
            response.sendRedirect(
                request.getContextPath() +
                "/jsp/appointmentSuccess.jsp"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath() +
                "/jsp/bookAppointment.jsp?error=Server+Error"
            );

        } finally {

            try {
                if (rs != null) rs.close();
                if (psCheck != null) psCheck.close();
                if (psInsert != null) psInsert.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}