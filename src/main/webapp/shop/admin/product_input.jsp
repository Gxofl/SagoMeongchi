<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="shop.CategoryBean"%>
<%@page import="shop.CategoryDAO"%>
<%@page import="shop.MainCategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.MainCategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	CategoryDAO cdao = CategoryDAO.getInstance();
	ArrayList<CategoryBean> Category = cdao.getAllCategory();
	
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
	String today = sdf.format(d);
	
	String[] pspec = {"NORMAL", "NEW", "BEST"};
%>
<style>
	#context{
		width : 40%;
		margin : auto;
		height : 1100px;
	}

</style>
<form action="product_input_proc.jsp" method="post" enctype="multipart/form-data">
  <fieldset>
   	<h2>상품등록</h2>
     <div class="form-group">
      <label for="exampleSelect1" class="form-label mt-4">카테고리</label>
      <select class="form-select" id="exampleSelect1" name="pcategory_fk">
        <option value="선택">선택</option>
       	 			<%
					for(CategoryBean cb : Category){
						%>
						<option value="<%if(cb.getScnum()!=0){%><%=cb.getMcname()+"["+cb.getScname()+"]"%><%}else{%><%=cb.getMcname()%><%} %>">
						<%if(cb.getScnum()!=0){%><%=cb.getMcname()+"["+cb.getScname()+"]"%><%}else{%><%=cb.getMcname()%><%} %>
						</option>
						<%
					}
					%>
      </select>
    </div>
    
    <div class="form-group">
      <label for="exampleSelect1" class="form-label mt-4">분류</label>
      <select class="form-select" id="exampleSelect1" name="pspec">
       		<option value="선택">선택</option>
				<%
					for(String spec : pspec){
						%>
						<option value="<%=spec%>"><%=spec %></option>
						<%
					}
				%>
      </select>
    </div>
    
    <div class="form-group">
      <label for="exampleInputEmail1" class="form-label mt-4">상품명</label>
      <input type="text" name="pname" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
    </div>
    
    <div class="form-group">
      <label for="exampleInputEmail1" class="form-label mt-4">가격</label>
      <input type="text" name="price" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
    </div>
    
    <div class="form-group">
      <label for="exampleInputEmail1" class="form-label mt-4">수량</label>
      <input type="text" name="stock" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
    </div>
    
    <div class="form-group">
      <label for="exampleInputEmail1" class="form-label mt-4">제조회사</label>
      <input type="text" name="pcompany" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
    </div>
    
    <div class="form-group">
      <label for="exampleInputEmail1" class="form-label mt-4">포인트</label>
      <input type="text" name="point" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
    </div>
    
    <div class="form-group">
      <label for="formFile" class="form-label mt-4">상품이미지</label>
      <input class="form-control" type="file" id="formFile" name="pimage">
    </div>
    
    <input type="hidden" name="pinputdate" value="<%=today%>">
    
    <div class="form-group">
      <label for="exampleTextarea" class="form-label mt-4">상세내용</label>
      <textarea class="form-control" id="exampleTextarea" name="pcontents" cols="40" rows="5"></textarea>
    </div>
    
    <button type="submit" class="btn btn-primary">등록</button>
    <button type="button" class="btn btn-primary">취소</button>
  </fieldset>
</form>

<%@ include file="admin_bottom.jsp" %>
