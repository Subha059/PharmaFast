<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    String room = request.getParameter("room");
    if (room == null || room.trim().isEmpty()) {
        out.println("Invalid Room");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Video Consultation</title>

    <!-- JITSI SCRIPT -->
    <script src="https://meet.jit.si/external_api.js"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            background: #000;
        }
        #jitsi-container {
            width: 100vw;
            height: 100vh;
        }
    </style>
</head>


<body>

<div id="jitsi-container"></div>

<script>
    const domain = "meet.jit.si";
    const options = {
        roomName: "<%= room %>",
        parentNode: document.querySelector('#jitsi-container'),
        width: "100%",
        height: "100%",
        configOverwrite: {
            prejoinPageEnabled: true
        }
    };
    const api = new JitsiMeetExternalAPI(domain, options);
</script>

</body>
</html>