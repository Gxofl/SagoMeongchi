<%@page import="shop.mall.board.BoardDAO"%>
<%@page import="shop.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.member.MemberDAO"%>
<%@page import="shop.mall.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp"%>
<style>
	#adminmain{
		text-align:center;
	}
	
	#todayresearch{
		margin:auto;
		width:60%;
		background-image:url('<%=request.getContextPath()%>/assets/images/babypink.jpeg');
		border-radius: 10px;
	}
</style>
<%
	request.setCharacterEncoding("utf-8");
	OrderDAO odao = OrderDAO.getInstance();
	int ordercount = odao.todayOrderCount(); 

	MemberDAO mdao = MemberDAO.getInstance();
	ArrayList<MemberBean> memberlist = mdao.getAllMembers();
	
	BoardDAO bdao = BoardDAO.getInstance();
	int articlecount = bdao.todayArticleCount();
%>
<div id="adminmain">
	<br>
	<img src="<%=request.getContextPath()%>/assets/images/logo/sagomeongchi.png" height="100"><br>
	관리자님 안녕하세요.
	<br><br>
	<table id="todayresearch">
		<tr>
			<td rowspan="3" width="400">
				<img src="<%=request.getContextPath()%>/assets/images/admin/admin_main.jpg" height="500" width="350">
			</td>
			<td width="200"><h6>오늘의 주문건수</h6></td>
			<td><a href="orders_list.jsp"><h5><font color="red"><%=ordercount%></font>건</h5></a></td>
		</tr>
		<tr>
			<td><h6>오늘 작성된 Q&A 게시글</h6></td>
			<td><a href="../board/board.jsp"><h5><font color="red"><%=articlecount %></font>개</h5></a></td>
		</tr>
		<tr>
			<td><h6>사고멍치 총 회원수</h6></td> 
			<td><a href="members_list.jsp"><h5><font color="red"><%=memberlist.size()%></font>명</h5></a></td>
		</tr>

	</table>
</div>
<%@ include file="admin_bottom.jsp"%>