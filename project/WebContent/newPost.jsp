<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "maintop.jsp" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>New Post</title>
</head>
<body>
	<h1>Q n A</h1>
	<form action = "newPost_send.jsp" method = "post">
		<table>
			<tr>
				<td>writer</td>
				<td><input type = "text" name = "writer"></td>
			</tr>
			<tr>
				<td>title</td>
				<td><input type = "text" name = "title"></td>
			</tr>
			<tr>
				<td>content</td>
				<td><textarea rows="10" cols="20" name = "content"></textarea></td>
			</tr>
			<tr>
				<td colspan = "2">
					<button type = "submit">save</button>
					<button type = "button" onClick="location.href='postList.jsp'">list</button>
					<button type = "reset">reset</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>

<%@ include file = "mainbottom.jsp" %>