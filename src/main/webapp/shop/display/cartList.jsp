<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp" %>
<% 
	
	Vector<ProductBean> cartlist = mallCart.getAllproduct();
	int i = 0;
	int totalPrice = 0;
	int totalPoint = 0;
%>
<style>
	h3{
		text-align:center;
		margin-top : 40px;
		margin-bottom: 40px;
		
	}
	
	#cart_list{
		margin:auto;
		text-align : center;
		width:80%;
	}

</style>
<h3>장바구니 목록</h3>
<table id="cart_list" class="table table-hover">
	<tr class="table-warning">
		<th scope="row">번호</th>
		<th>상품</th>
		<th>상품명</th>
		<th>주문수량</th>
		<th>가격</th>
		<th>삭제</th>
	</tr>
	<% 
		if(cartlist.size()==0){
	%>
		<tr>
			<td colspan="6"> 장바구니에 담은 상품이 없습니다. </td>
		</tr>
	<%
		}//if
		else{
			for(ProductBean pb : cartlist){
				i++;
				totalPrice += pb.getStock()*pb.getPrice();
				totalPoint += pb.getStock()*pb.getPoint();
				%>
				<tr>
					<td width="10%"><%=i%></td>
					<td width="30%"><img src="<%=request.getContextPath()%>/shop/productimg/<%=pb.getPimage()%>" height="50"></td>
					<td width="20%"><%=pb.getPname()%></td>
					<td width="10%">
						<form action="cartEdit.jsp" action="method">
							<input type="hidden" name="pno" value="<%=pb.getPno()%>">
							<input type="text" name="pqty" value="<%=pb.getStock()%>" size="3">개
							<input type="submit" value="수정" class="btn btn-light">
						</form>
					</td>
					<td width="20%">
						<%=df.format(pb.getStock()*pb.getPrice())%>원<br>
						[<%=df.format(pb.getStock()*pb.getPoint()) %>]point 적립예정
					</td>
					<td width="10%"><a href="cartDelete.jsp?pno=<%=pb.getPno()%>">삭제</a></td>
				</tr>
				<%
			}//for
			%>
			<tr>
				<td colspan="5" align="right">총 주문금액</td>
				<td>
				<h5><%=df.format(totalPrice) %>원</h5>
				<font color="red"><%=df.format(totalPoint)%>point</font>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<input type="button" value="구매하기" class="btn btn-dark" onclick="location.href='orderconfirm.jsp?pno=00&pnum=00'">
					<input type="button" value="계속쇼핑" class="btn btn-dark" onclick="location.href='<%=request.getContextPath()%>/main.jsp'">
				</td>
			</tr>
			<%
		}
	%>

</table>
<br><br><br>
<%@ include file="../../main_bottom.jsp" %>