<%@page import="netpidia.UtilMgr"%>
<%@ page import="netpidia.MemberMgr"%>
<%@ page import="netpidia.EvaluationDAO"%>
<%@ page import="netpidia.LikeyDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%
			request.setCharacterEncoding("EUC-KR");
			String id = (String)session.getAttribute("idKey");
			if(id==null){
				//현재 접속된 url값
				StringBuffer url = request.getRequestURL();
				response.sendRedirect("login.jsp?url="+url);
				return;//이후에 jsp 코드 실행 안됨.
			}
			int productNo = 0;
			if(request.getParameter("productNo") != null) {
				productNo = UtilMgr.parseInt(request, "productNo");
			}
			
			EvaluationDAO evaluationDAO = new EvaluationDAO();
			
			if(id.equals(evaluationDAO.getUserID(productNo))) {
				int result = new EvaluationDAO().delete(productNo);
				if (result == 1) {
					out.println("<script>");
					out.println("alert('Deletion is complete.');");
					//out.println("location.href='productDetail.jsp'");
					out.println("location.href='productDetail.jsp?productNo="+productNo+"'");
					out.println("</script>");
					out.close();
					return;
				} else {
					out.println("<script>");
					out.println("alert('A database error has occurred.');");
					out.println("history.back();");
					out.println("</script>");
					out.close();
					return;
				}
			} else {
				out.println("<script>");
				out.println("alert('You can delete only your own writing.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return;
			}
%>