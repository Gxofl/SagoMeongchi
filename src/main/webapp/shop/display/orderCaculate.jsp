<%@page import="shop.ProductDAO"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="shop.mall.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
orderCaculate.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mallCart" class="shop.mall.CartBean" scope="session"/>
<%
	int mno = (Integer)session.getAttribute("mno");
	String sid = (String)session.getAttribute("sid");

	OrderDAO odao = OrderDAO.getInstance();
	
	Vector<ProductBean> cartlist = mallCart.getAllproduct();
	int cnt = odao.insertOrder(mno, cartlist, sid); 
	
	ProductDAO pdao = ProductDAO.getInstance();
	
	String msg = "";
	if(cnt==cartlist.size()-1){ 
		msg = "주문 성공";
		int result = pdao.updateStock(cartlist); 
		if(result==cartlist.size()-1){
			System.out.println("재고 빼기 성공");
			mallCart.deleteAllCart();
		}
	}else{
		msg = "주문 실패";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=request.getContextPath()%>/main.jsp";
</script>