<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전체 주문 내역 확인</title>
</head>
<body>
    <div align="center">
        <h3>전체 주문 내역 확인</h3>

        <table border="1">
            <tr>
                <th>주문 번호</th>
                <th>이름</th>
                <th>사용자 ID</th>
                <th>주소</th>
                <th>상품 목록</th>
                <th>결제 금액</th>
                <th>주문 일시</th>
            </tr>

            <% 
                String dbURL = "jdbc:mysql://localhost:3306/jspbookdb";
                String dbUser = "root";
                String dbPassword = "0000";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String getOrderHistoryQuery = "SELECT orderId, userName, userID, userAddress, userItem, userPay, orderDate FROM order_table";

                    try (PreparedStatement getOrderHistoryStmt = conn.prepareStatement(getOrderHistoryQuery);
                         ResultSet rs = getOrderHistoryStmt.executeQuery()) {

                        while (rs.next()) {
                            int orderId = rs.getInt("orderId");
                            String userName = rs.getString("userName");
                            String userIDFromResultSet = rs.getString("userID");
                            String userAddress = rs.getString("userAddress");
                            String userItem = rs.getString("userItem");
                            int userPay = rs.getInt("userPay");
                            String orderDate = rs.getString("orderDate");
            %>
                            <tr>
                                <td><%= orderId %></td>
                                <td><%= userName %></td>
                                <td><%= userIDFromResultSet %></td>
                                <td><%= userAddress %></td>
                                <td><%= userItem %></td>
                                <td>$<%= userPay %>달러</td>
                                <td><%= orderDate %></td>
                            </tr>
            <%
                        }
                    }

                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

        </table>
    </div>
    <button type="button" onclick="location.href='main2.jsp'">메인으로</button>
</body>
</html>
<%@ include file="mainbottom.jsp" %>