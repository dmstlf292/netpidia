<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.SUtilMgr"%>
<%@page import="netpidia.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pMgr" class="netpidia.ProductMgr"/>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>

<%
		request.setCharacterEncoding("EUC-KR");
		Vector<ProductBean> pvlist = pMgr.getProductList();
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			//현재 접속된 url값
			StringBuffer url = request.getRequestURL();
			response.sendRedirect("login.jsp?url="+url);
			return;//이후에 jsp 코드 실행 안됨.
		}
		MemberBean mbean = mMgr.getMember(id);
		MyprofileBean fbean = fmgr.getMyprofile(id);
		
		//검색 및 정렬기능 추가
		String title="total";
		String searchType="like";
		String search = "";
		int pageNumber = 0;
		if(request.getParameter("title")!=null){
			title = request.getParameter("title");
		}
		if(request.getParameter("searchType")!=null){
			searchType = request.getParameter("searchType");
		}
		if(request.getParameter("search")!=null){
			search = request.getParameter("search");
		}
		if(request.getParameter("pageNumber")!=null){
			try{
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}catch(Exception e){
				System.out.println("검색 페이지 번호 오류");
			}
		}
		
		
		
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Netpidia mini shop - Admin</title>
    <script src="script3.js"></script>
    <script type="text/javascript">
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
    </script>
    <link rel="shortcut icon" href="img/minilogo.png"> 
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
	</head>
	<body>

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
						<li class="dropdown dash-link"><a href="#" class="dropdown-toggle"><img src="data/<%=fbean.getImage() %>" class="img-responsive avatar" alt="" />Hi, <%=id %></a> 
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
			</div>   
		</nav>
		<!-- ======================= 공통 메뉴부분 끝 ===================== -->
		<!-- ======================= 공통 메뉴부분 끝 ===================== -->
		<div class="page-title image-title" style="background-image:url(img/bg.jpg);">
			<div class="container">
				<div class="page-title-wrap">
				<h2>Netpidia MiniShop - Admin</h2>
				<p><a href="#" class="theme-cl">Shop</a> | <span>Minishop - Admin</span></p>
				</div>
			</div>
		</div>
		
		
		
		
		
		<!--메시지 보내는 모달 팝업창-->
							<div class="modal fade" id="messages" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content" id="myModalLabel2">
									  <form method="post" action="messageAction.jsp">
										<div class="modal-body">
											<div class="text-center"></div>
											<div class="tab-content">
												<div class="tab-pane fade in show active" id="messages" role="tabpanel">
													 <form method="post" action="messageAction.jsp" class="form-inline mt-3">
														<div class="form-group">
															<h5>Send us messages!</h5>
												            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
												              <span aria-hidden="true">&times;</span>
												            </button>
														</div>
														</br>
														<div class="form-group">
															<label>Title</label>
															<input type="text" name="messagesTitle" class="form-control" placeholder="Enter title...">
														</div>
														<div class="form-group">
															<label>Content</label>
															 <textarea  name="messagesContent" class="form-control" mexlength="2048" style="height : 140px;"placeholder="Enter content..."></textarea>
														</div>
														<div class="form-group text-center">
															<button type="submit" class="btn btn-danger ml-1 mt-2 full-width">Submit </button>
														</div>
													</form>
												</div>
											</div>
										</div>
									  </form>
									</div>
								</div>  
							</div> 
		
		<!--Report 보내는 모달 팝업창-->
							<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content" id="myModalLabel2">
									  <form method="post" action="reportAction.jsp">
										<div class="modal-body">
											<div class="text-center"></div>
											<div class="tab-content">
												<div class="tab-pane fade in show active" id="reportModal" role="tabpanel">
													 <form method="post" action="reportAction.jsp" class="form-inline mt-3">
														<div class="form-group">
															<h5>Levea us your report!</h5>
												            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
												              <span aria-hidden="true">&times;</span>
												            </button>
														</div>
														</br>
														<div class="form-group">
															<label>Title</label>
															<input type="text" name="reportTitle" class="form-control" placeholder="Enter title...">
														</div>
														<div class="form-group">
															<label>Content</label>
															 <textarea  name="reportContent" class="form-control" mexlength="2048" style="height : 140px;"placeholder="Enter content..."></textarea>
														</div>
														<div class="form-group text-center">
															<button type="submit" class="btn btn-danger ml-1 mt-2 full-width">Submit </button>
														</div>
													</form>
												</div>
											</div>
										</div>
									  </form>
									</div>
								</div>  
							</div> 
		
		
		
		
		
		<section class="gray-bg">
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-sm-12">
						<div class="tr-single-box">
							
							<div class="tr-single-header">
								<h4>Do you have any problem?</h4></p>
								<button type="submit" class="btn btn-danger ml-1 mt-2" data-toggle="modal" data-target="#reportModal" align="right">Report</button>
							</div>
							</br>
							<div class="tr-single-header">
								<button class="btn btn-danger ml-1 mt-2"  onClick="javascript:check()">Search</button>
								<button type="submit" class="btn btn-danger ml-1 mt-2" data-toggle="modal" data-target="#messages" align="right"><span class="fa fa-paper-plane mrg-r-10"></span>Send Messages</button>
								
							</div>
							<div id="filter" class="collapse in">
								<div class="tr-single-body">
									<div class="sidebar-input">
										<input type="text" class="form-control" placeholder="Type Keyword..">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-8 col-sm-12">
						<div class="row mrg-0">
							<div class="tr-single-box short-box">
								<div class="col-sm-3 hidden-xs align-self-center">
									<h4>Mini shop</h4>
								</div>
								<div class="col-sm-9 text-right">
									<div class="btn-group mr-lg-2">
										
										<button  onclick="location='productInsert.jsp'" class="btn btn-danger ml-1 mt-2" >Post Item</button>
										
									</div>	
								</div>
							</div>
						</div>
						<div class="row">
						<!-- Single Tour 시작 !!!!!!!!!-->
						<%
							for(int i=0; i<pvlist.size();i++){
							ProductBean pbean = pvlist.get(i);
						%>
							<div class="col-md-6 col-sm-6">
								<article class="tour-box style-1">
									<div class="tour-box-image">
										<figure>
										<!-- -여기 이미지 클릭하면 상세보기 페이지로 이동---- -->
										<!-- <a href="productDetail.jsp"> -->
											<a href="javascript:productDetail('<%=pbean.getProductNo()%>')">
												<img src="data/<%=pbean.getImage() %>" class="img-responsive listing-box-img" alt="" />
												<div class="list-overlay"></div>
											</a>
										</figure>
									</div>
									<div class="inner-box">
										<div class="box-inner-ellipsis">
											<h4 class="entry-title">
												<a href="#"><%=pbean.getName() %></a>
											</h4>
											<div class="price-box">
												<div class="tour-price fl-right">
													<span class="theme-cl f-bold"><%=SUtilMgr.monFormat(pbean.getPrice())%></span>
													<%-- <span class="theme-cl f-bold"><%=pbean.getDate()%></span> --%>
													<%-- <span class="theme-cl f-bold"><%=SUtilMgr.monFormat(pbean.getStock())%></span> --%>
												</div>
											</div>
										</div>
									</div>
								</article>	
							</div>
							
							<%} %>
						<!-- Single Tour 끝 -->	
						</div>
						<form name="detail" method="post" action="productDetail.jsp" >
							<input type="hidden" name="productNo">
						</form>
					</div>
				</div>
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