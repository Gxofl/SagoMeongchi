<%@page import="shop.mall.board.BoardBean"%>
<%@page import="shop.mall.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp"%>
<style>
	#boardupdate{
		width:60%;
		margin:auto;
		text-align:center;
	}
</style>
<%
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	String passwd = request.getParameter("passwd");
	
	BoardDAO bdao = BoardDAO.getInstance();
	boolean result = bdao.confirmPasswd(num, passwd);
	if(result==false){
		%>
		<script type="text/javascript">
			alert("비밀번호가 틀립니다");
			history.go(-1);
		</script>
		<%
	}else{
		BoardBean bb = bdao.getArticleByNum(num);
		
		%>
			<br>
		<form action="updateProc.jsp" method="post">
		<table class="table table-hover" id="boardupdate">
			<tr>
				<td class="table-warning">제 목</td>
				<td colspan="3" align="left">
					<input type="text" name="title" size="90" value="<%=bb.getTitle()%>">
					<input type="hidden" name="num" value="<%=num%>">
				</td>
			</tr>
			<tr>
				<td class="table-warning">작성자</td>
				<td align="left"><input type="text" name="writer" size="40" value="<%=bb.getWriter()%>"></td>
				<td class="table-warning">작성일</td>
				<td><input type="text" name="reg_date" disabled value="<%=bb.getReg_date()%>"></td>
			</tr>
			<tr>
				<td colspan="4" class="table-warning">글 내용</td>
			</tr>
			<tr>
				<td colspan="4">
				<textarea name="content" rows="8" cols="60" class="form-control"><%=bb.getContent()%></textarea>
				</td>
			</tr>
			<tr>
				<td class="table-warning">비밀번호</td>
				<td align="left"><input type="text" name="passwd" value="<%=bb.getPasswd()%>"></td>
				<td colspan="2" align="right">
					<input type="submit" value="수정" class="btn btn-dark" onClick="return boardSave()">
					<input type="button" value="취소" onclick="history.go(-1)" class="btn btn-outline-dark">
				</td>
			</tr>
		</table>
	</form>
	<br>
	<br>
		<%
	}
	
%>
<%@ include file="../../main_bottom.jsp"%>