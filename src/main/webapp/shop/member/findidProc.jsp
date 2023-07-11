<%@page import="shop.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
findidProc.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	
	/* System.out.println(name);
	System.out.println(birth); */
	
	MemberDAO mdao = MemberDAO.getInstance();
	String userId = mdao.findId(name, birth);
	String msg = ""; 
	String url = "";
	if(userId == null){
		%>
		<script type="text/javascript">
			alert("일치하는 회원정보가 없습니다");
			var register = confirm("회원가입 하시겠습니까?");
			if(register==true){
				location.href="register.jsp"
			}else{
				location.href="<%=request.getContextPath()%>/main.jsp";
			}
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("<%=name%>님의 아이디는 : <%=userId%>");
			var findpw = confirm("비밀번호 찾기 하시겠습니까?");
			if(findpw==true){
				location.href="findpw.jsp?id=<%=userId%>";
			}else{
				location.href="<%=request.getContextPath()%>/login.jsp";
			}
		</script>
		<%
	}
%>
