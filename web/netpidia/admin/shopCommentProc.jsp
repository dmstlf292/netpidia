<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%><!-- ���� ���� �ø��� -->
<jsp:useBean id="smgr" class="netpidia.ShopGuestBookMgr"/>
<jsp:useBean id="cbean" class="netpidia.ShopCommentBean"/>
<jsp:setProperty property="*" name="cbean"/>
<%
//���� �Է� & ����
	String flag=request.getParameter("flag");
	if(flag.equals("insert")){
		smgr.insertShopComment(cbean);
	}else if (flag.equals("delete")){
		smgr.deleteShopComment(cbean.getProductNo());
	}
	response.sendRedirect("productDetail.jsp?flag=delete&productNo="+request.getParameter("productNo"));
%>