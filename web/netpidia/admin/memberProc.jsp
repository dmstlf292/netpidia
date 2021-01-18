<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="mbean" class="netpidia.MemberBean"/>
<jsp:setProperty property="*" name="mbean" />
<%
		boolean result = mMgr.insertMember(mbean);
		String msg = "Fail";
		String url = "member.jsp";
		if(result){
			msg = "Welcome";
			url = "index.jsp";
			//가입성공과 동시에 로그인 처리를 위한 기능
			session.setAttribute("idKey", mbean.getId());
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>











