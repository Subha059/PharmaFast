package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.DBConnection;
import model.Doctor;

public class DoctorLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM doctors WHERE (email = ? OR phone = ?) AND password = ?"
            );

            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Doctor doctor = new Doctor();

                doctor.setDoctorId(rs.getInt("doctor_id"));
                doctor.setName(rs.getString("name"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setSpecialization(rs.getString("specialization"));

                HttpSession session = request.getSession();
                session.setAttribute("doctor", doctor);

                response.sendRedirect(
                    request.getContextPath() + "/jsp/doctorDashboard.jsp"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath() +
                    "/jsp/doctorLogin.jsp?error=Invalid+Email%2FPhone+or+Password"
                );
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath() +
                "/jsp/doctorLogin.jsp?error=Server+Error"
            );
        }
    }
}