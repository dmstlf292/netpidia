<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="smgr" class="netpidia.ShopGuestBookMgr"/>
<jsp:useBean id="bean" class="netpidia.ShopGuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	if(bean.getSecret()==null){
		bean.setSecret("0");
	}
	smgr.insertShopGuestBook(bean);
	response.sendRedirect("productDetail.jsp?productNo="+request.getParameter("productNo"));
%>