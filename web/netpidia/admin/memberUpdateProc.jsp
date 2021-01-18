<!-- memberUpdateProc.jsp -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<%
		boolean result = fmgr.updateMyprofile(request);
		if(result){
%>
		<script>
			alert("Completed");
			location.href = "login.jsp";
		</script>
<%}else{%>
		<script>
			alert("Fail");
			history.back();
		</script>
<%}%>






