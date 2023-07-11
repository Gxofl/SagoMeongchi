<%@page import="shop.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("userId");
	
	MemberDAO mdao = MemberDAO.getInstance();
	boolean result = mdao.searchId(userId); 
	String data = "";
	if(result == true){ // 아이디 중복됨
		data = "NO";
		out.print(data);
	}else{
		data = "YES";
		out.print(data);
	}
%>