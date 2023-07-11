<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<%@ include file="../../main_top.jsp" %> 
<style>
	#registerforms{
		width:70%;
		margin:auto;
	}
	
	#registers{
		text-align:center;
	} 
</style>
<div>
<br>
<h3 id="registers">회원가입</h3>
<br>
</div>
<form  action="registerProc.jsp" method="post">
	<table id="registerforms" class="table table-hover">
		<tr>
			<td class="table-info">아이디</td>
			<td colspan="3"><input type="text" name="id" onKeydown="resetidCheck()">
				<input type="button" value="중복체크" onclick="idCheck()"  class="btn btn-primary">
				 <span id="idcheck"></span>
			</td>
		</tr>
		<tr>
			<td class="table-info">비밀번호</td>
			<td><input type="text" name="password" onblur="pwformatcheck()">
				<span id="pwformatcheck"></span></td>
			<td class="table-info">비밀번호 확인</td>
			<td><input type="text" name="passwordchk" onKeyup="pwcheck()">
				<span id="pwcheck"></span></td>
		</tr>
		<tr>
			<td width="20%" class="table-info">이름</td>
			<td width="30%"><input type="text" name="name"></td>
			<td width="20%" class="table-info">생년월일</td>
			<td><input type="text" name="birth"></td>
		</tr>
		<tr>
			<td class="table-info">이메일</td>
			<td><input type="text" name="email" ></td>
			<td class="table-info">전화번호</td>
			<td width="30%">
				<select name="hp1" >
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="019">019</option>
						</select>
						-
						<input type="text" name="hp2" size="5"  >
						-
						<input type="text" name="hp3" size="5"  >
			</td>
		</tr>
		<tr>
			<td class="table-info">주소</td>
			<td colspan="2"><input type="text" name="address" size="70"></td>
		</tr>
		<tr>
			<td colspan="4" align="right">
				<button type="submit" onClick="return writeSave()" class="btn btn-primary btn-lg">가입하기</button>
			</td>
		</tr>
	</table>
</form>
<br>
<br>

<%@ include file="../../main_bottom.jsp" %>