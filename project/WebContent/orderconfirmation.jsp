<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="cartpg.cartpg" %>
<%@ include file="maintop.jsp" %>

<%

    String dbURL = "jdbc:mysql://localhost:3306/jspbookdb";
    String dbUser = "root";
    String dbPassword = "0000";

    userID = (String) session.getAttribute("userID");
    String userName = (String) session.getAttribute("userName");
    String userAddress = request.getParameter("address");
    

    ArrayList<cartpg> cart = (ArrayList<cartpg>) session.getAttribute("cart");
    StringBuilder userItemBuilder = new StringBuilder();

    if (cart != null && !cart.isEmpty()) {
        for (cartpg item : cart) {
            userItemBuilder.append(item.getName()).append(", ");
        }

        userItemBuilder.setLength(userItemBuilder.length() - 2);
    }

    String userItem = userItemBuilder.toString();
    
    int userPay = 0;
    for (cartpg item : cart) {
        userPay += Integer.parseInt(item.getPrice());
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        String insertOrderQuery = "INSERT INTO `order_table` (userName, userID, userAddress, userItem, userPay) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement insertOrderStmt = conn.prepareStatement(insertOrderQuery)) {
            insertOrderStmt.setString(1, userName);
            insertOrderStmt.setString(2, userID);
            insertOrderStmt.setString(3, userAddress);
            insertOrderStmt.setString(4, userItem);
            insertOrderStmt.setInt(5, userPay);

            insertOrderStmt.executeUpdate();
        }

        String[] userItems = userItem.split(", ");
        for (String item : userItems) {
            String updateCaseQuery = "UPDATE case_table SET count = count + 1 WHERE model = ?";
            try (PreparedStatement updateCaseStmt = conn.prepareStatement(updateCaseQuery)) {
                updateCaseStmt.setString(1, item);
                updateCaseStmt.executeUpdate();
            }

            String updateCpuQuery = "UPDATE cpu_table SET count = count + 1 WHERE model = ?";
            try (PreparedStatement updateCpuStmt = conn.prepareStatement(updateCpuQuery)) {
                updateCpuStmt.setString(1, item);
                updateCpuStmt.executeUpdate();
            }

            String updateGraphicCardQuery = "UPDATE graphic_card_table SET count = count + 1 WHERE model = ?";
            try (PreparedStatement updateGraphicCardStmt = conn.prepareStatement(updateGraphicCardQuery)) {
                updateGraphicCardStmt.setString(1, item);
                updateGraphicCardStmt.executeUpdate();
            }

            String updateMotherboardQuery = "UPDATE motherboard_table SET count = count + 1 WHERE model = ?";
            try (PreparedStatement updateMotherboardStmt = conn.prepareStatement(updateMotherboardQuery)) {
                updateMotherboardStmt.setString(1, item);
                updateMotherboardStmt.executeUpdate();
            }

            String updatePowerQuery = "UPDATE power_table SET count = count + 1 WHERE model = ?";
            try (PreparedStatement updatePowerStmt = conn.prepareStatement(updatePowerQuery)) {
                updatePowerStmt.setString(1, item);
                updatePowerStmt.executeUpdate();
            }

            String updateStorageQuery = "UPDATE storage_table SET count = count + 1 WHERE model = ?";
            try (PreparedStatement updateStorageStmt = conn.prepareStatement(updateStorageQuery)) {
                updateStorageStmt.setString(1, item);
                updateStorageStmt.executeUpdate();
            }
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 내역</title>
</head>
<body>
    <div align="center">
        <h3>주문이 완료되었습니다.</h3>
        <button type="button" onclick="location.href='main2.jsp'">메인으로</button>
    </div>
</body>
</html>
<%@ include file="mainbottom.jsp" %>