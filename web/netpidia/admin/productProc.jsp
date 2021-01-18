<!-- admin/productProc.jsp -->
<%@page import="netpidia.SUtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pMgr" class="netpidia.ProductMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		//insert, update, delete
		String flag = request.getParameter("flag");
		boolean result = false;
		String msg = "Error";
		if(flag.equals("insert")){
			result = pMgr.insertProduct(request);
			if(result) msg = "Registration completed";
		}else if(flag.equals("update")){
			result = pMgr.updateProduct(request);
			if(result) msg = "Modification completed";
		}else if(flag.equals("delete")){
			result = pMgr.deleteProduct(SUtilMgr.parseInt(request, "productNo"));
			if(result) msg = "Deletion completed";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "productMgr.jsp";
</script>