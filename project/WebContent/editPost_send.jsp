<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    try {
        // Connect JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        String db_address = "jdbc:mysql://localhost:3306/jspbookdb";
        String db_username = "root";
        String db_pwd = "0000";
        Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);

        request.setCharacterEncoding("UTF-8");

        String writer = request.getParameter("writer");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        String num = request.getParameter("num");

        // Update post
        String updateQuery = "UPDATE post SET title=?, writer=?, content=? WHERE num=?";
        try (PreparedStatement psmt = connection.prepareStatement(updateQuery)) {
            psmt.setString(1, title);
            psmt.setString(2, writer);
            psmt.setString(3, content);
            psmt.setString(4, num);

            psmt.executeUpdate();
        }

        response.sendRedirect("postList.jsp");

    } catch (Exception ex) {
        out.println("Error : " + ex.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

</body>
</html>
