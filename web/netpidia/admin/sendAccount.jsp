<!-- admin/sendAccount.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		mMgr.sendAccount(id);
%>
<script>
	alert("������ �߼� �Ͽ����ϴ�.");
	location.href = "memberMgr.jsp";
</script>