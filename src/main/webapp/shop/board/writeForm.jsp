<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
	function boardSave(){
		if($('input[name=title]').val()==""){
			alert("제목을 입력하세요");
			$('input[name=title]').focus();
			return false;
		}
		if($('input[name=writer]').val()==""){
			alert("작성자를 입력하세요");
			$('input[name=writer]').focus();
			return false;
		}
		if($('textarea[name=content]').val()==""){
			alert("글 내용을 입력하세요");
			$('textarea[name=content]').focus();
			return false;
		}
		if($('input[name=passwd]').val()==""){
			alert("비밀번호를 입력하세요");
			$('input[name=passwd]').focus();
			return false;
		}
	}
</script>
<%
	request.setCharacterEncoding("utf-8");

	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
%>
<style>
	#boardwrite{
		width:60%;
		margin:auto;
		text-align:center;
	}
	#title{
		text-align:center;
	}
</style>
	<br>
	<h3 id="title">글 작성</h3>
	<br>
	<form action="writeProc.jsp" method="post">
		<table class="table table-hover" id="boardwrite">
			<tr>
				<td class="table-warning">제 목</td>
				<td colspan="3" align="left"><input type="text" name="title" size="90"></td>
			</tr>
			<tr>
				<td class="table-warning">작성자</td>
				<td align="left"><input type="text" name="writer" size="40" value="<%
					if(sid!=null){%><%=sid%><%}%>"></td>
				<td class="table-warning">작성일</td>
				<td><input type="text" name="reg_date" disabled value="<%=sdf.format(d)%>"></td>
			</tr>
			<tr>
				<td colspan="4" class="table-warning">글 내용</td>
			</tr>
			<tr>
				<td colspan="4">
				<textarea name="content" rows="8" cols="60" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td class="table-warning">비밀번호 설정</td>
				<td align="left"><input type="text" name="passwd"></td>
				<td colspan="2" align="right">
					<input type="submit" value="확인" class="btn btn-dark" onClick="return boardSave()">
					<input type="button" value="취소" onclick="history.go(-1)" class="btn btn-outline-dark">
				</td>
			</tr>
		</table>
	</form>
	<br>
	<br>
<%@ include file="../../main_bottom.jsp" %>