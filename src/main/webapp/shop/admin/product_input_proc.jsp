<%@page import="shop.ProductDAO"%>
<%@page import="shop.ProductBean"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
product_input_proc.jsp
<%
	String configFolder = config.getServletContext().getRealPath("/shop/productimg");
	int maxsize = 1024*1024*100;
	
	MultipartRequest mr = new MultipartRequest(request, configFolder, maxsize, "UTF-8");
	
	ProductDAO pdao = ProductDAO.getInstance();
	int cnt = pdao.insertProduct(mr); 
	
	if(cnt>0){
		%>
		<script type="text/javascript">
			alert("상품등록 성공");
			location.href="product_list.jsp";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("상품등록 실패");
			history.go(-1);
		</script>
		<%
	}
	
%>
