<!-- deleteGuestBook.jsp -->
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="gmgr" class="netpidia.GuestBookMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int num = 0;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
			//대댓글 삭제 기능
			gmgr.deleteGuestBook(num);
			//방명록 원글 삭제시 관련된 댓글 모두 삭제
			gmgr.deleteAllComment(num);
		}
		response.sendRedirect("surveyList.jsp");
%>
