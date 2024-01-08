<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file = "maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Graphic Card Detail PAGE</title>
    <link rel="stylesheet" href="../main.css"/>
</head>
<body>

<%
String jdbcUrl = "jdbc:mysql://localhost:3306/jspbookdb";
String dbUser = "root";
String dbPassword = "0000";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String model = request.getParameter("model");
            String selectQuery = "SELECT * FROM graphic_card_table WHERE model=?";
            try (PreparedStatement selectStatement = connection.prepareStatement(selectQuery)) {
                selectStatement.setString(1, model);
                try (ResultSet resultSet = selectStatement.executeQuery()) {
                    if (resultSet.next()) {
                        out.println("<h2>그래픽 카드 세부 정보 : " + model + "</h2>");
                        out.println("<p>제조사: " + resultSet.getString("manufacturer") + "</p>");
                        out.println("<p>출시일: " + resultSet.getString("release_date") + "</p>");
                        out.println("<p>회사: " + resultSet.getString("company") + "</p>");
                        out.println("<p>GPU: " + resultSet.getString("GPU") + "</p>");
                        out.println("<p>모델: " + resultSet.getString("model") + "</p>");
                        out.println("<p>코멘트 수: " + resultSet.getString("number_of_comments") + "</p>");
                        out.println("<p>부스트 클럭: " + resultSet.getString("boost_clock") + "</p>");
                        out.println("<p>메모리: " + resultSet.getString("memory") + "</p>");
                        out.println("<p>길이: " + resultSet.getString("length") + "</p>");
                        out.println("<p>베이스 전력: " + resultSet.getString("base_power") + "</p>");
                        out.println("<p>최대 전력: " + resultSet.getString("maximum_power") + "</p>");
                        out.println("<p>전원 공급: " + resultSet.getString("power_supply") + "</p>");
                        out.println("<p>코어 온도: " + resultSet.getString("core_temperature") + "</p>");
                        out.println("<p>소음: " + resultSet.getString("noise") + "</p>");
                        out.println("<p>3DMark Time Spy: " + resultSet.getString("3DMark_TS") + "</p>");
                        out.println("<p>드라이버 버전: " + resultSet.getString("driver_version") + "</p>");
                        out.println("<p>환경: " + resultSet.getString("environment") + "</p>");
                        out.println("<p>가격: $" + resultSet.getString("MSRP") + "</p>");
                        out.println("<p>재고: " + resultSet.getString("stock") + "</p>");
                        //쿠키
                        String cookieName = resultSet.getString("model").replace(' ', '_');
                        Cookie cookie = new Cookie(cookieName, "graphic");
                        cookie.setPath("/");
                        response.addCookie(cookie);
                        
                        String model_ = resultSet.getString("model");
                        String MSRP_ = resultSet.getString("MSRP");
                        
                        %>
                        <button onclick="toCart('<%=model_%>','<%= MSRP_%>')">장바구니에 추가</button><br><br>
                        <a href="graphic.jsp"  style="color: black;">선택화면으로</a>
                        <a href="main2.jsp"  style="color: black;">메인화면으로</a>
                        <%
                    } else {
                        out.println("<p>해당 모델의 정보를 찾을 수 없습니다.</p>");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("데이터 조회 중 오류 발생: " + e.getMessage());
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
    }
%>
<script>
    function toCart(model_, MSRP_) { // 장바구니에 추가
        alert("장바구니에 추가합니다.\n" + "model: " + model_ + "\nMSRP:" + MSRP_);
        window.location.href = "cartprocess.jsp?name=" + model_ + "&price=" + MSRP_;
    }
</script>

</body>
</html>

<%@ include file = "../mainbottom.jsp" %>