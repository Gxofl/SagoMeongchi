<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
cartAdd.jsp
<%
	request.setCharacterEncoding("UTF-8");
	String pno = request.getParameter("pno");
	String pqty = request.getParameter("pqty");
	
	//System.out.println(pno+","+pqty);
%>
<jsp:useBean id="mallCart" class="shop.mall.CartBean" scope="session"/>

<%
	ProductDAO pdao = ProductDAO.getInstance();
	ProductBean pb = pdao.getProductByPno(pno);
	if(Integer.parseInt(pqty)>pb.getStock()){
		%>
		<script type="text/javascript">
			alert("주문수량이 재고수량보다 많습니다");
			history.go(-1);
		</script>
		<%
	}else{
		mallCart.addProduct(pno, pqty);
		response.sendRedirect("cartList.jsp");
	}

%>
