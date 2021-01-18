<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="netpidia.TodolistMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int num = 0;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
			//대댓글 삭제 기능
			mgr.deleteTodolist(num);
			
		}
		response.sendRedirect("todolist.jsp");
%>
