<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="maintop.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CASE 페이지</title>
</head>
<body>

<%
String jdbcUrl = "jdbc:mysql://localhost:3306/jspbookdb";
String dbUser = "root";
String dbPassword = "0000";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String selectQuery = "SELECT model FROM case_table";
            try (PreparedStatement selectStatement = connection.prepareStatement(selectQuery);
                 ResultSet resultSet = selectStatement.executeQuery()) {
                out.println("<h2>CASE PAGE</h2>");
                out.println("<ul>");
                while (resultSet.next()) {
                    String model = resultSet.getString("model");
%>
                    <li><a href="caseDetails.jsp?model=<%= model %>"><%= model %></a></li>
<%
                }
                out.println("</ul>");
                %>
                <a href="main2.jsp">메인화면으로</a>
                <%
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
<%@ include file="mainbottom.jsp" %>
