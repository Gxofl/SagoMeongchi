<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	String pno = request.getParameter("pno");
	
	ProductDAO pdao = ProductDAO.getInstance();
	ProductBean pb = pdao.getProductByPno(pno);
	
	application.setAttribute("flag", true);
	
	int stock = pb.getStock();
	
%>
<style>
	#prod_view{
		margin : auto;
		text-align : center;
		width : 70%;
		
	}
</style>
<script type="text/javascript">
	function goCart(pno, stock){
		pqty = document.prod_view.pqty.value;
		//alert(pqty);
		
		if(pqty<1){
			alert("최소 1개이상 주문해야 합니다");
			return;
		}else if(pqty>stock){
			alert("주문수량이 재고수량보다 많습니다");
			return;
		}else{
			location.href="cartAdd.jsp?pno="+pno+"&pqty="+pqty;
		}
		
		
	}//goCart
	
	function goOrder(pno, stock){ //즉시 주문하기
		pqty = document.prod_view.pqty.value;
		//alert(pqty);
		
		document.prod_view.action="orderconfirm.jsp?pno="+pno; //form의 action 설정함 pnum과 oqty가 넘어감
		if(pqty<1){
			alert("최소 1개이상 주문해야 합니다");
			return;
		}else if(pqty>stock){
			alert("주문수량이 재고수량보다 많습니다");
			return;
		}else{
			document.prod_view.submit(); // submit누른것처럼 행동해라 (action으로 넘어갈 수 있음)
		}
	}

</script>
<br>
<br>
<br>
<form name="prod_view" method="post">
<table id="prod_view" class="table table-hover">
	<tr>
		<td rowspan="7"><img src="<%=request.getContextPath()%>/shop/productimg/<%=pb.getPimage()%>" height="300" width="300"></td>
		<th class="table-warning" scope="row">제품명</th>
		<td><%=pb.getPname()%>
		</td>
	</tr>
	<tr>
		<th scope="row" class="table-warning">판매가</th>
		<td><%=df.format(pb.getPrice())%>원</td>
	</tr>
	<tr>
		<th scope="row" class="table-warning">제조사</th>
		<td><%=pb.getPcompany()%></td>
	</tr>
	<tr>
		<th scope="row" class="table-warning">포인트 적립</th>
		<td><%=df.format(pb.getPoint())%>point 적립예정</td>
	</tr>
	<tr>
		<th scope="row" class="table-warning">현재재고</th>
		<td><%=pb.getStock()%></td>
	</tr>
	<tr>
		<th scope="row" class="table-warning">주문수량</th>
		<td><input type="number" name="pqty" value="1" size="4"></td>
	</tr>
	<tr>
		<td width="25%">
			<button type="button" class="btn btn-dark" onclick="javascript:goOrder(<%=pno%>,<%=stock%>)">바로구매</button>
		</td>
		<td width="25%">
			<button type="button" class="btn btn-dark" onclick="javascript:goCart(<%=pno%>,<%=stock%>)">장바구니</button>
		</td>
	<tr>
	<tr>
		<td colspan="3" height="50"></td>
	</tr>
	<tr>
		<th scope="row" colspan="3" class="table-warning">상세설명</th>
	</tr>
	<tr>
		<td colspan="3" height="150">
			<%=pb.getPcontents() %>
		</td>
	</tr>

</table>
</form>
<br>
<br>
<br>
<%@ include file="../../main_bottom.jsp"%>