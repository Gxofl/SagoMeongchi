<%@page import="shop.SubCategoryDAO"%>
<%@page import="shop.MainCategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
category_delete_proc.jsp<br>
<%
	String Mcnum = request.getParameter("Mcnum");
	String Scnum = request.getParameter("Scnum");
	
	System.out.println("Mcnum : "+Mcnum);
	System.out.println("Scnum : "+Scnum);
	
	//하위 카테고리가 없으면 Scnum : 0 
	String msg ="";
	
	if(Scnum.equals("0")){ //하위 카테고리가 없으면
		//메인 카테고리 삭제
		MainCategoryDAO mcdao = MainCategoryDAO.getInstance();
		int cnt = mcdao.deleteMainCategory(Mcnum);
		if(cnt==1){
			msg = "삭제 성공";
		}else{
			msg = "삭제 실패";
		}
	}else{ //하위카테고리가 있으면
		SubCategoryDAO scdao = SubCategoryDAO.getInstance();
		int cnt = scdao.deleteSubCategory(Scnum);
		if(cnt==1){
			msg = "삭제 성공";
		}else{
			msg = "삭제 실패";
		}
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="category_list.jsp";
</script>