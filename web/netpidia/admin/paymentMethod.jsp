<%@page import="netpidia.ProductBean"%>
<%@page import="netpidia.SUtilMgr"%>
<%@page import="java.util.Enumeration"%>
<%@page import="netpidia.SUtilMgr"%>
<%@page import="netpidia.OrderBean"%>
<%@page import="java.util.Hashtable"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.MyprofileBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/> 
<jsp:useBean id="cMgr" scope="session" class="netpidia.CartMgr"/>
<jsp:useBean id="pMgr" class="netpidia.ProductMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
		MemberBean mbean = mMgr.getMember(id);
		MyprofileBean fbean = fmgr.getMyprofile(id); 
		Hashtable<Integer, OrderBean> hCart = cMgr.getCartList();
		int totalPrice = 0;
		
%>
<!DOCTYPE html>
<html lang="en">
	
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Payment Methode</title>
	 <link rel="shortcut icon" href="img/minilogo.png"> 
	 <script src="script.js"></script>
    <!-- Plugins CSS -->
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    
    <!-- Custom style -->
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
    
	</head>
	
	<body>
		
		<!-- ======================= 공통 메뉴부분 ===================== -->
		<nav class="navbar navbar-default navbar-mobile navbar-fixed light bootsnav">
			<div class="container">
				<!-- Start Logo Header Navigation -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
						<i class="fa fa-bars"></i>
					</button>
					<a class="navbar-brand" href="main.jsp">
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
		
		
		<!-- ======================= Start Page Title ===================== -->
		<div class="page-title image-title" style="background-image:url(assets/img/banner.jpg);">
			<div class="container">
				<div class="page-title-wrap">
				<h2>Payment Methode</h2>
				<p><a href="#" class="theme-cl">Home</a> | <span>Payment Methode</span></p>
				</div>
			</div>
		</div>
		<!-- ======================= End Page Title ===================== -->
		
		<!-- =========== Start All Hotel In Grid View =================== -->
		<section class="gray-bg">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="tr-single-box">
							<div class="tr-single-header">
								<h4><i class="ti-gift"></i>Package information</h4>
							</div>
							<%
								Enumeration<Integer> hCartKey = hCart.keys(); 
								while(hCartKey.hasMoreElements()){
									//키값으로 주문객체를 리턴
									OrderBean order = hCart.get(hCartKey.nextElement());
									//상품번호
									int productNo = order.getProductNo();
									//상품 정보
									ProductBean pbean = pMgr.getProduct(productNo);
									//상품이름
									String pName = pbean.getName();
									//상품가격
									int price = pbean.getPrice();
									//주문수량
									int quantity = order.getQuantity();
									//주문가격
									int subTotal = price * quantity;
									//전체주문가격
									totalPrice+=subTotal;
							
							%>	
						
						
						
							<div class="tr-single-body">
								<div class="booking-price-detail side-list no-border">
									<h5>Your Name</h5>
									<ul>
										<li><%=mbean.getName() %></li>
									
									</ul>
								</div>
								<div class="booking-price-detail side-list no-border">
									<h5>Your Email</h5>
									<ul>
										<li><%=mbean.getEmail() %></li>
										
									</ul>
								</div>
								<div class="booking-price-detail side-list no-border">
									<h5>Phone number</h5>
									<ul>
										<li><%=fbean.getPhone()%></li>
								
									</ul>
								</div>
								<div class="booking-price-detail side-list no-border">
									<h5>Your Address</h5>
									<ul>
										<li><%=fbean.getAddress()%></li>
										
									</ul>
								</div>
								<div class="booking-price-detail side-list no-border">
									<h5>Total Pay Amount</h5>
									<ul>
										<li>Total Price<strong class="theme-cl pull-right">$<%=SUtilMgr.monFormat(totalPrice)%></strong></li>
									</ul>
								</div>
							</div>
							<%}//while %>
						</div>
					</div>
					
					<form method="post" action="cartProc.jsp">
					<div class="col-md-6">
						<div class="tr-single-box">
							<div class="tr-single-header">
								<h4><i class="ti-credit-card"></i>Payment Methode</h4>
							</div>
							<div class="tr-single-body">
								<!-- Paypal Option -->
								<div class="payment-card">
									<header class="payment-card-header cursor-pointer" data-toggle="collapse" data-target="#cash" aria-expanded="true">
										<div class="payment-card-title flexbox">
											<h4>Transfer or Cash</h4>
										</div>
										<div class="pull-right">
											<img src="assets/img/paypal.png" class="img-responsive" alt=""> 
										</div>
									</header>
									<div class="collapse" id="cash" aria-expanded="false">
										<div class="payment-card-body">
											<div class="row mrg-bot-20">
												<div class="col-sm-12 bt-1 padd-top-15">
													<a href="orderProc.jsp" class="btn btn-success full-width">Proceed now</a>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<!-- Debit card option -->
								<div class="payment-card">
									<header class="payment-card-header cursor-pointer" data-toggle="collapse" data-target="#debit-credit" aria-expanded="true">
										<div class="payment-card-title flexbox">
											<h4>Credit / Debit Card</h4>
										</div>
										<div class="pull-right">
											<img src="assets/img/credit.png" class="img-responsive" alt=""> 
										</div>
									</header>
									<div class="collapse" id="debit-credit" aria-expanded="false">
										<div class="payment-card-body">
											<div class="row mrg-bot-20">
												<div class="col-sm-12 bt-1 padd-top-15">
													<span class="custom-checkbox d-block font-12">
														<input type="checkbox" id="privacy">
														<label for="privacy"></label>
														By ordering you are agreeing to our <a href="#" class="theme-cl">Privacy policy</a>.
													</span>
													<a href="payProc.jsp?totalPrice=<%=totalPrice%>" class="btn btn-success full-width">Proceed now</a>
												</div>
											</div>
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					<input type="hidden" name="flag" value="aaa">
					</form>
					<a href="productMgr.jsp" class="btn btn-danger ml-1 mt-2 full-width">Back to Shop Page</a>
					
				</div>
				<div class="row">
				</div>
			</div>
		</section>
		<!-- Switcher -->
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
		<!-- /Switcher -->
		 
		<!-- =================== START JAVASCRIPT ================== -->
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