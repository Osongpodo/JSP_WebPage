<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A List</title>
</head>
<body>
<div align="center">
    <h1>Q&A List</h1>
    <%
        Connection connection = null;
        PreparedStatement psmt = null;
        ResultSet result = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            String db_address = "jdbc:mysql://localhost:3306/jspbookdb";
            String db_username = "root";
            String db_pwd = "0000";
            connection = DriverManager.getConnection(db_address, db_username, db_pwd);

            String selectQuery = "SELECT * FROM post ORDER BY num DESC";

            psmt = connection.prepareStatement(selectQuery);
            result = psmt.executeQuery();
    %>

    <table border="1">
        <tr>
            <td colspan="5" align="center">
                <h4>자유롭게 질문하세요</h4>
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <button type="button" value="write new post" onclick="location.href='newPost.jsp'">write</button>
            </td>
        </tr>
        <tr>
            <td>번호</td>
            <td>작성자</td>
            <td>제목</td>
            <td>작성일자</td>
            <td>수정</td>
        </tr>
        <%
            while (result.next()) {
        %>
        <tr>
            <td><%= result.getInt("num") %></td>
            <td><%= result.getString("writer") %></td>
            <td><a href="readPost.jsp?num=<%= result.getInt("num") %>"><%= result.getString("title") %></a></td>
            <td><%= result.getTimestamp("reg_date") %></td>
            <td>
                <button type="button" value="edit" onclick="location.href='editPost.jsp?num=<%= result.getInt("num") %>'">edit</button>
                <button type="button" value="delete" onclick="location.href='deletePost_send.jsp?num=<%= result.getInt("num") %>'">delete</button>
            </td>
        </tr>
        <%
            }
        %>
    </table>
 <button type="button" onclick="location.href='main2.jsp'">메인으로</button>
    <%
        } catch (Exception ex) {
            out.println("Error: " + ex.getMessage());
        } finally {

            try {
                if (result != null) result.close();
                if (psmt != null) psmt.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                out.println("Error closing resources: " + e.getMessage());
            }
        }
    %>
</div>
</body>
</html>

<%@ include file="mainbottom.jsp" %>