<!-- postGuestBookProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="gmgr" class="netpidia.GuestBookMgr"/>
<jsp:useBean id="bean" class="netpidia.GuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	if(bean.getSecret()==null){//üũ�ڽ� ��б��� üũ ���Ѱ��, üũ�ϸ� ���� 1�� �Ѿ��
		//��б��� üũ ���� �������
		bean.setSecret("0");//���� ���� �߿�
	}
	gmgr.insertGuestBook(bean);
	response.sendRedirect("surveyList.jsp");
%>