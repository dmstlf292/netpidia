
<%@page import="netpidia.SUtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		//insert, update, delete
		String flag = request.getParameter("flag");
		boolean result = false;
		String msg = "Error";
		if(flag.equals("insert")){
			result = fmgr.insertMyprofile(request);
			if(result) msg = "Completed";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "myprofile.jsp";
</script>