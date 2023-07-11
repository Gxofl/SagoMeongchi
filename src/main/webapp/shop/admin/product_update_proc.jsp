<%@page import="java.io.File"%>
<%@page import="shop.ProductDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
product_update_proc.jsp
<%
	int maxsize = 1024*1024*10;
	String configFolder = config.getServletContext().getRealPath("/shop/productimg");
	
	MultipartRequest mr = new MultipartRequest(request, configFolder, maxsize, "UTF-8");
	
	String orgpimage = mr.getParameter("orgpimage"); //원래이미지
	String newimage = mr.getFilesystemName("pimage"); // 바뀐이미지
	
	String img = null;
	if(orgpimage==null){ //원래 이미지가 없었다면
		if(newimage != null){ //새로운 이미지가 있다면
			img = newimage;
		}
	}else if(orgpimage!=null){
		if(newimage == null){ // 기존이미지 o, 새이미지 x
			img = orgpimage;
		}else{ //기존이미지 o, 새로운이미지 o
			img = newimage;
			
			File delFile = new File(configFolder, orgpimage);
			delFile.delete();
		}
	}
	
	ProductDAO pdao = ProductDAO.getInstance();
	int cnt = pdao.updateProduct(mr, img);
	if(cnt>0){
		%>
		<script type="text/javascript">
			alert("상품수정 성공");
			location.href="product_list.jsp";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("상품수정 실패");
			location.href="product_list.jsp";
		</script>
		<%
	}
	
	
%>