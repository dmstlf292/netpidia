<!-- updateGuestBookProc.jsp -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="gmgr" class="netpidia.GuestBookMgr"/>
<jsp:useBean id="gbean" class="netpidia.GuestBookBean"/>
<jsp:setProperty property="*" name="gbean"/>
<%
		if(gbean.getSecret()==null)
			gbean.setSecret("0");//��б��� üũ���� ������ �Ӽ�=�� ��ü�� �Ѿ���� �ʴ´�.
			gmgr.updateGuestBook(gbean);	
%>
<!-- ������ ���� â�� close�ǰ� ������ ���ϱ��� ������ �Ƿ��� 
showGuestBook.jsp ���ΰ�ħ -->
<script>
	opener.location.reload();
	self.close();
</script>
