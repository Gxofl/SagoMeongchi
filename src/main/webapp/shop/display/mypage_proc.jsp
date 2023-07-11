<%@page import="shop.mall.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String orderdate = request.getParameter("orderdate");
	String orderid = request.getParameter("orderid");
	
	System.out.println("id:"+id);
	System.out.println("orderdate:"+orderdate);
	System.out.println("orderid:"+orderid);
	
	OrderDAO odao = OrderDAO.getInstance();
	int cnt = odao.deleteOrder(id, orderdate, orderid);
	if(cnt>0){
		%>
			<script>
				alert("주문이 취소되었습니다");
				location.href="mypage.jsp";
			</script>
		<%
	}else{
		%>
			<script>
				alert("주문 취소를 실패했습니다");
				location.href="mypage.jsp";
			</script>
		<%
	}

%>