<%@page import="cartpg.cartpg"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String price = request.getParameter("price");

ArrayList<cartpg> cart = null;

Object obj = session.getAttribute("cart");   

if(obj == null) {    
    cart = new ArrayList<cartpg>();    
} else {            
    cart = (ArrayList<cartpg>) obj;
}

// Add the selected item to the cart.
cartpg item = new cartpg();
item.setName(name);
item.setPrice(price);
cart.add(item);

session.setAttribute("cart", cart);


%>
    <script type="text/javascript">
        alert("장바구니에 담겼습니다.");
        history.go(-1);
    </script>