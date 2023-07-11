<%@page import="shop.SubCategoryDAO"%>
<%@page import="shop.MainCategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String Mcnum = request.getParameter("Mcnum");
	String mcname = request.getParameter("mcname");
	
	String Scnum = request.getParameter("Scnum");
	String scname = request.getParameter("scname");
	
	MainCategoryDAO mcdao = MainCategoryDAO.getInstance();
	SubCategoryDAO scdao = SubCategoryDAO.getInstance();
	
	if(Scnum==null){
		int cnt = mcdao.updateMaincategory(Mcnum, mcname);
		if(cnt>0){
			%>
			<script>
				alert("수정 성공");
				location.href="category_list.jsp";
			</script>
			<%
		}else{
			%>
			<script>
				alert("수정 실패");
				location.href="category_list.jsp";
			</script>
			<%
		}	
	}else{
		int cnt = scdao.updateSubcategory(Scnum, scname);
		if(cnt>0){
			%>
			<script>
				alert("수정 성공");
				location.href="category_list.jsp";
			</script>
			<%
		}else{
			%>
			<script>
				alert("수정 실패");
				location.href="category_list.jsp";
			</script>
			<%
		}	
	}
%>