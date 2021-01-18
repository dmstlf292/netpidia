<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%><!-- 제일 위로 올리기 -->
<jsp:useBean id="smgr" class="netpidia.ShopGuestBookMgr"/>
<jsp:useBean id="cbean" class="netpidia.ShopCommentBean"/>
<jsp:setProperty property="*" name="cbean"/>
<%
//대댓글 입력 & 삭제
	String flag=request.getParameter("flag");
	if(flag.equals("insert")){
		smgr.insertShopComment(cbean);
	}else if (flag.equals("delete")){
		smgr.deleteShopComment(cbean.getProductNo());
	}
	response.sendRedirect("productDetail.jsp?flag=delete&productNo="+request.getParameter("productNo"));
%>