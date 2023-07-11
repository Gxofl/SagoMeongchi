<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	String cname = request.getParameter("cname");
	
	ProductDAO pdao = ProductDAO.getInstance();
	
	ArrayList<ProductBean> product = pdao.getProductByMcname(cname); 
	
	String imgpath = request.getContextPath() +"/shop/productimg/";
%>
<style>
	#product_all_list{
		margin : auto;
		text-align : center;
		width : 80%;
	}
	
	h1{
		text-align : center;
		margin-top : 20px;
	}
</style>
<br>
<h1><%=cname%></h1>
<br><br>
<table id="product_all_list">
	<%
	if(product.size()==0){
		out.print("<tr><td>등록된 상품이 없습니다.</td></tr>");
	}else{
		for(int i=0; i<product.size(); i++){
			if(i%4==0){
				%>
				<tr>
				<%
			}
			%>
				<td>
					<a href="prod_view.jsp?pno=<%=product.get(i).getPno()%>"><img src="<%=imgpath%><%=product.get(i).getPimage()%>" width="200" height="200"></a><br>
					<%=product.get(i).getPname()%><br>
					<%=df.format(product.get(i).getPrice())%>원<br>
				</td>
			<%
			if(i%4==3){
				%>
				</tr>
				<tr>
					<td colspan="4"><br><br><hr><br></td>
				</tr>
				<%
			}
		}
	}
	%>	
</table>
<br><br><br>
<%@ include file="../../main_bottom.jsp"%>
