<!-- updateGuestBook.jsp -->
<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.ShopGuestBookBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="smgr" class="netpidia.ShopGuestBookMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/> 
<jsp:useBean id="pbean1" class="netpidia.ProductBean"/>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey"); 
		MyprofileBean fbean = fmgr.getMyprofile(id); 
		int num = 0;
		ShopGuestBookBean bean = null;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
			bean = smgr.getShopGuestBook(num);
		}
		
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shop Review Update</title>
<link rel="shortcut icon" href="img/minilogo.png"> 
<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
<link href="assets/css/style.css" rel="stylesheet">
<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
</head>
<body>
	<div align="center">
		<table width="500" cellspacing="0" cellpadding="3">
			<tr>
				<td bgcolor="#F5F5F5"><font size="4"><b>Modify</b></font></td>
			</tr>
		</table>
		<form method="post" action="updateShopGuestBookProc.jsp?num=<%=num%>">
			<div class="tr-single-body" >
				<div class="review-box">
					<div class="review-thumb">
						<img src="data/<%=fbean.getImage() %> " class="img-responsive img-circle" alt="" />
						<%-- <input name="name" value="<%=login.getName()%>" readonly> --%>
					</div>
					<div class="review-box-content">						
						<div class="review-user-info">
							<textarea name="contents" cols="50" rows="3"><%=bean.getContents()%></textarea>
						</div>
						<input type="submit" value="modify"> 
						<input type="reset" value="reset"> 
						<input type="checkbox" name="secret" value="1" 
						<%if(bean.getSecret().equals("1")) out.print("checked");%>>Secret
						<input type="hidden" name="id" value="<%=bean.getId()%>">
						<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
					</div>
				</div>	
			</div>
		</form> 
	</div>
</body>
</html>
