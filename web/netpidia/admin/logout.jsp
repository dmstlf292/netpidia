<%@ page contentType="text/html;charset=EUC-KR"%>
<%
	session.invalidate();
%>
<script>
    alert("Logout");
	location.href="index.jsp";
</script>