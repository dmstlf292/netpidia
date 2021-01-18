<%@page contentType="text/html;charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="gmgr" class="netpidia.GuestBookMgr"/>
<jsp:useBean id="login"  class="netpidia.MemberBean"/> 
<jsp:setProperty property="*" name="login"/>
<%
		String url = "index.jsp";
		if(request.getParameter("url")!=null&&
				!request.getParameter("url").equals("null")){
			url = request.getParameter("url");
		}
		boolean result = gmgr.loginMember(login.getId(), login.getPwd());
		String msg = "Fail";
		if(result){
			msg = "Login OK";
			login = gmgr.getMember(login.getId());
			session.setAttribute("idKey", login.getId());
			session.setAttribute("login", login);
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>

