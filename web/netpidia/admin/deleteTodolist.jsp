<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="netpidia.TodolistMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int num = 0;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
			//���� ���� ���
			mgr.deleteTodolist(num);
			
		}
		response.sendRedirect("todolist.jsp");
%>
