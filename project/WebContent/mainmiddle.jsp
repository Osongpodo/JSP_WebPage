<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String[] img = {"VK02_Touch_LCD_Mesh_Tempered_Glass.jpg", "DLM4000_GLASS.jpg", "AIR_903_MAX.jpg", "i9-14900KF.jpg", "i9-14900K.jpg", "i7-14700KF.jpg", "Phantom_Gaming_RX_7600_OC.jpg", "RTX_4060_Ti_Twin_X2.jpg", "GALAX_RTX_4060_Ti_EX_WHITE_OC.jpg"};
String[] name = {"VK02_Touch_LCD_Mesh_Tempered_Glass", "DLM4000_GLASS", "AIR_903_MAX", "i9-14900KF", "i9-14900K", "i7-14700KF", "Phantom_Gaming_RX_7600_OC", "RTX_4060_Ti_Twin_X2.jpg", "GALAX_RTX_4060_Ti_EX_WHITE_OC"};
String[] price = {"200", "50", "100", "574", "599", "394", "269", "499", "499"};
String[] model = {"VK02_Touch_LCD_Mesh_Tempered_Glass", "DLM4000_GLASS", "AIR_903_MAX", "i9-14900KF", "i9-14900K", "i7-14700KF", "Phantom_Gaming_RX_7600_OC", "RTX_4060_Ti_Twin_X2", "GALAX_RTX_4060_Ti_EX_WHITE_OC"};
String[] category = {"case","case","case","cpu","cpu","cpu","graphic","graphic","graphic"};
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MAKE YOUR OWN, CUSTOM PC!</title>
    <script type="text/javascript">
        function fnCart(name, price) {
            if (confirm("장바구니에 담으시겠습니까?")) {
                location.href = "cartprocess.jsp?name=" + name + "&price=" + price;
            }
        }

        function fnView() {
                location.href = "cartview.jsp";
        }


        function fnDetails(model, category) {
            location.href = category + "Details.jsp?model=" + model;
        }
    </script>
</head>
<body>
<!-- <button onclick="goTorecommendPage()">이번주 추천 상품</button><br>
<button onclick="goToPage('case')">CASE 페이지로 이동</button>
<button onclick="goToPage('cpu')">CPU 페이지로 이동</button>
<button onclick="goToPage('graphic')">그래픽카드 페이지로 이동</button>
<button onclick="goToPage('motherboard')">Motherboard 페이지로 이동</button>
<button onclick="goToPage('power')">POWER 페이지로 이동</button>
<button onclick="goToPage('storage')">Storage 페이지로 이동</button><br>
<button onclick="goToMakedbPage()">db생성</button>
<button onclick="goToDeletedbPage()">db삭제</button> -->

<div align="center">
    <h3>★☆★금주 추천 상품★☆★</h3>

<table border="1">
<tr>

<td align="center" colspan="3" style="color: red; font-weight: bold;">
    23/12/18 ~ 23/12/24
</td>
 <!--    <td align="right">
        <input type="button" value="장바구니 보기" onclick="fnView()" />
    </td> -->
</tr>

        <%
        for (int i = 0; i < img.length; i++) {
            if (i % 3 == 0) {
                out.println("<tr align='center'>");
            }
            out.println("<td>");
            out.println("<table>");
            out.println("<tr align='center'>");
            out.println("<td>");
            out.println("<img src = '" + img[i] + "' width='300' height='250' />");
            out.println("</td>");
            out.println("</tr>");
            
             //상품명
            out.println("<tr align='center'>");
            out.println("<td>");
            out.println("<b>" + name[i] + "</b>");
            out.println("</td>");
            out.println("</tr>");
				
              //가격
            out.println("<tr align='center'>");
            out.println("<td>");
            out.println("<b>$" + price[i] + "달러</b>");
            out.println("</td>");
            out.println("</tr>");

              //상세정보
            out.println("<tr align='center'>");
            out.println("<td>");
            out.println("<a href='#' onclick='fnDetails(\"" + model[i] + "\", \"" + category[i] + "\")'>상세보기</a>");
            out.println("</td>");
            out.println("</tr>");

              //장바구니
            out.println("<tr align='center'>");
            out.println("<td>");
            out.println("<input type='button' value='장바구니 담기' ");
            out.println("onclick='fnCart(\"" + name[i] + "\", \"" + price[i] + "\")' />");
            out.println("</td>");
            out.println("</tr>");

            out.println("</table>");
            out.println("</td>");
            if (i % 3 == 2) {
                out.println("</tr>");
            }
        }
        %>
    </table>
</div>
<script>
	function goTorecommendPage() {
	    window.location.href = "recommend.jsp";
	}
    function goToMakedbPage() {
        window.location.href = "makeDatabase.jsp";
    }
    function goToDeletedbPage() {
        window.location.href = "deletedata.jsp";
    }
    
    
	function goToPage(type) {
		window.location.href =  type + ".jsp";
	}
    function deleteCookies() { // 쿠키 제거 함수, 모든 쿠키의 만료 날짜를 과거 날짜로 만들어 삭제
        var cookies = document.cookie.split(";");

        for (var i = 0; i < cookies.length; i++) {
            var cookie = cookies[i];
            var eqPos = cookie.indexOf("="); // 등호는 쿠키 name, value 구분자
            var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
            document.cookie = name + "=;expires=Thu, 01 Jan 2000 00:00:00 GMT;path=/";
        }
        alert("열람 기록이 삭제되었습니다.");
        window.location.href = "main2.jsp";
    }

</script>
    
	<br><br><br><br><h3>최근에 열람한 부품 목록</h3> <button onclick="deleteCookies()">열람 기록 삭제</button> <br><br>
	<%
	Cookie[] cookies = request.getCookies();
	if (cookies == null || cookies.length == 1) {
	    %>
	    최근에 본 부품이 없습니다.
	    <%
	}
	if (cookies != null && cookies.length > 0) {
	    for (int i = cookies.length - 1; i > 0; i--) {
	    	String partModel = cookies[i].getName();
	        String value = cookies[i].getValue();
	        if (!model.equals("JSESSIONID")) {
        		%>
		        <br><li><a href="<%= value %>Details.jsp?model=<%= partModel %>"><%= value %> : <%= partModel %></a></li>
		        <%
	        }
	    }
	}
	%>

</body>
</html>