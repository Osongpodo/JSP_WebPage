<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    try {

        Class.forName("com.mysql.cj.jdbc.Driver");
        String db_address = "jdbc:mysql://localhost:3306/jspbookdb";
        String db_username = "root";
        String db_pwd = "0000";
        Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);

        request.setCharacterEncoding("UTF-8");

        Timestamp todayDate = new Timestamp(System.currentTimeMillis());

        String writer = request.getParameter("writer");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        int num = 0;

        // Get the maximum num
        String selectMaxNumQuery = "SELECT MAX(num) AS maxNum FROM post";
        try (PreparedStatement psmtMaxNum = connection.prepareStatement(selectMaxNumQuery);
             ResultSet resultMaxNum = psmtMaxNum.executeQuery()) {

            while (resultMaxNum.next()) {
                num = resultMaxNum.getInt("maxNum") + 1;
            }
        }

        // Insert data into post table
        String insertQuery = "INSERT INTO post(num, title, writer, content, reg_date) VALUES (?,?,?,?,?)";
        try (PreparedStatement psmt = connection.prepareStatement(insertQuery)) {

            psmt.setInt(1, num);
            psmt.setString(2, title);
            psmt.setString(3, writer);
            psmt.setString(4, content);
            psmt.setTimestamp(5, todayDate);

            psmt.executeUpdate();
        }

        response.sendRedirect("postList.jsp");
    } catch (Exception ex) {
        out.println("Error: " + ex.getMessage());
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