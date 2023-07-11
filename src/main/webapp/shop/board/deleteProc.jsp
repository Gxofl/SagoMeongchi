<%@page import="shop.mall.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	String passwd = request.getParameter("passwd");
 	String num = request.getParameter("num");
 	String pageNum = request.getParameter("pageNum");
 	
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
 		int cnt = bdao.deleteArticle(num);
 		if(cnt>0){
 			%>
 	 		<script type="text/javascript">
 	 			alert("삭제성공");
 	 			location.href='board.jsp?pageNum=<%=pageNum%>';
 	 		</script>
 	 		<%
 		}else{
 			%>
 	 		<script type="text/javascript">
 	 			alert("삭제실패");
 	 			history.go(-1);
 	 		</script>
 	 		<%
 		}
 	}
 %>
