<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전체 회원 정보 확인</title>
</head>
<body>
    <div align="center">
        <h3>전체 회원 정보 확인</h3>

        <table border="1">
            <tr>
                <th>User ID</th>
                <th>User Password</th>
                <th>User Name</th>
                <th>User Gender</th>
                <th>User Personal Number</th>
            </tr>

            <% 
                String dbURL = "jdbc:mysql://localhost:3306/jspbookdb";
                String dbUser = "root";
                String dbPassword = "0000";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String getUserListQuery = "SELECT userID, userPassword, userName, userGender, userPersonal_number FROM user";

                    try (PreparedStatement getUserListStmt = conn.prepareStatement(getUserListQuery);
                         ResultSet rs = getUserListStmt.executeQuery()) {

                        while (rs.next()) {
                            String user_ID = rs.getString("userID");  
                            String userPassword = rs.getString("userPassword");
                            String userName = rs.getString("userName");
                            String userGender = rs.getString("userGender");
                            String userPersonalNumber = rs.getString("userPersonal_number");
            %>
                            <tr>
                                <td><%= user_ID %></td>
                                <td><%= userPassword %></td>
                                <td><%= userName %></td>
                                <td><%= userGender %></td>
                                <td><%= userPersonalNumber %></td>
                            </tr>
            <%
                        }
                    }

                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

        </table>
    </div>
    <button type="button" onclick="location.href='main2.jsp'">메인으로</button>
</body>
</html>
<%@ include file="mainbottom.jsp" %>