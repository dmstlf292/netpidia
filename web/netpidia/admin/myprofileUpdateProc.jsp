<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.SUtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<%

		boolean result =fmgr.updateMyprofile(request);
		if(result){
%>
		<script>
			alert("Completed");
			location.href = "index.jsp";
		</script>
<%}else{%>	
		<script>
			alert("Fail");
			history.back();
		</script>
<%}%>	