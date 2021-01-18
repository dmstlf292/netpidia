<!-- postGuestBookProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="gmgr" class="netpidia.GuestBookMgr"/>
<jsp:useBean id="bean" class="netpidia.GuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	if(bean.getSecret()==null){//체크박스 비밀글을 체크 안한경우, 체크하면 값이 1로 넘어옴
		//비밀글을 체크 하지 않은경우
		bean.setSecret("0");//여기 아주 중요
	}
	gmgr.insertGuestBook(bean);
	response.sendRedirect("surveyList.jsp");
%>