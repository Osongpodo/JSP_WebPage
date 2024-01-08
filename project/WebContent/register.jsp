<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입현황</title>
</head>
<body>

<%
    String userID = request.getParameter("id");
    String userPassword = request.getParameter("password");
    String userName = request.getParameter("name");
    String userGender = request.getParameter("gender");
    String userPersonal_number = request.getParameter("personal_number");

    String dbURL = "jdbc:mysql://localhost:3306/jspbookdb";
    String dbUser = "root";
    String dbPassword = "0000";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        String checkUserQuery = "SELECT userID FROM user WHERE userID=?";
        try (PreparedStatement checkUserStmt = conn.prepareStatement(checkUserQuery)) {
            checkUserStmt.setString(1, userID);
            try (ResultSet rs = checkUserStmt.executeQuery()) {
                if (rs.next()) {
%>
                    <p>이미 <%= userID %>로 등록되어 있습니다.</p>
<button onclick="location.href='main.html'">로그인 페이지로 이동</button>
<%
                } else {
                    String insertUserQuery = "INSERT INTO user (userID, userPassword, userName, userGender, userPersonal_number) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement insertUserStmt = conn.prepareStatement(insertUserQuery)) {
                        insertUserStmt.setString(1, userID);
                        insertUserStmt.setString(2, userPassword);
                        insertUserStmt.setString(3, userName);
                        insertUserStmt.setString(4, userGender);
                        insertUserStmt.setString(5, userPersonal_number);
                        insertUserStmt.executeUpdate();
%>
                        <p>회원가입에 성공하였습니다.</p>
<button onclick="location.href='main.html'">로그인 페이지로 이동</button>
<%
                    }
                }
            }
        }
    } catch (Exception e) {

        e.printStackTrace();
    }
%>

</body>
</html>
