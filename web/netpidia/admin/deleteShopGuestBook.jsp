
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="smgr" class="netpidia.ShopGuestBookMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int num = 0;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
			//���� ���� ���
			smgr.deleteShopGuestBook(num);
			//���� ���� ������ ���õ� ��� ��� ����
			smgr.deleteAllShopComment(num);
		}
		response.sendRedirect("productDetail.jsp");
%>
