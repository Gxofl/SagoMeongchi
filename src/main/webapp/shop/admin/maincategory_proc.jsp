<%@page import="shop.MainCategoryDAO"%>
<%@page import="shop.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
category_proc.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
	String mcname = request.getParameter("mcname");
	//System.out.println(mcname);
	
	MainCategoryDAO mcdao = MainCategoryDAO.getInstance();
	
	boolean flag = false;
	flag = mcdao.checkMainCategory(mcname); 
	String msg ="";
	String url ="";
	if(flag){ // 이미 있는 카테고리
		%>
			<script type="text/javascript">
			alert("동일한 이름의 카테고리가 이미 있습니다");
			history.go(-1);
			</script>
		<%
	}else{
		int cnt = mcdao.insertMainCategory(mcname); 
		if(cnt<0){ //등록실패
			%>
			<script type="text/javascript">
			alert("등록실패");
			history.go(-1);
			</script>
			<%
		}else{ //등록성공
			%>
			<script type="text/javascript">
			alert("등록성공");
			location.href="category_list.jsp";
			</script>
			<%
		}
	}
%>
