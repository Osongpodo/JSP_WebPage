<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail PAGE</title>
    <link rel="stylesheet" href="../main.css"/>
</head>
<body>

<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/jspbookdb";
    String dbUser = "root";
    String dbPassword = "0000";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
             Statement statement = connection.createStatement()) {

            String sql = "SELECT model, SUM(count) as total_count " +
                         "FROM (" +
                         "   SELECT model, count FROM case_table WHERE count >= 1 " +
                         "   UNION ALL " +
                         "   SELECT model, count FROM cpu_table WHERE count >= 1 " +
                         "   UNION ALL " +
                         "   SELECT model, count FROM graphic_card_table WHERE count >= 1 " +
                         "   UNION ALL " +
                         "   SELECT model, count FROM motherboard_table WHERE count >= 1 " +
                         "   UNION ALL " +
                         "   SELECT model, count FROM power_table WHERE count >= 1 " +
                         "   UNION ALL " +
                         "   SELECT model, count FROM storage_table WHERE count >= 1 " +
                         ") AS combined_table " +
                         "GROUP BY model " +
                         "ORDER BY total_count DESC";

            try (ResultSet resultSet = statement.executeQuery(sql)) {
                int index = 1;
                while (resultSet.next()) {
                    String model = resultSet.getString("model");
                    int count = resultSet.getInt("total_count");
                    out.println(index + ". " + model + " : " + count + "<br>");
                    index++;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("데이터 조회 중 오류 발생: " + e.getMessage());
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
    }
%>

</body>
</html>

<%@ include file="../mainbottom.jsp" %>
