<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.MyprofileBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
		MemberBean mbean = mMgr.getMember(id);
		MyprofileBean fbean = fmgr.getMyprofile(id);
		
%>
<!DOCTYPE html>
<html lang="en">
	
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>About Us </title>
	 <link rel="shortcut icon" href="img/minilogo.png"> 
    <!-- Plugins CSS -->
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    
    <!-- Custom style -->
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
		
		
		<div class="page-title image-title" style="background-image:url(img/bg.jpg);">
			<div class="container">
				<div class="page-title-wrap">
				<h2>Who We Are?</h2>
				<p><a href="#" class="theme-cl">Home</a> | <span>About Us</span></p>
				</div>
			</div>
		</div>
		
		<section>
			<div class="container">
			
				<div class="row">
				
					<div class="col-md-6 col-sm-12">
						<div class="ab-detail">
							<h2>Who We Are?</h2>
							<p>Netflix는 많은 국가의 회원에게 서비스를 제공하고 있습니다. 회원에게 Netflix 서비스에 대한 액세스를 제공하고 회원 데이터를 제어할 자격을 가지는 Netflix 법인은 가입한 국가에 따라 다르며, 해당 법인명은 회원의 가입 또는 결제 확인 이메일에 표시됩니다.</p>
							<p>넷플릭스서비시스코리아 유한회사</br>
								대한민국 서울 종로구 우정국로 26</br>
								센트로폴리스 빌딩 타워 A 20층 우편번호 03161</br>
								00-308-321-0058</p>
						</div>
					</div>
					
					<div class="col-md-6 col-sm-12">
						<!-- row -->
						<div class="row">
							<div class="col-md-6 col-sm-6">
								<div class="info-module">
									<i class="ti-help-alt cl-success"></i>
									<h4 class="infobox_title">24x7 Support</h4>
								</div>
							</div>
							<div class="col-md-6 col-sm-6">
								<div class="info-module">
									<i class="ti-world cl-success"></i>
									<h4 class="infobox_title">150+ Countries</h4>
								</div>
							</div>
						</div>
						<!-- /row -->
						
						<!-- row -->
						<div class="row">
							<div class="col-md-6 col-sm-6">
								<div class="info-module">
									<i class="ti-headphone-alt cl-success"></i>
									<h4 class="infobox_title">740+ Branches</h4>
								</div>
							</div>
							<div class="col-md-6 col-sm-6">
								<div class="info-module">
									<i class="ti-user cl-success"></i>
									<h4 class="infobox_title">10,000+ Member</h4>
								</div>
							</div>
						</div>
						<!-- /row -->
					</div>
					
				</div>
				
			</div>
		</section>
		<!-- =========== End Who We are =================== -->
		
		<!-- =========== Start Testimonial =================== -->
		<section class="half-bg">
			<div class="container">
				
				<div class="row">
					<div class="col-md-12">
						<div class="heading light">
							<span class="cl-white">Our Testimonials</span>
							<h1>What People uses NETPIDIA?</h1>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="testimonial-carousel">
						
						<!-- Single Testimonial -->
						<div class="testimonial-carousel-box">
							<div class="testimonial-caption">
								<i class="ti-quote-right"></i>
								<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident.</p>
								<div class="testimonial-author">
									<img src="assets/img/avatar4.jpg" class="img-responsive img-circle" alt="" />
									<h4>Adam Cristwal</h4>
								</div>
							</div>
						</div>
						
						<!-- Single Testimonial -->
						<div class="testimonial-carousel-box">
							<div class="testimonial-caption">
								<i class="ti-quote-right"></i>
								<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident.</p>
								<div class="testimonial-author">
									<img src="assets/img/avatar4.jpg" class="img-responsive img-circle" alt="" />
									<h4>Adam Cristwal</h4>
								</div>
							</div>
						</div>
						
						<!-- Single Testimonial -->
						<div class="testimonial-carousel-box">
							<div class="testimonial-caption">
								<i class="ti-quote-right"></i>
								<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident.</p>
								<div class="testimonial-author">
									<img src="assets/img/avatar4.jpg" class="img-responsive img-circle" alt="" />
									<h4>Adam Cristwal</h4>
								</div>
							</div>
						</div>
						
						<!-- Single Testimonial -->
						<div class="testimonial-carousel-box">
							<div class="testimonial-caption">
								<i class="ti-quote-right"></i>
								<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident.</p>
								<div class="testimonial-author">
									<img src="assets/img/avatar4.jpg" class="img-responsive img-circle" alt="" />
									<h4>Adam Cristwal</h4>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</section>
		<!-- =========== End Testimonial =================== -->
		
		
		
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
					53 Boulevard Victor Hugo 44200 Nantes, France
					</div>
				</div>
				
				<div class="col-md-3 col-sm-3 br-1 mbb-1">
					<div class="data-flex text-center">
						<span class="d-block mrg-bot-0">06 52 52 20 30</span>
						<a href="#" class="theme-cl"><strong>hello@gmail.com</strong></a>
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
		
		<!-- Dashboard Js -->
		<script src="assets/plugins/js/jquery.slimscroll.min.js"></script>
		<script src="assets/plugins/js/jquery.metisMenu.js"></script>
		<script src="assets/plugins/js/jquery.easing.min.js"></script>
 
		<!-- Custom Js -->
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