<%@page import="java.io.PrintWriter"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="evaluation.Gmail"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		String reportTitle =null;
		String reportContent = null;
		if(request.getParameter("reportTitle")!=null){
			reportTitle = (String)request.getParameter("reportTitle");
		}
		if(request.getParameter("reportContent")!=null){
			reportContent = (String) request.getParameter("reportContent");
		}
		if(reportTitle==null || reportContent==null){
			out.println("<script>");
			out.println("alert('입력이 안 된 사항이 있습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return;
		}

		//사용자에게 보낼 메시지 기입하기
		String host ="http://localhost/myapp/netpidia/admin/";
		String from = "qkrdmstlf292@naver.com";
		String to = "silviapark292@gmail.com";
		String subject = "Arrived one message";
		String content = "Custom : " + id + "<br>Title : " + reportTitle + "<br>Content: " + reportContent;
		
		//SMTP에 접속하기 위한 정보를 기입하기
		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtp.googlemail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		try{
			Authenticator auth = new Gmail();
			Session ses = Session.getInstance(p, auth);
			ses.setDebug(true);
			MimeMessage msg = new MimeMessage(ses);
			msg.setSubject(subject);
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(to);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(content, "text/html;charset=UTF-8");
			Transport.send(msg);
		}catch (Exception e){
			e.printStackTrace();
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Error');");
			script.println("history.back();");
			script.println("</script>");
			script.close();	
			return;
		}
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('We are going to attend/respond you as soon as possible :)');");
		script.println("history.back();");
		script.println("</script>");
		script.close();		
		return;
%>