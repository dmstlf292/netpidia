<!-- commentProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%><!-- ���� ���� �ø��� -->
<jsp:useBean id="mgr" class="netpidia.GuestBookMgr"/>
<jsp:useBean id="cbean" class="netpidia.CommentBean"/>
<jsp:setProperty property="*" name="cbean"/>
<%
//���� ���� �� �Է�
	String flag=request.getParameter("flag");
	if(flag.equals("insert")){
		mgr.insertComment(cbean);
	}else if (flag.equals("delete")){
		mgr.deleteComment(cbean.getCnum());
	}
	response.sendRedirect("surveyList.jsp");
%>