<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="netpidia.EvaluationDTO"%>
<%@ page import="netpidia.EvaluationDAO"%>

<%@ page import="java.io.PrintWriter"%>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<%

			request.setCharacterEncoding("UTF-8");
			String id = (String)session.getAttribute("idKey");
			if(id==null){
				//현재 접속된 url값
				StringBuffer url = request.getRequestURL();
				response.sendRedirect("login.jsp?url="+url);
				return;//이후에 jsp 코드 실행 안됨.
			}
			int productNo=0;
			String title = null;
			String content = null;
			String totalScore = null;
			String totalRate = null;
			String month = null;
		
			if(request.getParameter("title") != null) {
				title = (String) request.getParameter("title");
			}
			if(request.getParameter("content") != null) {
				content = (String) request.getParameter("content");
			}
			if(request.getParameter("totalScore") != null) {
				totalScore = (String) request.getParameter("totalScore");
			}if(request.getParameter("totalRate") != null) {
				totalRate = (String) request.getParameter("totalRate");
			}if(request.getParameter("month") != null) {
				month = (String) request.getParameter("month");
			}
			if (title == null || content == null || totalScore==null|| totalRate==null|| month==null|| title.equals("") || content.equals("")) {
				out.println("<script>");
				out.println("alert('Any content is null');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return;
			} else {
				EvaluationDAO evaluationDAO = new EvaluationDAO();
				int result = evaluationDAO.write(new EvaluationDTO(0, id, title, content, totalScore, totalRate, month,  0));
				if (result == -1) {
					out.println("<script>");
					out.println("alert('Fail');");
					out.println("history.back();");
					out.println("</script>");
					out.close();
					return;
				} else {
					out.println("<script>");
					out.println("location.href = 'productDetail.jsp?productNo="+productNo+"'");
					out.println("</script>");
					out.close();
					return;
				}
			}
%>