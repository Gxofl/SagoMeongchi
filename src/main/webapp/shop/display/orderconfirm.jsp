<%@page import="shop.member.MemberBean"%>
<%@page import="shop.member.MemberDAO"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp" %>
<style>
	h1{
		text-align:center;
	}
	h3{
		text-align:center;
	}
	table{
		margin:auto;
		text-align:center;
	}
	#member_info{
		width:80%;
	}
	#order_info{
		width:80%;
	}

</style>
orderconfirm.jsp
<%
	//상세보기 flag=true;
	boolean flag = (Boolean)application.getAttribute("flag");
	
	//즉시 구매하기로 넘어온 상품번호와 주문수량
	String pno = request.getParameter("pno");
	String pqty = request.getParameter("pqty");
	
	System.out.println("pno : "+pno);
	System.out.println("pqty : "+pqty);
	
	//mall_cartlist.jsp 에서 주문하기 버튼 클릭시 의미없는 00이 넘어옴
	
	if(!pno.equals("00") && !pqty.equals("00")){ // 상품상세보기, 즉시구매하기
		if(flag==true){ //새로고침시 갯수 증가하는거 방지
			mallCart.addProduct(pno, pqty); // 즉시구매하기로 클릭한 상품 장바구니에 담음
		}
	}

	Vector<ProductBean> cartlist = mallCart.getAllproduct();
	MemberDAO mdao = MemberDAO.getInstance();
	MemberBean mb = mdao.getMemberInfo2(sid);
	
	int finalTotalPrice = 0;
	int finalTotalPoint = 0;

	if(sid==null){
		%>
		<script>
			alert("비회원은 주문할 수 없습니다");
			location.href="<%=request.getContextPath()%>/login.jsp";
		</script>
		<%
	}else if(sid.equals("admin")){
		%>
		<script>
			alert("관리자는 주문할 수 없습니다");
			location.href="<%=request.getContextPath()%>/main.jsp";
		</script>
		<%
	}else{
		%>
		<h1>결제내역서</h1>
		<br><br>
		<h3>주문자 정보</h3><br><br>
		<table border="1" class="table table-hover" id="member_info">
			<tr height="30px">
				<td class="table-dark">성명</td>
				<td><%=mb.getName() %></td>
			</tr>
			<tr height="30px"> 
				<td class="table-dark">전화번호</td>
				<td>
					<input type="text" value="<%=mb.getHp1()%>" size="3">-
					<input type="text" value="<%=mb.getHp2()%>" size="4">-
					<input type="text" value="<%=mb.getHp3()%>" size="4">
				</td>
			</tr>
			<tr height="30px">
				<td class="table-dark">배송주소</td>
				<td>
					<input type="text" value="<%=mb.getAddress()%>"> 
				</td>
				
				
			</tr>
		</table>
		<br>
		
		<br>
			<h3>주문 정보</h3><br><br>
		<table border="1" class="table table-hover" id="order_info">
			<tr class="table-dark">
				<td>상품명</td>
				<td>상품</td>
				<td>수량</td>
				<td>가격</td>
			</tr>
			<%
				for(ProductBean pb : cartlist){
					finalTotalPrice += pb.getStock()*pb.getPrice();
					finalTotalPoint += pb.getStock()*pb.getPoint();
					%>
					<tr>
						<td><%=pb.getPname()%></td>
						<td><img src="<%=request.getContextPath()%>/shop/productimg/<%=pb.getPimage()%>" height="80"></td>
						<td><%=pb.getStock()%>개</td>
						<td><%=df.format(pb.getPrice())%>원</td>
					</tr>
					<%
				}
			%>
			<tr>
				<td colspan="3" align="right">총 주문금액</td>
				<td>
				<h4><%=df.format(finalTotalPrice) %>원</h4>
				<font color="red"><%=df.format(finalTotalPoint)%>point</font>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="button" value="결제하기" class="btn btn-dark" onclick="location.href='<%=path%>/shop/display/orderCaculate.jsp'">
					<input type="button" value="취소"  class="btn btn-danger" onclick="history.go(-1)">
				</td>
			</tr>
		</table>
		<%
	}
%>
<%@ include file="../../main_bottom.jsp" %>