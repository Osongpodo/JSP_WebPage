<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>MainTop</title>
    <link rel="stylesheet" href="./main.css"/>
</head>
<body>
    <header id="header">
        <h1>CUSTOM PC</h1>
        <h3>MAKE YOUR OWN!</h3>    
    </header>
    <nav id="index">
        <a href="make.jsp">Make</a> &nbsp; &nbsp; &nbsp;
        
        <a href="cartview.jsp">Result</a> &nbsp; &nbsp; &nbsp;
        <a href="orderRank.jsp">Order Rank</a> &nbsp; &nbsp; &nbsp;
        <a href="postList.jsp">Ask</a> &nbsp; &nbsp; &nbsp;
         <a href="myPage.jsp">My Page</a> &nbsp; &nbsp; &nbsp;
                 <% HttpSession currentsession = request.getSession(); String userID = (String) session.getAttribute("userID"); if(userID == null) { %>
                        <script> alert("로그인 후 이용해 주세요."); location.href='main.html'; </script>
                    <% } else { %>
                        <%= userID %>님 환영합니다!&nbsp; &nbsp; &nbsp;<br>
         
         <a href="case.jsp">CASE</a> &nbsp; &nbsp; &nbsp;
         <a href="cpu.jsp">CPU</a> &nbsp; &nbsp; &nbsp;
         <a href="graphic.jsp">GRAPHIC CARD</a> &nbsp; &nbsp; &nbsp;
         <a href="motherboard.jsp">MOTHER BOARD</a> &nbsp; &nbsp; &nbsp;
         <a href="power.jsp">POWER</a> &nbsp; &nbsp; &nbsp;
         <a href="storage.jsp">STORAGE</a> &nbsp; &nbsp; &nbsp;
                        
    </nav>
                        <span style="float: right; text-align: right;">
                        <form action="logout.jsp" method="post" style="display: inline;">
            <input type="submit" value="로그아웃">
        </form>
    </span>
                    <% } %>
                    
    <!-- 관리자 추가된 부분 -->  
<% 
String id = (String) session.getAttribute("userID");
if(id != null && id.equals("admin")) { 
%>
    <input type="button" value="회원전체목록(관리자용)" onclick="location.href='memberlist.jsp'">
    <input type="button" value="주문전체목록(관리자용)" onclick="location.href='memberorderlist.jsp'">
    <input type="button" value="고객주문순위(관리자용)" onclick="location.href='userRank.jsp'">
<%
}
%>
</body>
</html>