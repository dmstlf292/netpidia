<!-- blogRead.jsp -->
<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="netpidia.BlogBCommentBean"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="netpidia.BlogBoardBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="bmgr" class="netpidia.BlogBoardMgr"/>
<jsp:useBean id="cmgr" class="netpidia.BlogBCommentMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<%
		request.setCharacterEncoding("EUC-KR");
        //read.jsp?nowPage=1&numPerPage=10&keyField=&keyWord=&num=3
        String id = (String)session.getAttribute("idKey");
        MyprofileBean fbean = fmgr.getMyprofile(id);
        		
        		
        String nowPage = request.getParameter("nowPage");	
		String numPerPage = request.getParameter("numPerPage");	
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");	
		int num = UtilMgr.parseInt(request, "num");	

		//댓글입력시 flag값 insert값으로 넘어간다.
		String flag = request.getParameter("flag");
		if(flag!=null){
			if(flag.equals("insert")){
				BlogBCommentBean cbean = new BlogBCommentBean();
				cbean.setNum(num);
				cbean.setName(request.getParameter("cName"));
				cbean.setComment(request.getParameter("comment"));
				cmgr.insertBlogBComment(cbean);
			}else if(flag.equals("del")){//"delete 말고" "del" 해야지 댓글 삭제가 된다
				//댓글 삭제 기능, 정수로 바꿔야한다.
				cmgr.deleteBlogBComment(UtilMgr.parseInt(request, "cnum"));
			}
		}else{
			//list.jsp에서 넘어오는 경우, flag값은 안가져오지만 조회수는 증가
			//조회수 증가
			bmgr.upCount(num);
		}
		//조회수 증가
		bmgr.upCount(num);
		//게시물 읽기
		BlogBoardBean bean = bmgr.getBlogBoard(num);
		String name = bean.getName();
		String subject = bean.getSubject();
		String regdate = bean.getRegdate();
		String content = bean.getContent();
		String filename = bean.getFilename();
		int filesize = bean.getFilesize();
		String totalprice = bean.getTotalprice();
		String price = bean.getPrice();
		String cperson = bean.getCperson();
		String email = bean.getEmail();
		String netemail = bean.getNetemail();
		String ip = bean.getIp();
		int count = bean.getCount();	
		//읽어온 게시물을 수정 및 삭제를 위해 세션저장
		String image = bean.getImage();
		session.setAttribute("bean", bean);		
%>





<!doctype html>
<html lang="en" dir="ltr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="icon" href="favicon.ico" type="image/x-icon"/>
<title>Netpidia - Blog 더보기</title>
<link rel="shortcut icon" href="img/minilogo.png">
<script type="text/javascript">
	function down(filename) {
		document.downFrm.filename.value=filename;
		document.downFrm.submit();
	}
	function list() {
		document.listFrm.action = "blogList.jsp";
		document.listFrm.submit();
	}
	function cInsert() {
		if(document.cFrm.comment.value==""){
			alert("댓글을 입력하세요.");
			document.cFrm.comment.focus();
			return;
		}
		document.cFrm.submit();
	}
	function cDel(cnum) {
		document.cFrm.cnum.value=cnum;
		document.cFrm.flag.value="del";
		document.cFrm.submit();
	}
</script>
<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/plugins/summernote/dist/summernote.css"/>
<link rel="stylesheet" href="assets/css/main.css"/>
<link rel="stylesheet" href="assets/css/theme1.css"/>
</head>
<body class="font-montserrat">
<div >
<%
	MyprofileBean myprofile = fmgr.getMyprofile(id);
%>


    <div >
        <div id="page_top" class="section-body top_dark">
            <div class="container-fluid">
                <div class="page-header">
                    <div class="left">
                        <a href="blogList.jsp" class="icon menu_toggle mr-3"><i class="fa  fa-align-left"></i></a>
                        <h1 class="page-title">Blog Detail</h1>
                        <img class="avatar" src="data/<%=fbean.getImage() %>" alt="" data-toggle="tooltip" title="User Menu"/>
                       &nbsp;&nbsp;&nbsp;&nbsp; <h1 class="page-title">Hi, <%=id %></h1>
                    </div>
                </div>
            </div>
        </div>
        
        
        
       
        <div class="section-body mt-3">
            <div class="container-fluid">
                <div class="row clearfix">
                    <div class="col-lg-4 col-md-12">
                        <div class="card c_grid c_yellow">
                            <div class="card-body text-center">
                                <div class="circle">
                                  
                                    <img class="rounded-circle" src="data/<%=myprofile.getImage() %>" alt="">
                                	
                                </div>
                               
                                 <h6 class="mt-3 mb-0"><%=id%></h6>
                                 <h6 class="mt-3 mb-0"><%=name%></h6>
                                <span><%=email%></span>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">My Facebook Lin</h3>
                            </div>
                            <div class="card-body">
                               <span><%=myprofile.getFhp()%></span> 
                          
                            </div>                        
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">My Instagram Link</h3>
                            </div>
                            <div class="card-body">
                               <span><%=myprofile.getIhp()%></span> 
                          
                            </div>                        
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Title</h3>
                            </div>
                            <div class="card-body">
                               <span><%=subject%></span> 
                          
                            </div>                        
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Share Netflix Id Info</h3>
                            </div>
                            <div class="card-body">
                                <ul class="list-group">
                                	<li class="list-group-item">
                                        <small class="text-muted">Share ID :  <%=netemail%> </small>
                                        <p class="mb-0"></p>
                                    </li>
                                    <li class="list-group-item">
                                        <small class="text-muted">Total price : <%=totalprice%></small>
                                        <p class="mb-0"></p>
                                    </li>
                                    <li class="list-group-item">
                                        <small class="text-muted">Price per 1 person <%=price%> </small>
                                        <p  class="mb-0"></p>
                                    </li>
                                    <li class="list-group-item">
                                            <small class="text-muted">I am looking for <%=cperson%> person(s)</small>
                                            <p  class="mb-0"></p>
                                        </li>
                                    <li class="list-group-item">
                                        <small class="text-muted">Close date will be   </small>
                                        <p  class="mb-0"></p>
                                    </li>
                                
                                </ul>
                            </div>
                        </div> 
                    </div>
                    <div class="col-lg-8 col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div >
                                    <p name="content"><%=content%></p>
                                </div>
                              
                            </div>
                        </div>
						 		<div class="mt-4 ">
						 			<div class="mt-2 text-right">
							 		 	<a href="blogDelete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">Delete</a>
	                                     <a href="blogUpdate.jsp?nowPage=<%=nowPage%>&num=<%=num%>&numPerPage=<%=numPerPage%>" >Modift</a>
                                     </div>
                                     
                                     
                                     <div class="mt-2 text-right">
	                                	<a>첨부파일 : <%if(filename!=null&&!filename.equals("")){%>
								    		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
								    		<font color="blue">(<%=UtilMgr.intFormat(filesize)%>bytes)</font>
								    	<%}else{out.println("첨부된 파일이 없습니다.");}%></a>
	                                	<button type="button" class="btn btn-primary">Posted Date: <%=regdate%></button>
	                                	<button type="button" class="btn btn-primary">View <%=count%></button>
	                                	 <button type="button" onClick="javascript:location.href='blogList.jsp'" class="btn btn-primary">List</button>
                                	</div> 
                                </div>
                       <!-- 댓글 입력폼 Start -->
                       <form method="post" name="cFrm">
                      <%--  <div class="card">
							<div class="card-header">
								<h3 class="card-title">Test Image file</h3>
							</div>
							<div class="card-body">
								<img src="fileupload/<%=image%>" >	
							</div>
						</div> --%>
                       <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Live your comment</h3>
                            </div>
                            <div class="card-body">
                                <div class="timeline_item ">
                                    <img class="tl_avatar" src="data/<%=fbean.getImage() %>" alt="">
                                    <span><a name="cName">Name : <input name="cName" size="10" value=""></a><a name=id> (Id : <%=id %>)</a>  <small class="float-right text-right"> Date : <%=regdate%></small></span>
                                   
                                    <div class="msg">
                                         <textarea name="comment" rows="5" cols="108"></textarea>
                                    </div>     
                                    <button type="submit" class="btn btn-primary"  onclick="cInsert()" >Post</button>                           
                                </div>
                                 
                            </div>
                             
                        </div> 
                        
                        <input type="hidden" name="flag" value="insert">
                        <input type="hidden" name="num" value="<%=num%>">
						 <input type="hidden" name="cnum">
					    <input type="hidden" name="nowPage" value="<%=nowPage%>">
					    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
					   <%if(!(keyWord==null||keyWord.equals(""))){ %>
					    <input type="hidden" name="keyField" value="<%=keyField%>">
					    <input type="hidden" name="keyWord" value="<%=keyWord%>">
						<%}%>
						</form>
                         <!-- 댓글 입력폼 End -->


						 <!-- 댓글 List Start -->
						<%
							Vector<BlogBCommentBean> cvlist = cmgr.getBlogBComment(num);
							if(!cvlist.isEmpty()){
						%>
						
						<div class="card">
						<% 
							for(int i=0; i<cvlist.size(); i++){
								BlogBCommentBean cbean = cvlist.get(i);
								int cnum = cbean.getCnum();
								String cname = cbean.getName();
								String comment = cbean.getComment();
								String cregdate = cbean.getRegdate();
						
						%>
                            
                            <div class="card-body">
                                <div class="timeline_item ">
                                    <img class="tl_avatar" src="assets/images/xs/avatar1.jpg" alt="">
                                    <span><a name="cName">Name : <%=cname%></a> (Id : <%=id %>)</a> <small class="float-right text-right"><%=cregdate%></small></span>
                                    <h6 class="font600">댓글:<%=comment%></h6> 
                                    <button class="btn btn-primary" onclick="cDel('<%=cnum%>')">delete</button>                         
                                </div>
                            </div>
                            <%}//for%>  
                        </div> 
							<% }//--if%>
						<%-- <div class="card">
							<div class="card-header">
								<h3 class="card-title">Test blog cover</h3>
							</div>
							<div class="card-body">
								<img src="fileupload/<%=image%>" >	
							</div>
						</div> --%>
                    </div>
                </div>
            </div>
        </div>
       <form method="post" name="downFrm" action="download.jsp">
			<input type="hidden" name="filename">
		</form>
		
		<form name="listFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
     
    </div>
</div>
<script src="assets/bundles/lib.vendor.bundle.js"></script>
<script src="assets/bundles/summernote.bundle.js"></script>
<script src="assets/js/core.js"></script>
<script src="assets/js/page/summernote.js"></script>
</body>
</html>