<!-- commentProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%><!-- 제일 위로 올리기 -->
<jsp:useBean id="mgr" class="netpidia.GuestBookMgr"/>
<jsp:useBean id="cbean" class="netpidia.CommentBean"/>
<jsp:setProperty property="*" name="cbean"/>
<%
//대댓글 삭제 및 입력
	String flag=request.getParameter("flag");
	if(flag.equals("insert")){
		mgr.insertComment(cbean);
	}else if (flag.equals("delete")){
		mgr.deleteComment(cbean.getCnum());
	}
	response.sendRedirect("surveyList.jsp");
%>