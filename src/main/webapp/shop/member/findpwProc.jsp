<%@page import="shop.member.MemberBean"%>
<%@page import="shop.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
findpwProc.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mb" class="shop.member.MemberBean"/>
<jsp:setProperty name="mb" property="*"/>
<%
	MemberDAO mdao = MemberDAO.getInstance();
	MemberBean mb2 = mdao.findPw(mb); 
	
	String msg="";
	String url="";
	if(mb2==null){
		%>
		<script type="text/javascript">
			alert("찾는 정보가 없습니다");
			history.go(-1);
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("비밀번호는 : <%=mb2.getPassword()%>");
			location.href="<%=request.getContextPath()%>/login.jsp"
		</script>
		<%
	}
		%>
