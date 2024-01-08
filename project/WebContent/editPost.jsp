<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Post</title>
</head>
<body>
    <h1>Edit Post</h1>
    <%
        Connection connection = null;
        PreparedStatement psmt = null;
        ResultSet result = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String db_address = "jdbc:mysql://localhost:3306/jspbookdb";
            String db_username = "root";
            String db_pwd = "0000";
            connection = DriverManager.getConnection(db_address, db_username, db_pwd);

            request.setCharacterEncoding("UTF-8");

            String num = request.getParameter("num");

            String selectQuery = "SELECT * FROM post WHERE num = ?";
            psmt = connection.prepareStatement(selectQuery);
            psmt.setString(1, num);

            result = psmt.executeQuery();

            if (result.next()) {
    %>
    <form action="editPost_send.jsp" method="post">
        <input type="hidden" name="num" value="<%=result.getInt("num") %>">
        <table border="1">
            <tr>
                <td>writer</td>
                <td><input type="text" name="writer" value="<%=result.getString("writer") %>"></td>
            </tr>
            <tr>
                <td>title</td>
                <td><input type="text" name="title" value="<%=result.getString("title") %>"></td>
            </tr>
            <tr>
                <td>content</td>
                <td><textarea rows="10" cols="20" name="content"><%=result.getString("content") %></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">edit</button>
                    <button type="button" onClick="location.href='postList.jsp'">list</button>
                    <button type="reset">reset</button>
                </td>
            </tr>
        </table>
    </form>
    <%
            }
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
</body>
</html>

<%@ include file="mainbottom.jsp" %>
