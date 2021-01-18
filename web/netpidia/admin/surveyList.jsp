<!-- -----------------------------사용자용 surveyList.jsp-------------------------------- -->
<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.GuestBookBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.CommentBean"%>
<%@page import="java.util.Vector"%>
<%@page import="netpidia.PollListBean"%>
<%@page import="netpidia.BoardBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<!-- -로그인- -->
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>

<!-- 게시글 댓글 mgr 만들기 -->
<jsp:useBean id="mgr" class="netpidia.BoardMgr"/>
<jsp:useBean id="cmgr" class="netpidia.BCommentMgr"/>

<!-- -방명록 댓글 & 대댓글 mgr -->
<jsp:useBean id="gmgr" class="netpidia.GuestBookMgr"/> 
<% 
	request.setCharacterEncoding("EUC-KR");
	String id = (String)session.getAttribute("idKey");
	if(id==null){
		//현재 접속된 url값
		StringBuffer url = request.getRequestURL();
		response.sendRedirect("login.jsp?url="+url);
		return;//이후에 jsp 코드 실행 안됨.
	}
	
	MyprofileBean fbean = fmgr.getMyprofile(id);
	
	int totalRecord = 0;//총게시물수
	int numPerPage = 5;//페이지당 레코드 개수(5,10,15,30)
	int pagePerBlock = 5;//블럭당 페이지 개수
	int totalPage = 0;//총 페이지 개수
	int totalBlock =0;//총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭

	//요청된 numPerPage 처리
	if(request.getParameter("numPerPage")!=null){
	//Integer.parseInt(request.getParameter(name));
	numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
			
	//검색에 필요한 변수
	String keyField = "", keyWord = "";
	if(request.getParameter("keyWord")!=null){
			keyField = request.getParameter("keyField");
			keyWord = request.getParameter("keyWord");
	}
			
	//검색 후에 다시 처음 리스트 요청
	if(request.getParameter("reload")!=null&&
			request.getParameter("reload").equals("true")){
			keyField =""; keyWord = ""; 
	}
			
	totalRecord = mgr.getTotalCount(keyField, keyWord);
			
	if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
	}
			
	//sql문에 들어가는 start, cnt 선언
	int start = (nowPage*numPerPage)-numPerPage;
	int cnt = numPerPage;
			
	//전체페이지 개수
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	//전체블럭 개수
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	//현재블럭
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>
<!DOCTYPE html>
<html>
  <head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Netpidia </title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Custom Font Icons CSS-->
    <link rel="stylesheet" href="css/font.css">
    <!-- Google fonts - Muli-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="img/minilogo.png"> 
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
 
 <script>
 function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	
	function surveyList() {
		document.listFrm.action = "surveyList.jsp";
		document.listFrm.submit();
	}
	
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value=numPerPage;
		document.readFrm.submit();
	}
	
	function pageing(page) {
		document.readFrm.nowPage.value=page;
		document.readFrm.submit();
	}
	
	function block(block) {
		document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	
	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "read.jsp";
		document.readFrm.action = "read.jsp";
		<%-- <input type="button" value="결과" 
			onclick="javascript:window.open('pollView.jsp?num=<%=num%>'
			,'pollView','width=500, height=350')"> --%>
			
		document.readFrm.submit();
	}
	
////////////////////////////////////댓글////////////////////////////////////////////
	
	function updateFn(num) {//기능 : 대댓글 수정창
		url = "updateGuestBook.jsp?num="+num;
		window.open(url,"GuestBook Update","width=520,height=300");
	}
	function commentFn(frm) { //this.form 
		if(frm.comment.value==""){
			alert("내용을 입력하세요.");
			frm.comment.focus();
			return;
		}
		frm.submit();
	}
	function disFn(num) {//여기 아주 중요
		var v = "cmt" + num;
		//alert(v);
		var e = document.getElementById(v);
		if(e.style.display=='none')
			e.style.display='block';//보이는것
		else
			e.style.display='none';//안보임
	}

 </script>
  </head>
  <body>
   <header class="header">   
      <nav class="navbar navbar-expand-lg"> 
      <!-- 검색창 -->
        <div class="search-panel">
          <div class="search-inner d-flex align-items-center justify-content-center">
            <div class="close-btn">Close <i class="fa fa-close"></i></div>
            <form name="searchFrm">
                        <div class="col-sm-9">
                          <select name="keyField" size="1" class="form-control mb-3 mb-3">
                          	<option value="name">Choose</option>
                            <option value="name">By Name</option>
                            <option value="subject">By Title</option>
                            <option value="content">By Content</option>
                          </select>
                        </div>
              <div class="form-group">
                <input size="16" name="keyWord" type="search" name="search" placeholder="What are you searching for...">
                <button type="submit" class="submit" onClick="javascript:check()">Search</button>
              	<input type="hidden" name="nowPage" value="1">
              </div>
            </form>
          </div>
        </div> 
       <!-- 검색창 -->  
        <div class="container-fluid d-flex align-items-center justify-content-between">
          <div class="navbar-header">
            <!-- Navbar Header--><a href="index.jsp" class="navbar-brand">
              <div class="brand-text brand-big visible text-uppercase"><strong class="text-primary">Netpidia Poll & Event</strong></div>
              <div class="brand-text brand-sm"></div></a>
            <!-- Sidebar Toggle Btn-->
            <button class="sidebar-toggle"><i class="fa fa-long-arrow-left"></i></button>
          </div>
          <div class="right-menu list-inline no-margin-bottom">    
          	<%if (id==null){ %>
          	<div class="list-inline-item logout">                   <a id="login" href="login.jsp" class="nav-link">Login <i class="icon-logout"></i></a></div> 
          	<div class="list-inline-item logout">                   <a id="member" href="member.jsp" class="nav-link">Sign up <i class="icon-logout"></i></a></div> 
            <%}else{ %>
            <div class="list-inline-item logout">                   <a id="logout" href="login.jsp" class="nav-link">Logout <i class="icon-logout"></i></a></div>
           	<%} %>
            
          </div>
          </div>
        </div>
      </nav>
    </header>
    <div class="d-flex align-items-stretch">
      <!-- Sidebar Navigation-->
      <nav id="sidebar">
        <!-- Sidebar Header-->
        <div class="sidebar-header d-flex align-items-center">
          <div class="avatar"><img src="data/<%=fbean.getImage() %>" alt="..." class="img-fluid rounded-circle"></div>
          <div class="title">
         	
            <h1 class="h5">Hi, <%=id%> </h1>
            <p></p>
          </div>
        </div>
        <!-- Sidebar Navidation Menus--><span class="heading">Admin</span>
        <ul class="list-unstyled">
                <!-- <li><a href="index.html"> <i class="icon-home"></i>Home </a></li> -->
                <li class="active"><a href="surveyList.jsp"> <i class="icon-padnote"></i>Event & Review </a></li>   
                <li><a href="pollInsert.jsp"> <i class="icon-padnote"></i>Form for poll(Admin)</a></li>
                <li><a href="pollListCurrent.jsp" > <i class="icon-padnote"></i>Current Poll List</a></li>
        </ul>
        <!-- <span class="heading">APP</span>
        <ul class="list-unstyled">
          <li><a href="chat.jsp"> <i class="icon-settings"></i>CHAT </a></li>
          <li><a href="minishop.jsp"> <i class="icon-writing-whiteboard"></i>MINI SHOP </a></li>
        </ul>   -->
      </nav>
      <!-- --------공통헤더부분--------- -->
      <!-- Sidebar Navigation end-->
      <div class="page-content">
        <div class="page-header">
          <div class="container-fluid">
            <h2 class="h5 no-margin-bottom">Event & Reviews</h2>
            
          </div>
        </div>
        <section class="no-padding-top">
          <div class="container-fluid">
            <div class="row">
        	   <div class="col-lg-6">
	                <div class="block">
	                	<div class="title"><strong>Current Event</strong></div>
		                  <div class="block-body text-center">
		                    <button type="button" class="btn btn-primary" onClick="javascript:window.open('game1.jsp','index1','width=800, height=600')">Game 1 </button>
		                     <button type="button" class="btn btn-primary" onClick="javascript:window.open('game2.jsp','index2','width=800, height=600')">Game 2 </button>
		                  </div>
				    </div>
			   </div>
				  

	          <div class="col-lg-6">
	                <div class="block">
	                  <div class="title"><strong>Board for poll
	                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
						Total : <%=totalRecord%>Articles(
						<%=nowPage+"/"+totalPage%>Pages)
						</div>
						<div align="right">
							<form name="npFrm" method="post">
				   				<div class="input-group-prepend">
                            	  <select name="numPerPage" size="1" 
									onchange="numPerFn(this.form.numPerPage.value)" class="btn btn-outline-secondary dropdown-toggle" >
					    				<option value="5" selected class="dropdown-item">5 articles</option>
					    				<option value="10" class="dropdown-item">8 articles</option>
					    				<option value="15" class="dropdown-item">10 articles</option>
					   			  </select>
                            	  <div class="list-inline-item"><a href="#" class="search-open nav-link"><i class="icon-magnifying-glass-browser"></i></a></div>
                            	</div>
                            </form>	
   							<script>document.npFrm.numPerPage.value=<%=numPerPage%>;</script>
						</div>
	                  <div class="table-responsive"> 
	                    <table class="table table-striped table-hover">
	                    <%
								Vector<BoardBean> vlist = 
								mgr.getBoardList(keyField, keyWord, start, cnt);
								//브라우저 화면에 표시될 게시물 번호, 마지막 페이지에는 10개 이하의 개수 리턴 될수 있다.
								int listSize = vlist.size();
								if(vlist.isEmpty()){
									out.println("There is not posting");
								}else{
						%>
	                      <thead>
	                        <tr>
	                          <th>#</th>
	                          <th>Title</th>
	                          <th>Name</th>
	                          <th>Date</th>
	                          <th>View</th>
	                        </tr>
	                      </thead>
	                      <tbody>
	                      <%
								for(int i=0;i<numPerPage/*10*/;i++){
									if(i==listSize) break;
									BoardBean bean = vlist.get(i);
									int num = bean.getNum();//게시물 번호
									String subject = bean.getSubject();//제목
									String name = bean.getName();//이름
									String regdate = bean.getRegdate();//날짜
									int depth = bean.getDepth();//답변의 깊이
									int count = bean.getCount();//조회수
									String filename = bean.getFilename();//첨부파일
									//댓글 count 추가하기!!!
									int bcount = cmgr.getBCommentCount(num);
							%>
	                        <tr>
	                          <th scope="row"><%=totalRecord-start-i%></th>
	                          <td><%for(int j=0;j<depth;j++){out.println("&nbsp;&nbsp;");}%>
									<a href="javascript:read('<%=num%>')"><%=subject%></a>
									<%if(filename!=null&&!filename.equals("")){%>
										<img src="img/icon_file.gif" align="middle">
									<%}%>
									<%if(bcount>0){%>
										<font color="red">(<%=bcount%>)</font>
									<%} %></td> 
	                          <td><%=name%></td> 
	                          <td><%=regdate%></td> 
	                          <td><%=count%></td> 
	                        </tr>	
	                      </tbody>
	                      <%}//---for%>		
	                    </table>
	                  <%}//---if-else%>  
	                  </div>
	                </div>

	                <div align ="center">
					<!-- 페이징 및 블럭 Start -->
					<!-- 이전블럭 -->
					<%if(nowBlock>1){%>
						<a href="javascript:block('<%=nowBlock-1%>')">◀</a>
					<%}%>
					<!-- 페이징 -->
					<%
							int pageStart = (nowBlock-1)*pagePerBlock+1;
							int pageEnd = (pageStart+pagePerBlock/*15*/)<=totalPage?
									pageStart+pagePerBlock:totalPage+1;
							for(;pageStart<pageEnd;pageStart++){
					%>
					<a href="javascript:pageing('<%=pageStart%>')">
						<%if(nowPage==pageStart){%><font color="blue"><%}%>
							&nbsp;&nbsp;<%=pageStart%>&nbsp;&nbsp;
						<%if(nowPage==pageStart){%></font><%}%>
					</a>
					<%}//--for%>
					<!-- 다음블럭 -->
					<%if(totalBlock>nowBlock){%>
						<a href="javascript:block('<%=nowBlock+1%>')">▶</a>
					<%}%>
	                <!-- 페이징 및 블럭 End -->
	                </div>

	                <!-- 게시글 하단부분 -->
	                <div align ="center">
	                    <input type="button" value="Post" class="btn btn-primary" onClick="javascript:window.open('post.jsp','post','width=600, height=600')">  
						<!-- <a href="post.jsp">글쓰기</a> -->
						<!-- <button class="btn btn-primary" onClick="javascript:window.open('post.jsp','post','width=600, height=600')">글쓰기</button> -->
						
						<input type="button" value="Back" class="btn btn-primary" onClick="javascript:'surveyList()''"> 
	                </div>
	              </div>
	              
	              <form name="listFrm" method="post">
					<input type="hidden" name="reload" value="true">
					<input type="hidden" name="nowPage" value="1">
				  </form>
				
				  <form name="readFrm">
					<input type="hidden" name="nowPage" value="<%=nowPage%>">
					<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
					<input type="hidden" name="keyField" value="<%=keyField%>">
					<input type="hidden" name="keyWord" value="<%=keyWord%>">
					<input type="hidden" name="num">
				  </form>
				  
				  
				  
				  
				  
	       		 </div>
	          </div>
        </section>

<!-- -------------------------------------------------------------------------------------------------------- -->
   <!-- 윗쪽 댓글란 -->
      <jsp:include page="postGuestBook.jsp"/>
 
        <section class="no-padding-bottom">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-6">                                           
                <div class="messages-block block">
                  

                 
                  <%
                  	Vector<GuestBookBean> gvlist = gmgr.listGuestBook(id, login.getGrade());
                  	//out.print(vlist.size());
                  	if(gvlist.isEmpty()){
                  %>
                  <strong>No reviews</strong>
                  
                  <%}else{
                	  for(int i=0; i<gvlist.size();i++){
                		GuestBookBean bean = gvlist.get(i);
                		MemberBean writer = gmgr.getMember(bean.getId());
                  %>
                 
				                  <div class="messages"><a href="#" class="message d-flex align-items-center">
				                      <div class="profile">
				                      	<img src="data/<%=fbean.getImage()%>" alt="..." class="img-fluid">
				                      	
				                      </div>
				                      
				                   		
				                   	  <div class="content">
				                   	 
				                   	  <input value="<%=writer.getName() %>" readonly class="form-control"> 	
				                   	   <%=bean.getRegdate()+" "+bean.getRegtime()%>
				                   	 </div>
								  </div>	 
				               	  <div>
									 	<input value="<%=bean.getContents() %>" class="form-control">
								  </div>
								    		
								 <% 
									
										boolean chk = login.getId().equals(writer.getId());
										if(chk||login.getGrade().equals("1")){
											if(chk){
										%>
											<a href="javascript:updateFn('<%=bean.getNum()%>')"> modify</a>
										<%}//---if2%>
											<a href="deleteGuestBook.jsp?num=<%=bean.getNum()%>"> delete</a>
										<%if(bean.getSecret().equals("1")){%>	
										비밀글
										<%
											}//---if3
										}//---if1
								%>		
			          
			 
			            
                  <!-- Comment List Start -->	
                  <div id="cmt<%=bean.getNum() %>" style="display: none">
                    <%
						Vector<CommentBean> cvlist = gmgr.listComment(bean.getNum());
						//out.print(cvlist.size()); 
						if(!cvlist.isEmpty()){
					%>
                        <div class="col-sm-9">
                    <%  
                    	for(int j=0; j<cvlist.size(); j++){
                    		CommentBean cbean = cvlist.get(j);
                    %>
                          <div><%=cbean.getCid()%></div>
                          <textarea class="form-control form-control-warning"><%=cbean.getComment() %></textarea>
                          <%if(login.getId().equals(cbean.getCid())){ %><!-- ==하면 주소값을 비교하는것 -->
							<a href="commentProc.jsp?flag=delete&cnum=<%=cbean.getCnum()%>">
							[삭제]</a>
							<%}%>
						   <div><%=cbean.getCregDate()%><%=cbean.getCip()%></div>	 
                    <%}//--for(comment)%>
                     </div>
                  <%}//--if(comment)%>
                  </div>
                  <!-- Comment List End -->
                  </br>
                  <div>
                  	<button onclick="disFn('<%=bean.getNum()%>')" class="btn btn-secondary" >
					+ Reply<%=cvlist.size()>0?cvlist.size():"" %></button>
                  </div>
                  <!-- Comment Form Start -->	
                <form name="cFrm" method="post" action="commentProc.jsp">
                        <div class="col-sm-9">
                          <textarea name="comment" rows="3" cols="50" placeholder="Leave comment" required  class="form-control form-control-warning"></textarea>
                          <input type="button" value="post" onclick="commentFn(this.form)" class="btn btn-primary">
                        </div>
                        <div>
                        	
							<input type="hidden" name="flag" value="insert">
							<!-- 방명록 글번호 -->
							<input type="hidden" name="num" value="<%=bean.getNum()%>">
							<!-- 로그인 id -->
							<input type="hidden" name="cid" value="<%=login.getId()%>">
							<!-- 댓글 입력 ip 주소 -->
							<input type="hidden" name="cip" value="<%=request.getRemoteAddr()%>">
                        </div>
                  </form>
                <!-- Comment  Form End -->
				<%
						}//---for
					}//---else
				%>	
				<!-- GuestBook List End --> 

       	 	</div>
       	  </div>
       	</div>
      </div>
    </div>
    </section>
    <!-- JavaScript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="js/charts-home.js"></script>
    <script src="js/front.js"></script>
  </body>
</html>
	