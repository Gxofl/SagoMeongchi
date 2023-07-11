<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mallCart" class="shop.mall.CartBean" scope="session"/>
<%
	String pno = request.getParameter("pno");
	
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
	var confirm = confirm("정말 삭제하시겠습니까?");
	if(confirm){
		<%
		mallCart.deleteCart(pno);
		%>
		location.href="<%=request.getContextPath()%>/shop/display/cartList.jsp";
		}	
	}else{
		history.go(-1);
	} 
</script>
