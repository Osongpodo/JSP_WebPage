<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 처리</title>
</head>
<body>

<%

    String userID = request.getParameter("id");
    String userPassword = request.getParameter("password");
    String dbURL = "jdbc:mysql://localhost:3306/jspbookdb";
    String dbUser = "root";
    String dbPassword = "0000";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        String loginUserQuery = "SELECT * FROM user WHERE userID=? AND userPassword=?";
        try (PreparedStatement loginUserStmt = conn.prepareStatement(loginUserQuery)) {
            loginUserStmt.setString(1, userID);
            loginUserStmt.setString(2, userPassword);

            try (ResultSet rs = loginUserStmt.executeQuery()) {
                if (rs.next()) {
                    // 로그인 성공 시 세션에 사용자 정보 저장
                    session.setAttribute("userID", userID);
%>
                    <script>
                        alert("환영합니다, <%= userID %>님!");
                        location.href='main2.jsp';
                    </script>
<%
                } else {
%>
                    <script>
                        alert("아이디 또는 비밀번호가 잘못되었습니다.");
                        history.back(); 
                    </script>
<%
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
