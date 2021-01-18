<!-- delete.jsp -->
<%@page import="netpidia.BlogBoardBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="bmgr" class="netpidia.BlogBoardMgr"/>
<!-- 댓글 mgr 만들기 -->
<jsp:useBean id="cmgr" class="netpidia.BlogBCommentMgr"/>
<html>
<head>
<%
		request.setCharacterEncoding("EUC-KR");
		String nowPage = request.getParameter("nowPage");
		int num = UtilMgr.parseInt(request, "num");
		//비번을 입력을 받아서 삭제를 처리하는 기능
		if(request.getParameter("pass")!=null){
			BlogBoardBean bean = (BlogBoardBean)session.getAttribute("bean");
			//delete.jsp에서 사용자가 입력한 비번
			String inPass = request.getParameter("pass");
			//db에 저장된 비번
			String dbPass = bean.getPass();
			if(inPass.equals(dbPass)){//==는 객체의 주소값 비교.
				bmgr.deleteBlogBoard(num, bean.getFilename());
				//원 게시물이 삭제되면 관려된 댓글 모두 삭제
				cmgr.deleteAllBlogBComment(num);
				String url = "blogList.jsp?nowPage="+nowPage;
				response.sendRedirect(url);
			}else{%>
			<script type="text/javascript">
				alert("입력하신 비밀번호가 아닙니다.");
				history.back();
			</script>
			<%}
		}else{//비번을 입력 받기 위한 폼(form) 출력
%>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function check() {
		if (document.delFrm.pass.value == "") {
			alert("패스워드를 입력하세요.");
			document.delFrm.pass.focus();
			return;
		}
		document.delFrm.submit();
	}
</script>
<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/plugins/summernote/dist/summernote.css"/>
<link rel="stylesheet" href="assets/css/main.css"/>
<link rel="stylesheet" href="assets/css/theme1.css"/>
</head>


 						<div class="card" align="center">
 						<form name="delFrm" method="post">
                            <div class="card-header" align="center">
                                <h3 class="card-title" align="center">Enter your password for delete</h3>
                            </div>
                            <div class="card-body">
                                <div class="timeline_item ">
                                   
                                    <span><a name="cName">Password : <input type="password" name="pass" size="17" maxlength="15"></a>  
                                   
                                    <!-- <button type="submit" class="btn btn-primary"  onclick="cInsert()">Post</button>     -->    
                                    <input type="button" value="submit" onClick="check()"  class="btn btn-primary">      
                                    <input type="reset" value="reset" class="btn btn-primary">
									<input type="button" value="back" onClick="history.go(-1)" class="btn btn-primary">              
                                </div>
                                 
                            </div>
                            <input type="hidden" name="nowPage" value="<%=nowPage%>"> 
							<input type="hidden" name="num" value="<%=num%>">
                        </form>     
                        </div> 
                        
                        
<%}%>





<script src="assets/bundles/lib.vendor.bundle.js"></script>
<script src="assets/bundles/summernote.bundle.js"></script>
<script src="assets/js/core.js"></script>
<script src="assets/js/page/summernote.js"></script>
</body>
</html>