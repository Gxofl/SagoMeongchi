<%@page import="shop.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	MemberDAO mdao = MemberDAO.getInstance();
	ArrayList<MemberBean> memberlist = mdao.getAllMembers();
%>
<style>
	#context{
		text-align:center;
	}
	#memberlist{
		width:80%;
		margin:auto;
		text-align:center;
	}
	h2{
		text-align:center;
	}
</style>
<h2>가입 회원 목록</h2><br>
<font>가입된 회원은 총 <b><%=memberlist.size()%>명</b> 입니다.</font><br><br>
<table id="memberlist" class="table table-hover">
	<tr class="table-info">
		<th scope="row">번호</th>
		<th scope="row">아이디</th>
		<th scope="row">이름</th>
		<th scope="row">생년월일</th>
		<th scope="row">전화번호</th>
		<th scope="row">E-mail</th>
		<th scope="row">주소</th>
		
	</tr>
	<%
		for(MemberBean mb : memberlist){
			%>
			<tr>
				<td><%=mb.getNo()%></td>
				<td><%=mb.getId()%></td>
				<td><%=mb.getName()%></td>
				<td><%=mb.getBirth()%></td>
				<td>
				<%=mb.getHp1()%>-<%=mb.getHp2()%>-<%=mb.getHp3()%>
				</td>
				<td><%=mb.getEmail()%></td>
				<td><%=mb.getAddress()%></td>
			</tr>
			<%
		}
	%>
</table>

<%@ include file="admin_bottom.jsp" %>