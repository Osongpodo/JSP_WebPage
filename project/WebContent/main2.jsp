<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MAKE YOUR OWN, CUSTOM PC!</title>
</head>
<body>
<div align="center">
	<table border="1">
	
		<tr height="100" >
			<td width="1400">
				<%@ include file="maintop.jsp" %>
			</td>
		</tr>
		<tr height="700" >
			<td width="1400">
				<%@ include file="mainmiddle.jsp" %>
			</td>
		</tr>
		<tr> 
			<td colspan="2">
				<%@ include file="mainbottom.jsp" %>
			</td>
		</tr>
	</table>
</div>

</body>
</html>
