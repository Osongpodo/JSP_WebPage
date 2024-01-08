<%@page import="java.text.DecimalFormat"%>
<%@page import="cartpg.cartpg"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="maintop.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<cartpg> cart = null;

Object obj = session.getAttribute("cart");

if(obj == null) {	
	cart = new ArrayList<cartpg>();	
} else {			
	cart = (ArrayList<cartpg>) obj;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart View</title>
<script type="text/javascript">
function fnOrder(){
	alert("주문하시겠습니까?");
	window.location.href = 'orderform.jsp';
}

function fnClear(){
	if(confirm("장바구니를 비우시겠습니까?")) {
		location.href = "cartclear.jsp";	
	}
}

function fnGo(){
	location.href = "main2.jsp";
}
</script>
</head>
<body>
<div align="center">
	<h3>장바구니 확인</h3>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>상품명</th>
			<th>가격</th>
			<th>결제 금액</th>
		</tr>
<%
//추가한 부분
String dbURL = "jdbc:mysql://localhost:3306/jspbookdb";
String dbUser = "root";
String dbPassword = "0000";
int cpu_ = 0;
int motherboard_ = 0;
String manufacturer_cpu = "";
String manufacturer_motherboard = "";


if(cart.size() == 0) {
    out.println("<tr align='center'>");
    out.println("<td colspan='5'>");
    out.println("장바구니에 담긴 상품이 없습니다.         ");
    out.println("<a href='main2.jsp'>메인으로</a>");
    out.println("</td>");
    out.println("</tr>");
} else {
    int totalSum = 0;
    DecimalFormat df = new DecimalFormat("$#,##0");
    for(int i = 0; i < cart.size(); i++) {
        cartpg dto = cart.get(i);
        out.println("<tr align='center'>");
        out.println("<td>" + (i + 1) + "</td>");
        out.println("<td>" + dto.getName() + "</td>");


        int price = Integer.parseInt(dto.getPrice());

        out.println("<td>" + df.format(price) + "</td>");
        totalSum += price;
        
        out.println("</tr>");
    }
    out.println("<tr align='center'>");
    out.println("<td colspan='3'>");
    out.println("<input type='button' value='주문하기' onclick='fnOrder()' />");
    out.println("<input type='button' value='장바구니 비우기' onclick='fnClear()' />");
    out.println("<input type='button' value='쇼핑 계속하기' onclick='fnGo()' />");
    out.println("</td>");
    out.println("<td>");
    out.println(df.format(totalSum));
    out.println("</td>");
    out.println("</tr>");
    
    //추가한 부분
    if (cpu_ == 1 && motherboard_ == 1) {
        if (manufacturer_cpu.equals(manufacturer_motherboard)) {
            out.println("<tr align='center'>");
            out.println("<td colspan='4'>");
            out.println("CPU와 Motherboard의 제조사가 일치합니다.");
            out.println("</td>");
            out.println("</tr>");
        }
    }
}
%>
	</table>
</div>
</body>
</html>
<%@ include file="mainbottom.jsp" %>