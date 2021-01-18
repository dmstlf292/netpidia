<%@page import="netpidia.MyprofileMgr"%>
<%@page import="netpidia.ZipcodeBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String search = request.getParameter("search");
		Vector<ZipcodeBean> vlist = null;
		String area3 = null;
		//search값이 y는 검색, n은 그냥 창만 open
		if(search.equals("y")){
			//검색일때
			MyprofileMgr mgr = new MyprofileMgr();
			area3 = request.getParameter("area3");
			vlist=mgr.searchZipcode(area3);
			//vlist = mgr.searchZipcode(area3);
			//out.print(vlist.size());
		}
%>
<!doctype html>
<html>
<head>
<title>Post code Search</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loadSearch() {
		frm = document.zipFrm;
		if(frm.area3.value==""){
			alert("Enter road name");
			return;
		}
		frm.action = "zipSearch.jsp";
		frm.submit();
	}
	function sendAdd(zipcode, adds) {
		//alert(zipcode+"\n"+adds);
		//opener는 member.jsp
		opener.document.regFrm.zipcode.value=zipcode;
		opener.document.regFrm.address.value=adds;
		self.close();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br />
		<form name="zipFrm" method="post">
			<table>
				<tr>
					<td>
					<br/>Enter road name : 	<input name="area3">
						<input type="button" value="Search" onclick="loadSearch()">
					</td>
				</tr>
				<!-- 검색 결과 Start -->
				<%
						if(search.equals("y")){
							if(vlist.isEmpty()){
				%>
				<tr>
					<td align="center"><br>No Results Found.</td>
				</tr>
				<%}else{%>
				<tr>
					<td align="center"><br>※After searching, click the address below and it will be automatically entered.</td>
				</tr>	
				<%
						for(int i=0;i<vlist.size();i++){
							ZipcodeBean bean = vlist.get(i);
							String zipcode = bean.getZipcode();
							String adds = bean.getArea1()+" ";
							adds+=bean.getArea2()+" ";
							adds+=bean.getArea3()+" ";
				%>
				<tr>
					<td><a href="#" onclick="sendAdd('<%=zipcode%>','<%=adds%>')">
					<%=zipcode + " "+adds%></a></td>
				</tr>	
				<%			
							}//---for
						}//---if2
					}//--if1
				%>
				<!-- 검색 결과 End -->
				<tr>
					<td align="center"><br/>
					<a href="#" onClick="self.close()">Close</a></td>
				</tr>
			</table>
			<input type="hidden" name="search" value="y">
		</form>
	</div>
</body>
</html>










