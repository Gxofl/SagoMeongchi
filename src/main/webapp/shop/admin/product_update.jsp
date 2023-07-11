<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.CategoryDAO"%>
<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	CategoryDAO cdao = CategoryDAO.getInstance();
	ArrayList<CategoryBean> Category = cdao.getAllCategory();
	
	String[] pspec = {"NORMAL", "NEW", "BEST"};
	
	String pno = request.getParameter("pno");
	ProductDAO pdao = ProductDAO.getInstance();
	ProductBean pb = pdao.getProductByPno(pno);
	
	String path = request.getContextPath()+"/shop/productimg/";
%>
<style>
	#product_update{
		width:50%;
		margin:auto;
		text-align:center;
	}
	
	h3{
		text-align:center;
		margin-top:40px;
		margin-bottom:40px;
	}
</style>
<h3>상품수정</h3>
<form action="product_update_proc.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="pno" value="<%=pb.getPno()%>">
	<table class="table table-hover" id="product_update">
	<tr>
		<td class="table-info">카테고리</td>
		<td>
			<select name="pcategory_fk" >
				<option value="선택">선택</option>
				<%
					for(CategoryBean cb : Category){
						String category_fk = pb.getPcategory_fk();
						String fullcategory ;
						
						if(cb.getScnum()!=0){
							fullcategory = cb.getMcname()+"["+cb.getScname()+"]";
						}else{
							fullcategory = cb.getMcname();
						}
						%>
						<option value="<%if(cb.getScnum()!=0){%><%=cb.getMcname()+"["+cb.getScname()+"]"%><%}else{%><%=cb.getMcname()%><%} %>"
							<%if(category_fk.contains(fullcategory)){%>selected<%} %>>
						<%if(cb.getScnum()!=0){%><%=cb.getMcname()+"["+cb.getScname()+"]"%><%}else{%><%=cb.getMcname()%><%} %>
						</option>
						<%
					}
				%>
			</select>
		</td>
	</tr>
	<tr>
		<td class="table-info">분류</td>
		<td>
			<select name="pspec" >
				<option value="선택">선택</option>
				<%
					for(String spec : pspec){
						%>
						<option value="<%=spec%>" <%if(spec.equals(pb.getPspec())){%>selected<%} %>><%=spec%></option>
						<%
					}
				%>
			</select>
		</td>
	</tr>
	<tr>
		<td class="table-info">상품명</td>
		<td><input type="text" name="pname" value="<%=pb.getPname()%>"></td>
	</tr>
	<tr>
		<td class="table-info">가격</td>
		<td><input type="text" name="price" value="<%=pb.getPrice()%>"></td>
	</tr>
	<tr>
		<td class="table-info">수량</td>
		<td><input type="text" name="stock" value="<%=pb.getStock()%>"></td>
	</tr>
	<tr>
		<td class="table-info">제조회사</td>
		<td><input type="text" name="pcompany" value="<%=pb.getPcompany()%>"></td>
	</tr>
	
	<tr>
		<td class="table-info">포인트</td>
		<td><input type="text" name="point" value="<%=pb.getPoint()%>"></td>
	</tr>
	
	<tr>
		<td class="table-info">상품이미지</td>
		<td>
		<img src="<%=path%><%=pb.getPimage()%>" width="200" height="200">
		<input type="text" name="orgpimage" value="<%=pb.getPimage()%>">
		<input type="file" name="pimage" class="form-control">
		
		</td>
	</tr>
	
	<tr>
		<td class="table-info">상세내용</td>
		<td>
		
		<textarea name="pcontents" cols="40" rows="5"><%=pb.getPcontents()%></textarea>
		<input type="hidden" name="pinputdate" value="<%=pb.getPinputdate()%>">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" class="btn btn-dark" value="수정">
			<input type="button" class="btn btn-danger" value="취소" onClick="location.href='product_list.jsp'">
		</td>
	</tr>
	

</table>

</form>
<%@ include file="admin_bottom.jsp" %>