<%@page import="java.sql.Timestamp"%>
<%@page import="shop.mall.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
writeProc.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
	BoardDAO bdao = BoardDAO.getInstance();
%>
<jsp:useBean id="bb" class="shop.mall.board.BoardBean"/>
<jsp:setProperty name="bb" property="*"/>
<%
	bb.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	int cnt = bdao.insertArticle(bb); 
	String url ="";
	String msg ="";
	if(cnt>0){
		msg ="작성 성공";
		url ="board.jsp";
	}else{
		msg="작성 실패";
		url="board.jsp";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>"
</script>