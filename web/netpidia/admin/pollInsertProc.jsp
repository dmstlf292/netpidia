<!-- 관리자용 -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="netpidia.PollMgr"/>
<jsp:useBean id="plBean" class="netpidia.PollListBean"/>
<jsp:setProperty property="*" name="plBean"/>
<jsp:useBean id="piBean" class="netpidia.PollItemBean"/>
<jsp:setProperty property="*" name="piBean"/>
<%
		boolean result = mgr.insertPoll(plBean, piBean);
		String msg = "Fail";
		String url = "pollInsert.jsp";
		if(result){
			msg = "Survey Insert OK";
			url = "pollListCurrent.jsp";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>



