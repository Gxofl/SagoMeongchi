<%@page import="java.text.SimpleDateFormat"%>
<%@page import="shop.mall.board.BoardBean"%>
<%@page import="shop.mall.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp"%>
<style>
	#context{
		height:1200px;
	}
	#board{
		width:80%;
		margin:auto;
		text-align : center;
	}
	
	#boardcount h3{
		text-align:center;
		margin-top:10px;
		margin-bottom:20px;
	}
	
	#boardcount{
		text-align:center;
	}
	#page{
		text-align:center;
	}
</style>
<%
	request.setCharacterEncoding("UTF-8");

	int pageSize = 5;
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1 ;
	int endRow = startRow + pageSize - 1;
	
	BoardDAO bdao = BoardDAO.getInstance();
	ArrayList<BoardBean> lists = null;
	int count = bdao.getArticleCount(); 
	if(count>0){
		lists = bdao.getAllBoard(startRow,endRow);
	}
	
	int number = count-(currentPage-1) * pageSize; 
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
%>
<div id="boardcount">
<br>
<h1>Q&A</h1>
<font>총 게시글은 <b><%=count%></b>개 입니다.</font>
</div>
<table class="table table-hover" id="board">
	<tr align="right">
		<td colspan="5">
			<input type="button" value="글쓰기" class="btn btn-outline-success" id="write"
				onclick="location.href='writeForm.jsp'">
		</td>
	</tr>
	<tr class="table-success" height="30" align="center">
		<th width="10%">번 호</th>
		<th width="40%">제 목</th>
		<th width="20%">작성자</th>
		<th width="20%">작성일</th>
		<th width="10%">조회수</th>
	</tr>
	<%
		if(count==0){
			%>
				<tr>
					<td colspan="5"> <b>작성된 게시글이 없습니다.</b> </td>
				</tr>
			<%
		}else{
			for(BoardBean bb : lists){
				%>
					<tr>
						<td><%=number--%></td>
						<td align="left">
							<%
								if(bb.getReadcount()>10){
									%>
									<img src="./img/hot.png" width="20" height="20">
									<%
								}
							%>
							<%if(bb.getRe_level()>0){
									int wid=20;
								%>
									<img src="./img/level.gif" width="<%=wid*bb.getRe_level()%>" height="20">
									<img src="./img/reply_down.png" height="20">
								<% 
							}
							%>
							<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getTitle()%></a>
							
						</td>
						<td><%=bb.getWriter() %></td>
						<td><%=sdf.format(bb.getReg_date())%></td>
						<td><%=bb.getReadcount()%></td>
					</tr>
				<%
			}//for
		}//else
	%>
	</table>
	<div id="page">
	<br>
	<%
		//페이지설정
		if(count>0){
			//필요한 전체 페이지수
			int pageCount = count/pageSize + (count%pageSize==0?0:1);
			
			//한번에 보일 페이지 수 
			int pageBlock = 3;
			
			int startPage = ((currentPage-1) / pageBlock * pageBlock)+1;
			int endPage =  startPage + pageBlock - 1;
			
			if(pageCount < endPage){
				endPage = pageCount;
			}
			
			if(startPage>3){
				%>
     			<a href="board.jsp?pageNum=<%=startPage-3%>">[&laquo;]</a>
				<%
			}//if
			for(int i=startPage; i<=endPage; i++){
				%>
     			<font color="black"><a href="board.jsp?pageNum=<%=i%>">[<%=i %>]</a></font>
				<%
			}//for
			if(endPage<pageCount){
				%>
				<a href="board.jsp?pageNum=<%=startPage+3%>">[&raquo;]</a>
				<%
			}
		}//if(count>0)
	%>
	<br><br>
	</div>



	
<%@ include file="../../main_bottom.jsp"%>
