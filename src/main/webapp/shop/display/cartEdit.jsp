<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
cartEdit.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
	String pno = request.getParameter("pno");
	String pqty = request.getParameter("pqty");
%>
<jsp:useBean id="mallCart" class="shop.mall.CartBean" scope="session"/>
<%
	mallCart.editPqty(pno, pqty);
	response.sendRedirect("cartList.jsp");
%>