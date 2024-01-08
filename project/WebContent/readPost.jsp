<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Read Post</title>
</head>
<body>
	<h1>Read Post</h1>
	<%
	try{

		Class.forName("com.mysql.jdbc.Driver");
		String db_address = "jdbc:mysql://localhost:3306/jspbookdb";
		String db_username = "root";
		String db_pwd = "0000";
		Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
		
		request.setCharacterEncoding("UTF-8");
		
		String num = request.getParameter("num");
		
		String insertQuery = "SELECT * FROM post WHERE num = " + num;
		
		PreparedStatement psmt = connection.prepareStatement(insertQuery);
		
		ResultSet result = psmt.executeQuery(); %>
		
		<table border = "1">
		<%
			while(result.next()){
		%>
		<tr>
			<td>num</td>
			<td><%=result.getInt("num") %></td>
		</tr>
		<tr>
			<td>regDate</td>
			<td><%=result.getTimestamp("reg_date") %></td>
		</tr>
		<tr>
			<td>writer</td>
			<td><%=result.getString("writer") %></td>
		</tr>
		<tr>
			<td>title</td>
			<td><%=result.getString("title") %></td>
		</tr>
		<tr>
			<td>content</td>
			<td><%=result.getString("content") %></td>
		</tr>
		<tr>
			<td colspan = "2">
				<button type = button onClick = "location.href = 'postList.jsp'">list</button>
			</td>
		</tr>
		<%} %>
		</table>
	<%
	} catch(Exception ex){
		out.println("Error : " + ex.getMessage());
	}
	%>

</body>
</html>

<%@ include file = "mainbottom.jsp" %>
