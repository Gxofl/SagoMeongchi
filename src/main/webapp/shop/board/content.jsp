<%@page import="shop.mall.board.BoardBean"%>
<%@page import="shop.mall.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	
	BoardDAO bdao = BoardDAO.getInstance();
	BoardBean bb = bdao.getArticleByNum(num); 
%>
<style>
	#boardcontent{
		width : 60%;
		margin : auto;
		text-align:center;
	}
</style>
<script>
	$.ready(function(){
		var inputpasswd = document.f.passwd.value;
		alert(inputpasswd);
	})
</script>
<br>
<form action="updateForm.jsp" method="post" name="f">
<table class="table table-hover" id="boardcontent">

	
	<tr>
		<td align="right" colspan="4">
			<input type="button" class="btn btn-dark" value="답글쓰기" onclick="location.href='replyForm.jsp?ref=<%=bb.getRef()%>&re_step=<%=bb.getRe_step()%>&re_level=<%=bb.getRe_level()%>&pageNum=<%=pageNum%>&num=<%=num%>'">
		</td>
	</tr>
	
	<tr>
		<td colspan="4" class="table-warning">
			<b>제 목</b>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<h4><b><%=bb.getTitle()%></b></h4>
		</td>
	</tr>
	<tr>
		<td class="table-warning">작성자</td>
		<td align="left"><%=bb.getWriter()%></td>
		<td class="table-warning">작성일</td>
		<td><%=bb.getReg_date()%></td>
	</tr>
	<tr>
		<td colspan="4" class="table-warning">글 내용</td>
	</tr>
	<tr>
		<td colspan="4">
		<textarea name="content" rows="8" cols="60" class="form-control" readonly="readonly"><%=bb.getContent()%></textarea>
		</td>
	</tr>
	<tr>
		<td class="table-warning">비밀번호 입력</td>
		<td align="left">
			<input type="text" name="passwd">
			<input type="hidden" name="num" value="<%=num%>">
		</td>
		<td colspan="2" align="right">
				<input type="submit" value="수정" class="btn btn-dark">
				<input type="button" value="삭제" class="btn btn-dark"  onclick="location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
				<input type="button" value="글목록" onclick="location.href='board.jsp?pageNum=<%=pageNum%>'" class="btn btn-outline-dark">
		</td>
	</tr>
</table>
</form>
<br>
<br>
<%@ include file="../../main_bottom.jsp"%>