<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../main_top.jsp"%>
<style>
	#companypro{
		text-align : center;
	}
	
	table{
		margin:auto;
		font-size: 15px;
	}
</style>
	<div id="companypro">
	<br><br>
	<h3>오프라인 매장</h3>
	<br><br>
    <img src="<%=request.getContextPath()%>/assets/images/company/company.jpeg">
    <br><br>
    <hr>
    <br>
    	<h5>사고멍치 1호점</h5>
    	<br>
    <table>
    	<tr height="30" border="1">
    	<td>위치 : </td>
    	<td>서울특별시 강남구 논현로80길 1111 (탤빌딩) 1층</td>
    	</tr>
    	<tr height="30">
    	<td>영업시간 : </td>
    	<td>연중무휴, 09:00 - 22:00</td>
    	</tr>
    	<tr height="30">
    	<td>전화번호 : </td>
    	<td>02)1133-1234</td>
    	</tr>
    </table>
    <br><br>
    </div>
<%@ include file="../../main_bottom.jsp"%>