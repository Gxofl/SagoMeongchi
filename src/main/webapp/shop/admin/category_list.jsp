<%@page import="shop.CategoryBean"%>
<%@page import="shop.CategoryDAO"%>
<%@page import="shop.SubCategoryBean"%>
<%@page import="shop.SubCategoryDAO"%>
<%@page import="shop.MainCategoryBean"%>
<%@page import="shop.MainCategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="admin_top.jsp" %>

<style type="text/css">
	#maincategorylist{
		margin : auto;
		width:60%;
		text-align:center;
		border : 1px solid black;
	}
	#maincategorylist td{
		border : 1px solid black;
	}
	#maincategorylist th{
		border : 1px solid black;
	}
	
	#preview{
		text-align:center;
	}
	
	#preview_table{
		margin:auto;
		width:50px%;
	}
	
</style>
	<%
		request.setCharacterEncoding("utf-8");
		MainCategoryDAO mcdao = MainCategoryDAO.getInstance();
		ArrayList<MainCategoryBean> mainCategory = mcdao.getAllMainCategory();
		
		SubCategoryDAO scdao = SubCategoryDAO.getInstance(); 
		
		CategoryDAO cdao = CategoryDAO.getInstance();
		ArrayList<CategoryBean> Category = cdao.getAllCategory();
		
	%>
	<br>
	<table class="table table-hover" id="maincategorylist">
 		 <thead>
  		  	<tr class="table-info">
      			<th scope="col">번호</th>
      			<th scope="col">상위 카테고리명</th>
      			<th scope="col">하위 카테고리번호</th>
      			<th scope="col">하위 카테고리명</th>
      			<th scope="col">수정 | 삭제</th>
   			 </tr>
 		 </thead>
		<%
			if(mainCategory.size()==0){
				%>
				<tr height="40">
					<td colspan="4">
						<b>카테고리가 없습니다.</b>
					</td>
				</tr>
				<%
			}else{
				for(CategoryBean cb : Category){
					%>
						<tr>
							<td><%=cb.getMcnum() %></td>
							<td><%=cb.getMcname() %></td>
							<td><%if(cb.getScnum()==0){%> <%}else{%><%=cb.getScnum()%><%}%></td>
							<td><%if(cb.getScname()==null){%> <%}else{%><%=cb.getScname()%><%}%></td>
							<td>
								<a href="category_update_form.jsp?Mcnum=<%=cb.getMcnum()%>&Scnum=<%=cb.getScnum()%>">수정</a> |
								<a href="category_delete_proc.jsp?Mcnum=<%=cb.getMcnum()%>&Scnum=<%=cb.getScnum()%>">삭제</a>
							</td>
						</tr>
					<%
				}//for
			}//else
		%>
	</table>
	<br>
	<hr style="border: dotted 1px black;" >
	<br>
	<div id="preview">
	<h4>미리보기</h4>
	<br>
	<table id="preview_table">
	 <% for(MainCategoryBean mb : mainCategory){
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
<%@include file="admin_bottom.jsp" %>