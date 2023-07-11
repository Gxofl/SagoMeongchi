<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 세션 모두 해제
%>
<script type="text/javascript">
	location.href="<%=request.getContextPath()%>/main.jsp"; //로그인 화면
</script>