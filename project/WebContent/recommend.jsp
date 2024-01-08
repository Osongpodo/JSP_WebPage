<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="maintop.jsp" %>
<%
String[] img = {"VK02_Touch_LCD_Mesh_Tempered_Glass.jpg", "DLM4000_GLASS.jpg", "AIR_903_MAX.jpg", "i9-14900KF.jpg", "i9-14900K.jpg", "i7-14700KF.jpg", "Phantom_Gaming_RX_7600_OC.jpg", "RTX_4060_Ti_Twin_X2.jpg", "GALAX_RTX_4060_Ti_EX_WHITE_OC.jpg"};
String[] name = {"VK02_Touch_LCD...", "DLM4000_GLASS", "AIR_903_MAX", "i9-14900KF", "i9-14900K", "i7-14700KF", "Phantom_Gaming...", "RTX_4060_Ti...", "GALAX_RTX_4060_..."};
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
        function gomain() {
        	location.href = "main2.jsp";
        }

        function fnDetails(model, category) {
            location.href = category + "Details.jsp?model=" + model;
        }
    </script>
</head>
<body>
<div align="center">
    <h3>★☆★금주 추천 상품★☆★</h3>

<table border="1">
<tr>
    <td align="left">
        <input type="button" value="메인으로" onclick="gomain()" />
<td align="center" style="color: red; font-weight: bold;">
    23/12/18 ~ 23/12/24
</td>
    <td align="right">
        <input type="button" value="장바구니 보기" onclick="fnView()" />
    </td>
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
            out.println("<img src = '" + img[i] + "' width='150' height='150' />");
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
</body>
</html>
<%@ include file="mainbottom.jsp" %>
