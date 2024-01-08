<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="cartpg.cartpg" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="maintop.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문하기</title>
    <script type="text/javascript">
    function fnOrder() {
    
        var address = document.getElementById('address').value;


        if (address.trim() === '') {
            alert('주소를 입력하세요.');
            return;
        }

        document.getElementById('userName').value = '<%= session.getAttribute("userName") %>';
        document.getElementById('address').value = address;

        document.getElementById('orderForm').submit();
    }
    </script>
</head>
<body>
    <div align="center">
        <h3>주문서 작성</h3><hr>
        <form id="orderForm" action="orderconfirmation.jsp" method="post">
            아이디: <%= session.getAttribute("userID") %><br>

            <% 

                String dbURL = "jdbc:mysql://localhost:3306/jspbookdb";
                String dbUser = "root";
                String dbPassword = "0000";


                userID = (String) session.getAttribute("userID");

                String userName = "";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String findUserNameQuery = "SELECT userName FROM user WHERE userID=?";
                    try (PreparedStatement findUserNameStmt = conn.prepareStatement(findUserNameQuery)) {
                        findUserNameStmt.setString(1, userID);

                        try (ResultSet rs = findUserNameStmt.executeQuery()) {
                            if (rs.next()) {
                                userName = rs.getString("userName");

 
                                session.setAttribute("userName", userName);
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

            이름: <%= userName %><br>
            주소: <input type="text" id="address" name="address" required><br>

            <br>
            <h3>상품 내역</h3>
            <table border="1">
                <thead>
                    <tr>
                        <th>상품명</th>
                        <th>가격</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        request.setCharacterEncoding("utf-8");
                        ArrayList<cartpg> cart = (ArrayList<cartpg>) session.getAttribute("cart");

                        if (cart != null && cart.size() > 0) {
                            DecimalFormat df = new DecimalFormat("$#,##0");
                            int totalAmount = 0;

                            for (cartpg item : cart) {
                                totalAmount += Integer.parseInt(item.getPrice());
                    %>
                                <tr>
                                    <td><%= item.getName() %></td>
                                    <td><%= df.format(Integer.parseInt(item.getPrice())) %></td>
                                </tr>
                    <%
                            }
                    %>
                            <tr>
                                <td colspan="2">총 합계: <%= df.format(totalAmount) %></td>
                            </tr>
                    <%
                        } else {
                    %>
                            <tr>
                                <td colspan="2">장바구니가 비어 있습니다.</td>
                            </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <br><hr>
            <input type="hidden" id="userName" name="userName" value="">
            <input type="button" value="주문하기" onclick="fnOrder()" />

        </form>
    </div>
</body>
</html>
<%@ include file="mainbottom.jsp" %>