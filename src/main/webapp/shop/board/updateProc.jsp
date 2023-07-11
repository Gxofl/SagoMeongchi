<%@page import="shop.mall.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
updateProc.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
%>
<jsp:useBean id="bb" class="shop.mall.board.BoardBean"/>
<jsp:setProperty name="bb" property="*"/>
<%
	BoardDAO bdao = BoardDAO.getInstance();
	int cnt = bdao.updateArticle(bb); 
	String msg="";
	String url="";
	if(cnt>0){
		msg="수정성공";
		url="content.jsp?num="+num;
	}else{
		msg="수정실패";
		url="content.jsp?num="+num;
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
