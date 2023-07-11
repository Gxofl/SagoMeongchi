<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	ProductDAO pdao = ProductDAO.getInstance();
	ArrayList<ProductBean> product = pdao.getAllProduct();
	
	String imgpath = request.getContextPath()+"/shop/productimg/";
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
<h1>All</h1>
<br><br>
<table id="product_all_list">
	<%
		for(int i=0; i<product.size(); i++){
			if(i%4==0){
				%>
				<tr>
				<%
			}
			%>
				<td>
					<a href="prod_view.jsp?pno=<%=product.get(i).getPno()%>"><img src="<%=imgpath%><%=product.get(i).getPimage()%>" width="200" height="200"></a><br>
					<br><h6><%=product.get(i).getPname()%></h6><br>
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
	%>	
</table>
<br>
<br>
<%@ include file="../../main_bottom.jsp"%>