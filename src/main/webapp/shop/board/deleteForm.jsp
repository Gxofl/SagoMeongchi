<%@page import="shop.mall.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp" %>
<style>
	#deleteform{
		margin:auto;
		width:30%;
		text-align:center;
	}
</style>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
%>

<form action="deleteProc.jsp?num=<%=num%>&pageNum=<%=pageNum%>" method="post" id="deleteform">
	<table class="table table-hover">
		<tr>
			<td>비밀번호 입력 : </td>
			<td><input type="password" name="passwd"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="삭제">
				<input type="button" value="취소" onclick="history.go(-1)">
			</td>
		</tr>
	</table>
</form>
<%@ include file="../../main_bottom.jsp" %>
