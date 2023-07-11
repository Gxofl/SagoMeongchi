<%@page import="shop.SubCategoryDAO"%>
<%@page import="shop.MainCategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<style>
	.categoryupdate{
		margin:auto;
	}
</style>
<%
	request.setCharacterEncoding("utf-8");
	String Mcnum = request.getParameter("Mcnum");
	String Scnum = request.getParameter("Scnum");
	
	//System.out.println(Mcnum);
	//System.out.println(Scnum);
	
	MainCategoryDAO mcdao = MainCategoryDAO.getInstance();
	SubCategoryDAO scdao = SubCategoryDAO.getInstance();
	
	String mcname = mcdao.getMcnameByMcnum(Mcnum);
	String scname = scdao.getScnameByScnum(Scnum); 
	
	
	if(Scnum.equals("0")){ //서브카테고리 없을때
		%>
		<br>
		<form action="category_update_proc.jsp" method="post">
			<table width="20%" class="categoryupdate">
				<tr>
					<td align="center">
						<h6><%=mcname%> 수정</h6>
					</td>
				</tr>
				<tr>
					<td height="50px">
						수정할 이름 : <input type="text" name="mcname">
						<input type="hidden" name="Mcnum" value="<%=Mcnum%>">
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="submit" value="수정" onClick="return inputMainCategory()" class="btn btn-dark">
 						<input type="button" value="취소" onclick="history.go(-1)" class="btn btn-danger">		
					</td>
				</tr>
			</table>
		</form>
		<%
	}else{
		%>
		<br>
		<form action="category_update_proc.jsp" method="post">
			<table width="20%">
				<tr>
					<td align="center">
						<%=mcname%>의 하위카테고리<br>
						<h6><%=scname %> 수정</h6>
					</td>
				</tr>
				<tr>
					<td height="50px">
						수정할 이름 : <input type="text" name="scname">
						<input type="hidden" name="Scnum" value="<%=Scnum%>">
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="submit" value="수정" onClick="return inputSubCategory()" class="btn btn-dark">
 						<input type="button" value="취소" onclick="history.go(-1)" class="btn btn-danger">		
					</td>
				</tr>
			</table>
		</form>
		<%
	}
%>
<%@ include file="admin_bottom.jsp" %>