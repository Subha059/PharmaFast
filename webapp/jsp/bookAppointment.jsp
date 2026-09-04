<%@ page import="java.sql.*" %>
<%@ page import="model.DBConnection" %>

<%
    Integer patientId = (Integer) session.getAttribute("patientId");

    if (patientId == null) {
        response.sendRedirect("patientLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #003b44, #0a5c6b);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: #ffffff;
            width: 420px;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            color: #003b44;
            margin-bottom: 25px;
        }

        label {
            font-weight: 600;
            color: #333;
            display: block;
            margin-bottom: 6px;
        }

        select, input[type="date"], input[type="time"], textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            margin-bottom: 18px;
            font-size: 14px;
            box-sizing: border-box;
        }

        textarea {
            resize: none;
            height: 90px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #198754;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        input[type="submit"]:hover {
            background-color: #146c43;
            transform: translateY(-2px);
        }

        .error {
            background: #f8d7da;
            color: #842029;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="card">

    <h2>Book Appointment</h2>

    <% if (request.getParameter("error") != null) { %>
        <div class="error">
            <%= request.getParameter("error") %>
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/AppointmentServlet" method="post">

        <label>Doctor</label>

        <select name="doctor_id" required>

            <option value="">-- Select Doctor --</option>

            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = DBConnection.getConnection();

                    ps = con.prepareStatement(
                        "SELECT doctor_id, name, specialization FROM doctors"
                    );

                    rs = ps.executeQuery();

                    while (rs.next()) {
            %>

                <option value="<%= rs.getInt("doctor_id") %>">
                    Dr. <%= rs.getString("name") %>
                    (<%= rs.getString("specialization") %>)
                </option>

            <%
                    }

                } catch (Exception e) {
                    e.printStackTrace();

                } finally {

                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                }
            %>

        </select>

        <label>Date</label>
        <input type="date" name="appointment_date" required>

        <label>Time</label>
        <input type="time" name="appointment_time" required>

        <label>Problem</label>

        <textarea name="problem_description"
            placeholder="Describe your problem briefly..."></textarea>

        <input type="submit" value="Book Appointment">

    </form>

</div>

</body>
</html>