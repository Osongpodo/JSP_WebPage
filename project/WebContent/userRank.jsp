<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>User Rank</title>
</head>
<body>
<%

    String dbURL = "jdbc:mysql://localhost:3306/jspbookdb";
    String dbUser = "root";
    String dbPassword = "0000";

    String sql = "SELECT userId, SUM(userPay) AS totalPay FROM order_table GROUP BY userId ORDER BY totalPay DESC";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
 %>
<table border="1">
    <tr>
        <td>userId</td>
        <td>totalPay</td>
    </tr>
<%
        while(rs.next()){ 
%>          
    <tr>
        <td><%=rs.getString("userId") %></td>
        <td><%=rs.getString("totalPay") %></td>
    </tr>
<%
        }
    }catch(Exception ex){
        out.println("Error : " + ex.getMessage());
    }
%>
</table>
</body>
</html>
<%@ include file="mainbottom.jsp" %>
