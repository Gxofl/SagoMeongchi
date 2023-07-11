<%@page import="shop.mall.board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
replyProc.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
%>
<jsp:useBean id="bb" class="shop.mall.board.BoardBean"/>
<jsp:setProperty name="bb" property="*"/>
<%
	bb.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	BoardDAO bdao = BoardDAO.getInstance();
	int cnt = bdao.replyArticle(bb);
	if(cnt>0){
		%>
		<script type="text/javascript">
			alert("답글을 성공적으로 작성했습니다");
			location.href="board.jsp?pageNum=<%=pageNum%>"
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("답글 작성을 실패했습니다.");
			location.href="board.jsp?pageNum=<%=pageNum%>"
		</script>
		<%
	}
	
%>