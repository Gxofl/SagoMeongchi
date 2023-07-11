<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.mall.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.mall.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp"%>
<style>
#orderlist {
	width: 80%;
	margin: auto;
	border: 1px;
	text-align: center;
}

h2{
	text-align: center;
	margin-top: 40px;
	margin-bottom: 20px;
}

#searchId{
	margin: auto;
	text-align: center;
	width: 40%;
}
</style>
<%
	request.setCharacterEncoding("utf-8");

	OrderDAO odao = OrderDAO.getInstance();
	
	DecimalFormat df = new DecimalFormat("###,###");
	
	String id = request.getParameter("id");
	
	int totalPrice = 0;
%>
	<h2>주문 내역</h2><br><br>
			<table id="searchId">
				<tr>
					<td>
						<form action="orders_list.jsp" method="post">
							<!-- 검색할 아이디 : <input type="text" name="id"> <input type="submit" value="검색" class="btn btn-info"> -->
							<div class="input-group mb-3">
							 <input type="text" name="id" class="form-control" placeholder="검색할 아이디 입력" aria-label="Recipient's username" aria-describedby="button-addon2">
     						 <button class="btn btn-primary" type="submit" id="button-addon2">Search</button>
    						</div>
						</form>
					</td>
				</tr>
			</table>
			<br><br>
				<table id="orderlist" class="table table-hover">
					<tr class="table-info">
						<th scope="row">번호</th>
						<th scope="row">아이디</th>
						<th scope="row">주문상품명</th>
						<th scope="row">주문상품</th>
						<th scope="row">수량</th>
						<th scope="row">가격</th>
					</tr>
<%
	if(id==null){
		ArrayList<OrderBean> orderlist = odao.getAllOrders();
		%>
			<%
				if(orderlist.size()==0){
				%>
				<tr>
					<td colspan="6">주문내역이 없습니다.</td>
				</tr>
			<%
				}else{
					for(OrderBean ob : orderlist){
			%>
				<tr>
					<td><%=ob.getOrderId()%></td>
					<td><%=ob.getId()%></td>
					<td><%=ob.getPname()%></td>
					<td><img
						src="<%=request.getContextPath()%>/shop/productimg/<%=ob.getPimage()%>"
						width="50" height="50"></td>
					<td><%=ob.getQty()%></td>
					<td><%=ob.getQty()%>*<%=ob.getPrice()%> = <%=df.format(ob.getAmount())%>
										원</td>
				</tr>
				<%
					}//for
				}//else	
				%>
			</table>
			<%
			}//if
			else{//id검색
				ArrayList<OrderBean> orderlist = odao.getAllOrderbyId(id); 
				%>
				<%
					if(orderlist.size()==0){
					%>
					<tr>
						<td colspan="6">주문내역이 없습니다.</td>
					</tr>
				<%
					}else{
						for(OrderBean ob : orderlist){
							totalPrice += ob.getAmount();
				%>
					<tr>
						<td><%=ob.getOrderId()%></td>
						<td><%=ob.getId()%></td>
						<td><%=ob.getPname()%></td>
						<td><img
							src="<%=request.getContextPath()%>/shop/productimg/<%=ob.getPimage()%>"
							width="50" height="50"></td>
						<td><%=ob.getQty()%></td>
						<td><%=ob.getQty()%>*<%=ob.getPrice()%> = <%=df.format(ob.getAmount())%>원
											</td>
					</tr>
					<%
						}//for
						%>
						<tr>
							<td colspan="6" align="right">
								<b><%=id%>님</b>의 총 주문금액은 <br>
								<h3><font color="red"><%=df.format(totalPrice) %>원</font></h3>
							</td>
						</tr>
						<%
					}//else	
					%>
				</table>
				<%
			}
%>


<%@ include file="admin_bottom.jsp"%>