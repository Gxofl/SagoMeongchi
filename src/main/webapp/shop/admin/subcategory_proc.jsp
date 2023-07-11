<%@page import="shop.SubCategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
subcategory_proc.jsp
<br>
<%
	request.setCharacterEncoding("utf-8");
	
	String scname = request.getParameter("scname");
//System.out.println(mcname);

	SubCategoryDAO scdao = SubCategoryDAO.getInstance();
%>
<jsp:useBean id="subbean" class="shop.SubCategoryBean"/>
<jsp:setProperty name="subbean" property="*"/>
<%
	boolean flag = false;
	flag = scdao.checkSubCategory(scname);  
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
			subbean.setScname(scname);
			int cnt = scdao.insertSubCategory(subbean); 
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
%>