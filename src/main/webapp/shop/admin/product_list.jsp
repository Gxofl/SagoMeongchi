<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp"%>
<style>
	#productlist{
		margin : auto;
		text-align:center;
		width:70%;
	}
	h3{
		text-align : center;
	}
	#productlist th, #productlist td{
		border : 1px solid black;
	}
	#context{
		height:2000px;
	}

</style>
<%
	request.setCharacterEncoding("utf-8");
	ProductDAO pdao = ProductDAO.getInstance();
	ArrayList<ProductBean> products = pdao.getAllProduct();
	
	String[] title ={"번호", "카테고리", "분류", "상품명", "가격 / 포인트", "재고", "등록일", "수정|삭제"};
	
	DecimalFormat df = new DecimalFormat("###,###");
	
	String path = request.getContextPath() +"/shop/productimg/";
	
%>
<div id="product_list">
<br><h3>상품 목록</h3><br><br>
<table border="1" id="productlist" class="table table-hover">
	<tr class="table-info">
		<%
			for(int i=0; i<title.length; i++){
				%>
					<th scope="row"><%=title[i]%></th>
				<%
			}
		%>
	</tr>
	<%
		if(products.size()==0){
			%>
			<tr>
				<td colspan="8"> 등록된 상품이 없습니다</td>
			</tr>
			<%
		}else{
			for(ProductBean pb : products){
				%>
				<tr>
					<td><%=pb.getPno()%></td>
					<td><%=pb.getPcategory_fk()%></td>
					<td><%=pb.getPspec()%></td>
					<td>
						<img src="<%=path%><%=pb.getPimage()%>" width="50" height="50"><br>
						<b><%=pb.getPname()%></b>
					</td>
					<td>
						<font><%=df.format(pb.getPrice())%>원</font><br>
						<font color="red"><%=df.format(pb.getPoint()) %>point</font>
					</td>
					<td><%=pb.getStock() %>개</td>
					<td><%=pb.getPinputdate() %></td>
					<td>
						<a href="product_update.jsp?pno=<%=pb.getPno()%>">수정</a>|
						<a href="product_delete.jsp?pno=<%=pb.getPno()%>&pimage=<%=pb.getPimage()%>">삭제</a>
					</td>
				</tr>
				<%
			}
		}
	%>

</table>
</div>
<%@ include file="admin_bottom.jsp"%>