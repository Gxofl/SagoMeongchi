<%@page import="shop.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
register -> registerProc.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
	MemberDAO mdao = MemberDAO.getInstance();
%>
<jsp:useBean id="mb" class="shop.member.MemberBean"/>
<jsp:setProperty name="mb" property="*"/>
<%
	int cnt = mdao.insertMember(mb);
 	
	if(cnt<0){
		%>
			<script type="text/javascript">
				alert("가입실패");
				history.go(-1);
			</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("가입성공");
			location.href="<%=request.getContextPath()%>/login.jsp";
		</script>
	<%
	}
%>
