<%@page import="java.io.File"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
product_delete.jsp<br>
<%
	request.setCharacterEncoding("utf-8");
	String pno = request.getParameter("pno");
	String pimage = request.getParameter("pimage");
	
	String deletePath = config.getServletContext().getRealPath("/shop/productimg/");
	
	File delFile = null;
	
	File dir = new File(deletePath);
	if(pimage!=null){ //이미지가 존재하면
		delFile = new File(dir,pimage);
		
		if(delFile.exists()){//해당파일에 이미지가 존재하면 true
			if(delFile.delete()){ // 지우면 true 실패하면 false
				%>
					<script type="text/javascript">
					alert("이미지 파일 삭제 성공");
					</script>
				<%
			}
		}
	}
	
	ProductDAO pdao = ProductDAO.getInstance();
	int cnt = pdao.deleteProduct(pno);
	String msg="";
	if(cnt>0){
		msg = "상품 삭제성공";
	}else{
		msg = "상품 삭제 실패";
	}
%>
	<script type="text/javascript">
		alert("<%=msg%>");
		location.href="product_list.jsp"
	</script>