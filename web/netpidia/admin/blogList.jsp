<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.SUtilMgr"%>
<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.BlogBoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="netpidia.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="bmgr" class="netpidia.BlogBoardMgr"/>
<jsp:useBean id="cmgr" class="netpidia.BlogBCommentMgr"/>
<%-- <jsp:useBean id="fbean" class="netpidia.MyprofileBean"/> --%>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>


<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			//현재 접속된 url값
			StringBuffer url = request.getRequestURL();
			response.sendRedirect("login.jsp?url="+url);
			return;//이후에 jsp 코드 실행 안됨.
		}
		
		MemberBean mbean = mMgr.getMember(id);
		MyprofileBean fbean = fmgr.getMyprofile(id);
	

		int totalRecord = 0;//총게시물수
		int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock = 15;//블럭당 페이지 개수
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
		
		totalRecord = bmgr.getTotalCount(keyField, keyWord);
		
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
<html lang="en">
	
<head >
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Netpidia - Blog List</title>
	<link rel="shortcut icon" href="img/minilogo.png"> 
	<script type="text/javascript">
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("Enter...");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	
	function list() {
		document.listFrm.action = "blogList.jsp";
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
	
	function blogRead(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "blogRead.jsp";
		document.readFrm.submit();
	}
</script>
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet">
	<link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
	</head>
	<body bgcolor="#8A8D93" >

		<!-- ======================= 공통 메뉴부분 ===================== -->
		<nav class="navbar navbar-default navbar-mobile navbar-fixed light bootsnav" >
			<div class="container">
				<!-- Start Logo Header Navigation -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
						<i class="fa fa-bars"></i>
					</button>
					<a class="navbar-brand" href="index.jsp">
						<img src="img/logo.png" class="logo logo-display" alt="">
						<img src="img/logo.png" class="logo logo-scrolled" alt="">
					</a>
				</div>
				<div class="collapse navbar-collapse" id="navbar-menu">
					<ul class="nav navbar-nav navbar-left" data-in="fadeInDown" data-out="fadeOutUp">
						<li class="dropdown">
							<a href="index.jsp" class="dropdown-toggle">Home</a>
						</li>
						<li ><a href="surveyList.jsp" class="dropdown-toggle" >Poll</a>	
						</li>
						<li>
							<a href="productMgr.jsp">MiniShop</a>
						</li>
						<li>
							<a href="blogList.jsp">Our Blog</a>
						</li>
						<li>
							<a href="chat.jsp">Chat</a>
						</li>
						<li class="dropdown">
							<a href="orderList.jsp" class="dropdown-toggle" data-toggle="dropdown">My page</a>
							<ul class="dropdown-menu animated fadeOutUp">
								<li><a href="memberUpdate.jsp">Member Update</a></li>
								<li><a href="memberDelete.jsp">Membership Withdrawal</a></li>
								<li><a href="blogPost.jsp">My Blog</a></li>
								<li><a href="cartList.jsp">My Cart List</a></li>
								<li><a href="orderList.jsp">My Order List</a></li>
								<%if(fbean.getAboutme()==null){%>
								<li><a href="myprofileInsert.jsp">My Profile Insert</a></li>
								<%}else{%>
								<li><a href="myprofileUpdate.jsp">My Profile Update</a></li>
								<%}%>
								<%if(mbean.getGrade().equals("1")){ %>
								<li><a href="myprofileMgr.jsp">ProfileList Adm</a></li>
								<li><a href="orderMgr.jsp">OrderList Adm</a></li>
								<%}%>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Extra</a>
							<ul class="dropdown-menu animated fadeOutUp">
								<li><a href="aboutus.jsp">About Us</a></li>
								<li><a href="#">FAQs</a></li>
								<li><a href="contact.jsp">Contact</a></li>
							</ul>
						</li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown dash-link"><a href="#" class="dropdown-toggle">
						<img src="data/<%=fbean.getImage() %>" class="img-responsive avatar" alt="" />Hi, <%=id %></a> 
							<ul class="dropdown-menu left-nav">
								<%
									if(id==null){
								%>
								<li><a href="login.jsp">Log In</a></li>
								<li><a href="member.jsp">Sign Up</a></li>
								<%}else{ %>
								<li><a href="logout.jsp">Logout</a></li>
								<%} %>
							</ul>
						</li>
					</ul>
				</div>
		</nav>
		<!-- ======================= 공통 메뉴부분 끝 ===================== -->
		
		<div class="page-title image-title" style="background-image:url(img/bg.jpg);">
			<div class="container">
				<div class="page-title-wrap">
				<h2>Our Blogs</h2>
				<p><a href="#" class="theme-cl">Home</a> | <span>Our Blogs</span></p>
				</div>
			</div>
		</div>
		<div class="container">
				<div class="col-md-12">
				
					<div class="caption text-center cl-white">
						<h2>Search Whatever you want in our blog</h2>
					</div>
					<form>
						<fieldset class="home-form-1">
							<div class="col-md-2 col-sm-2 padd-0">
								<div class="sl-box">
									<form name="npFrm" method="post">
										<select class="wide form-control br-1" name="numPerPage" size="1" 
										onchange="numPerFn(this.form.numPerPage.value)">
											<option value="6" selected>Show 6 articles</option>
						    				<option value="9" >Show 9 articles</option>
						    				<option value="12">Show 12 articles</option>
										</select>
									</form>	
								</div>
							</div>
								
							<div class="col-md-2 col-sm-2 padd-0">
								<div class="sl-box">
									<form  name="searchFrm">
										<select class="wide form-control br-1" name="keyField" size="1">
											<option value="name"> By Name</option>
						    				<option value="subject"> By Title</option>
						    				<option value="content"> By Content</option>
										</select>
									</form>
								</div>
							</div>
							<div class="col-md-6 col-sm-6 padd-0">
								<input type="text" name="book-date" class="form-control br-1" placeholder="What are you looking for...">
							</div>	
							<div class="col-md-2 col-sm-2 padd-0">
								<button type="submit" class="btn btn-danger ml-1 mt-2" onClick="javascript:check()">Search</button>
								<a class="btn btn-danger ml-1 mt-2" href="blogPost.jsp">Write</a>	
								<input type="hidden" name="nowPage" value="1">
							</div>	
						</fieldset>
					</form>
					<form name="listFrm" method="post">
						<input type="hidden" name="reload" value="true">
						<input type="hidden" name="nowPage" value="1">
					</form>
				</div>
			</div>
		
		</br>

		<div class="container">
		
		<div class="col-md-12">
			<div class="col-md-6 col-sm-6 padd-0">
				<h3>Total : <%=totalRecord%> Articles</h3>
			</div>
			
		</div>
			<div class="container">
				<%
						Vector<BlogBoardBean> vlist = 
						bmgr.getBlogBoardList(keyField, keyWord, start, cnt);
						//브라우저 화면에 표시될 게시물 번호, 마지막 페이지에는 10개 이하의 개수 리턴 될수 있다.
						int listSize = vlist.size();
						if(vlist.isEmpty()){
							out.println("There's no content");
						}else{
				%>
				<div class="row">
				<%
						for(int i=0;i<numPerPage/*10*/;i++){
							if(i==listSize) break;
							BlogBoardBean bean = vlist.get(i);
							int num = bean.getNum();//게시물 번호
							String subject = bean.getSubject();//제목
							String name = bean.getName();//이름
							String regdate = bean.getRegdate();//날짜
							int depth = bean.getDepth();//답변의 깊이
							int count = bean.getCount();//조회수
							String filename = bean.getFilename();//첨부파일
							String image = bean.getImage();
							int bcount = cmgr.getBlogBCommentCount(num);
					%>
				   <%for(int j=0;j<depth;j++){out.println("&nbsp;&nbsp;");}%>
					<div class="col-md-4 col-sm-6">
						<div class="blog-box blog-grid-box">
							<div class="blog-grid-box-img">
								 <img src="fileupload/<%=image%>" class="img-responsive" alt="">  
							</div>
							<div class="blog-grid-box-content">
								<div class="blog-avatar text-center">
									<img class="rounded-circle" src="data/<%=fbean.getImage() %>" alt=""> 	
									<p><strong>By</strong> <span class="theme-cl"><%=id%></span></p>
								</div>
								<h3><%=subject%></h3>
								Posted <%=regdate%>
								<div align="center">
								<a href="javascript:blogRead('<%=num%>')" class="theme-cl" title="Read More..">More</a>
								</div>
							</div>
						</div>			
					</div>
				    <%}//---for%>		
				</div>
				<%}//---if-else%>
				<div class="row">
					<div class="col-md-12" align = "center">
						<h4><font color="red"><%=nowPage+"/"+totalPage%>Pages</font></h4>
					</div>	
				</div>		
				</br>
				<div class="row">
					<div class="col-md-12">
						<div class="bs-example">
							<ul class="pagination">
							
								<!-- 페이징 및 블럭 Start -->
								<!-- 이전블럭 -->
								
								<li class="page-item">
								<%if(nowBlock>1){%>
								  <a class="page-link" href="javascript:block('<%=nowBlock-1%>')" aria-label="Previous">
									<span class="ti-arrow-left"></span>
									<span class="sr-only">Previous</span>
								  </a>
								  <%}%>
								</li>

								<%
										int pageStart = (nowBlock-1)*pagePerBlock+1;
										int pageEnd = (pageStart+pagePerBlock/*15*/)<=totalPage?
												pageStart+pagePerBlock:totalPage+1;
										for(;pageStart<pageEnd;pageStart++){
								%>
								<li class="page-item">
									<a class="page-link" href="javascript:pageing('<%=pageStart%>')" class="page-link">
										<%if(nowPage==pageStart){%><font color="blue"><%}%>
											<%=pageStart%>
										<%if(nowPage==pageStart){%></font><%}%>
									</a>
								</li>
								<%}//--for%>
							
								<!-- 다음블럭 -->
								
							
								<li class="page-item">
								<%if(totalBlock>nowBlock){%>
								  <a class="page-link" href="javascript:block('<%=nowBlock+1%>')" aria-label="Next">
									<span class="ti-arrow-right"></span>
									<span class="sr-only">Next</span>
								  </a>
								  <%}%>
								</li>
								
							</ul>
							
						</div>
					</div>
				</div>	
				<form name="readFrm">
					<input type="hidden" name="nowPage" value="<%=nowPage%>">
					<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
					<input type="hidden" name="keyField" value="<%=keyField%>">
					<input type="hidden" name="keyWord" value="<%=keyWord%>">
					<input type="hidden" name="num">
				</form>	
			</div>
		</section>
		
		<!-- ============== Before Footer ====================== -->
		<section class="before-footer bt-1 bb-1">
			<div class="container-fluid padd-0 full-width">
			
				<div class=" col-md-2 col-sm-2 br-1 mbb-1">
					<div class="data-flex">
						<h4>Contact Us!</h4>
					</div>
				</div>
				
				<div class="col-md-3 col-sm-3 br-1 mbb-1">
					<div class="data-flex text-center">
					대한민국 서울특별시 종로구 우정국로 26, 센트로폴리스 A동 20층 우편번호 03161
					</div>
				</div>
				
				<div class="col-md-3 col-sm-3 br-1 mbb-1">
					<div class="data-flex text-center">
						<span class="d-block mrg-bot-0"> 00-308-321-0058</span>
						<a href="#" class="theme-cl"><strong>korea@netflix.com</strong></a>
					</div>
				</div>
				
				<div class="col-md-4 col-sm-4 padd-0">
					<div class="data-flex padd-0">
						<ul class="social-share">
							<li><a href="#"><i class="fa fa-facebook theme-cl"></i></a></li>
							<li><a href="#"><i class="fa fa-google-plus theme-cl"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter theme-cl"></i></a></li>
							<li><a href="#"><i class="fa fa-linkedin theme-cl"></i></a></li>
						</ul>
					</div>
				</div>
				
			</div>
		</section>
		<!-- =================== Before Footer ====================== -->
			
		<button class="w3-button w3-teal w3-xlarge w3-right" onclick="openRightMenu()"><i class="spin theme-cl fa fa-cog" aria-hidden="true"></i></button>
		<div class="w3-sidebar w3-bar-block w3-card-2 w3-animate-right" style="display:none;right:0;" id="rightMenu">
		  <button onclick="closeRightMenu()" class="w3-bar-item w3-button w3-large theme-bg">Close &times;</button>
		   <ul id="styleOptions" title="switch styling">
				<li>
					<a href="javascript: void(0)" class="cl-box cl-default" data-theme="skins/default"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-red" data-theme="skins/red"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-green" data-theme="skins/green"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-blue" data-theme="skins/blue"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-pink" data-theme="skins/pink"></a>
				</li>
				<li>
					<a href="javascript: void(0)" class="cl-box cl-purple" data-theme="skins/purple"></a>
				</li>
			</ul>
		</div>
		<script src="assets/plugins/js/jquery.min.js"></script>
		<script src="assets/plugins/js/bootstrap.min.js"></script>
		<script src="assets/plugins/js/viewportchecker.js"></script>
		<script src="assets/plugins/js/bootsnav.js"></script>
		<script src="assets/plugins/js/slick.min.js"></script>
		<script src="assets/plugins/js/jquery.nice-select.min.js"></script>
		<script src="assets/plugins/js/jquery.fancybox.min.js"></script>
		<script src="assets/plugins/js/jquery.downCount.js"></script>
		<script src="assets/plugins/js/freshslider.1.0.0.js"></script>
		<script src="assets/plugins/js/moment.min.js"></script>
		<script src="assets/plugins/js/daterangepicker.js"></script>
		<script src="assets/plugins/js/wysihtml5-0.3.0.js"></script>
		<script src="assets/plugins/js/bootstrap-wysihtml5.js"></script>
		<script src="assets/plugins/js/jquery.slimscroll.min.js"></script>
		<script src="assets/plugins/js/jquery.metisMenu.js"></script>
		<script src="assets/plugins/js/jquery.easing.min.js"></script>
		<script src="assets/js/custom.js"></script>
		<script src="assets/js/jQuery.style.switcher.js"></script>
		<script>
			function openRightMenu() {
				document.getElementById("rightMenu").style.display = "block";
			}
			function closeRightMenu() {
				document.getElementById("rightMenu").style.display = "none";
			}
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#styleOptions').styleSwitcher();
			});
		</script>
    </body>
</html>