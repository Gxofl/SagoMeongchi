<%@page import="shop.mall.OrderBean"%>
<%@page import="shop.mall.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<script type="text/javascript">
	function orderdelete(){
		var orddel = confirm("주문을 취소하시겠습니까?");
		
		if(orddel==false){
			return false;
		}
	}
</script>
<style>

	#mypagetab{
		margin:auto;
		width:70%;
		text-align:center;
	}
	
</style>
<%
	request.setCharacterEncoding("utf-8");
	OrderDAO odao = OrderDAO.getInstance();
	String id = (String)session.getAttribute("sid");
	int totalprice = 0;
	
	if(id==null){
		%>
		<script>
			alert("로그인을 먼저 하세요");
			location.href="<%=request.getContextPath()%>/login.jsp";
		</script>
		<%
	}else{
		ArrayList<OrderBean> orderlist = odao.getAllOrderbyId(id);
		%>
			<!-- <br>
			<h3 align="center">마이페이지</h3>
			<br> -->
			<form action="mypage_proc.jsp" method="post">
			<table id="mypagetab" class="table table-hover">
				<tr>
					<td colspan="5" height="50"><h4><%=id%>님의 주문 내역</h4></td>
				</tr>
				<tr class="table-success">
					<th>번호</th>
					<th>주문일</th>
					<th>상품명</th>
					<th>수량</th>
					<th>가격</th>
				</tr>
			
		<%
		if(orderlist.size()==0){
			%>
				<tr>
					<td colspan="5">주문 내역이 없습니다.</td>
				</tr>
				</table>
				</form>
			<%
		}else{
		for(int i=0; i<=orderlist.size(); i++){
			if(i==orderlist.size()){
				String orderdate = orderlist.get(i-1).getOrderdate();
				int orderid = orderlist.get(i-1).getOrderId();
				%>
				<tr>
					<td colspan="5"  class="table-success">
						총 주문금액 : <%=df.format(totalprice) %>원
					</td>
				
				</tr>
				<tr>
					<td colspan="5" align="right"  class="table-success">
						<input type="submit" value="주문취소" onclick="return orderdelete()">
						<input type="hidden" name="id" value="<%=id%>">
						<input type="hidden" name="orderdate" value="<%=orderdate%>">
						<input type="hidden" name="orderid" value="<%=orderid%>">
					</td>
				</tr>
				<%
				break;
			}
			totalprice += orderlist.get(i).getQty()*orderlist.get(i).getPrice();
		%>
			<tr>
				<td><%=orderlist.get(i).getOrderId() %></td>
				<td><%=orderlist.get(i).getOrderdate() %></td>
				<td>
					<img src="<%=request.getContextPath()%>/shop/productimg/<%=orderlist.get(i).getPimage()%>" width="50" height="50"><br>
					<%=orderlist.get(i).getPname() %>
				</td>
				<td><%=orderlist.get(i).getQty() %></td>
				<td>
					<%=df.format(orderlist.get(i).getQty()*orderlist.get(i).getPrice()) %>원
				</td>
			</tr>
		<%
		}//for
		%>
		</table>
		</form>
		<br>
		<br>
		<%
		
		}//else
	}//else
	
%>
<%@ include file="../../main_bottom.jsp"%>