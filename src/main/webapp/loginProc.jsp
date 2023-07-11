<%@page import="shop.member.MemberBean"%>
<%@page import="shop.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
login.jsp => loginProc.jsp
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	MemberDAO mdao = MemberDAO.getInstance();
	
	MemberBean mb = mdao.getMemberInfo(id, password);
	
	
	if(mb.getId().equals("noid")){
		%>
			<script type="text/javascript">
				alert('없는 회원입니다');
				history.go(-1);
			</script>
		<%
	}
	else if(mb.getId().equals("defaultpassword")){
			%>
			<script type="text/javascript">
				alert('비밀번호가 틀립니다');
				history.go(-1);
			</script>
			<%
	}else{
		session.setAttribute("sid", id);
		session.setAttribute("mno" , mb.getNo());
		if(mb.getId().equals("admin")){ //관리자
			response.sendRedirect("./shop/admin/admin_main.jsp");
		}
		else{ //일반 사용자
			response.sendRedirect("main.jsp?id="+id);
		}
	}
	
	

	//관리자면 관리자홈으로
	//일반사용자면 main.jsp
%>