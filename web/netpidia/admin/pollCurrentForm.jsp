<!-- 관리자용 -->
<%@page import="java.util.Vector"%>
<%@page import="netpidia.PollListBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="netpidia.PollMgr"/>

<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		int num = 0;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
		}
		PollListBean plBean = mgr.getPoll(num);
		Vector<String> vItem = mgr.getItemList(num);
		String question = plBean.getQuestion();
		int type = plBean.getType();
		int active = plBean.getActive();
		int sumCount = mgr.sumCount(num);//총투표수 - 미구현
%>
<form action="pollCurrentFormProc.jsp"> 
<table>
	<tr>
		<td colspan="2" width="300">
			Q : <%=question%> <font color="blue">(<%=sumCount%>)</font>
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<%
				for(int i=0;i<vItem.size();i++){
					String item = vItem.get(i);
		%>
		<%if(type==1){%>
		<label class="checkbox-inline">
			<input type="checkbox" name="itemnum" value="<%=i%>" id="inlineCheckbox1">
		</label>
		<%}else if(type==0){ %>
			<input type="radio" name="itemnum" value="<%=i%>">
		<%}%>
		<%=item%><br>
		<%}%>
		</td>
	</tr>
	<tr>
		<td width="150">
		<%if(active==1){%><!-- 1로 바꾸면 투표 진행이 가능해진다. 0이면 투표종료됨 -->
			<!-- <input type="submit" value="투표하기"> -->
			 <input type="submit" value="Vote" class="btn btn-primary" >
		<%}else{%>
			Close vote
		<%}%>	
		</td>
		<td>
			
			
			<input type="button" value="View" class="btn btn-primary" onclick="javascript:window.open('pollView.jsp?num=<%=num%>'
			,'pollView','width=500, height=350')">
		</td>
	</tr>
</table>	
<input type="hidden" name="num" value="<%=num%>">
</form>
