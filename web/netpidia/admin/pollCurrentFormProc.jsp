<!-- 관리자용 -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="netpidia.PollMgr"/>
<%
	int listNum = Integer.parseInt(request.getParameter("num"));
	String itemNum[] = request.getParameterValues("itemnum");
	boolean result=mgr.updatePoll(listNum, itemNum);
	String msg="Select articles";
	if(result) msg="Complete!";
%>
<script>
	alert("<%=msg%>");
	location.href="pollListCurrent.jsp?tnum=<%=listNum%>";
</script>