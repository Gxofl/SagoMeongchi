<%@page import="shop.SubCategoryBean"%>
<%@page import="shop.SubCategoryDAO"%>
<%@page import="shop.MainCategoryBean"%>
<%@page import="shop.MainCategoryDAO"%>
<%@page import="shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<%
	request.setCharacterEncoding("utf-8");
	CategoryDAO cdao = CategoryDAO.getInstance();
	ArrayList<CategoryBean> category = cdao.getAllCategory();
	
	MainCategoryDAO mcdao = MainCategoryDAO.getInstance();
	ArrayList<MainCategoryBean> Maincategory = mcdao.getAllMainCategory();
	
	SubCategoryDAO scdao = SubCategoryDAO.getInstance(); 
	
	boolean flag = false;
%>
<style>
	h3{
		text-align:center;
	}
	
	#categoryinput{
		width:50%;
		margin:auto;
	}
	#preview{
		text-align:center;
	}
	
	#preview_table{
		margin:auto;
		width:50px%;
	}
</style>
<br>
<h3>상위 카테고리 등록</h3>
<br><br>
<form action="maincategory_proc.jsp" method="post">
	<table class="table table-hover" id="categoryinput" >
 		<tr>
 			<td class="table-info" width="150px" align="center">
 				상위 카테고리 목록
 			</td>
 			<td align="center">
 				
 					<%
 						for(MainCategoryBean mcb : Maincategory){
 							%>
 								[<%=mcb.getMcname()%>]&nbsp;
 							<%
 						}
 					%>
 				
 			</td>
 		</tr>
 		<tr>
 			<td class="table-info" align="center">추가할 카테고리이름</td>
 			<td>
 				<input type="text" class="form-control" name="mcname">
 			</td>
 		</tr>
 		<tr>
 			<td colspan="2" align="center">
 			<input type="submit" value="등록" onClick="return inputMainCategory()" class="btn btn-dark">
 			<input type="button" value="취소" onclick="history.go(-1)" class="btn btn-danger">
 			</td>
 		</tr>
 	</table>
</form>

<br>
	<hr style="border: dotted 1px black;" >
	<br>
	<div id="preview">
	<h4>미리보기</h4>
	<br>
	<table id="preview_table">
	 <% for(MainCategoryBean mb : Maincategory){
		 %>
		 <tr>
		 	<td align="center" height="30px">
			 	<ul><h6><%=mb.getMcname() %></h6></ul>
			 </td>
		 </tr>
		 <%
		 	ArrayList<SubCategoryBean> subcate = scdao.getAllSubCategory(mb.getMcname());
		 	if(subcate.size()>0){
		 		for(SubCategoryBean scb : subcate){
		 		%>
		 		<tr>
		 			<td align="left">
		 				<li><%=scb.getScname() %></li>
		 			</td>
		 		</tr>
		 		<%
		 		}//for  
		 	}//if
		 %>
		 		<tr>
		 		<td height="2px">
		 			--------
		 		</td>
		 		</tr>
		 <%
	 }
	 %>
	 </table>
	 </div>


<%@ include file="admin_bottom.jsp"%>