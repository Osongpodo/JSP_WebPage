<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file = "maintop.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Power Detail PAGE</title>
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
            String selectQuery = "SELECT * FROM power_table WHERE model=?";
            try (PreparedStatement selectStatement = connection.prepareStatement(selectQuery)) {
                selectStatement.setString(1, model);
                try (ResultSet resultSet = selectStatement.executeQuery()) {
                    if (resultSet.next()) {
                        out.println("<h2>Power Supply 세부 정보 : " + model + "</h2>");
                        out.println("<p>출시일: " + resultSet.getString("Release_date") + "</p>");
                        out.println("<p>회사: " + resultSet.getString("company") + "</p>");
                        out.println("<p>모델: " + resultSet.getString("model") + "</p>");
                        out.println("<p>코멘트 수: " + resultSet.getString("number_of_comments") + "</p>");
                        out.println("<p>최대 출력: " + resultSet.getString("maximum_output") + "</p>");
                        out.println("<p>80PLUS: " + resultSet.getString("80PLUS") + "</p>");
                        out.println("<p>모듈레이터: " + resultSet.getString("modulator") + "</p>");
                        out.println("<p>폼 팩터: " + resultSet.getString("form_factor") + "</p>");
                        out.println("<p>쿨링 팬: " + resultSet.getString("cooling_fan") + "</p>");
                        out.println("<p>베어링: " + resultSet.getString("bearing") + "</p>");
                        out.println("<p>보증 기간: " + resultSet.getString("guarantee") + "</p>");
                        out.println("<p>효율성 20% 부하: " + resultSet.getString("efficiency_20_percent") + "</p>");
                        out.println("<p>효율성 50% 부하: " + resultSet.getString("efficiency_50_percent") + "</p>");
                        out.println("<p>효율성 100% 부하: " + resultSet.getString("efficiency_100_percent") + "</p>");
                        out.println("<p>전압 하락: " + resultSet.getString("voltage_drop") + "</p>");
                        out.println("<p>최대 RPM: " + resultSet.getString("maximum_RPM") + "</p>");
                        out.println("<p>환경: " + resultSet.getString("environment") + "</p>");
                        out.println("<p>가격: $" + resultSet.getString("MSRP") + "</p>");
                        out.println("<p>재고: " + resultSet.getString("stock") + "</p>");
                        //쿠키
                        String cookieName = resultSet.getString("model").replace(' ', '_');
                        Cookie cookie = new Cookie(cookieName, "power");
                        cookie.setPath("/");
                        response.addCookie(cookie);
                        
                        String model_ = resultSet.getString("model");
                        String MSRP_ = resultSet.getString("MSRP");
                        
                        %>
                        <button onclick="toCart('<%=model_%>','<%= MSRP_%>')">장바구니에 추가</button><br><br>
                        <a href="power.jsp" style="color: black;">선택화면으로</a>
                        <a href="main2.jsp" style="color: black;">메인화면으로</a>
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