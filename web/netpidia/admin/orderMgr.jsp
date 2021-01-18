<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.util.*, netpidia.*"%>
<jsp:useBean id="orderMgr" class="netpidia.OrderMgr" />
<jsp:useBean id="pMgr" class="netpidia.ProductMgr" />
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
    <title>Order List - Admin</title>
    <script src="script3.js"></script>
    <link rel="shortcut icon" href="img/minilogo.png"> 
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
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
		

		<section class="dashboard gray-bg padd-0 mrg-top-50">
			<div class="container-fluid">
				<div class="row">
					
					
					<div class="col-lg-2 col-md-2 col-sm-3 dashboard-bg">
						<!-- /. NAV TOP  -->
							<nav class="navbar navbar-side">
							<!-- Start Logo Header Navigation -->
							<div class="navbar-header">
								<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#dashboard-menu">
									<i class="fa fa-bars"></i>
								</button>

							</div>
							<div class="collapse sidebar-collapse" id="dashboard-menu">
								<div class="profile-wrapper">
									<div class="profile-wrapper-thumb">
										<img src="data/<%=fbean.getImage() %>" class="img-responsive img-circle" alt="" />
										<span class="dashboard-user-status bg-success"></span>
									</div>
									<h4><%=id%></h4>
								</div>
								<ul class="nav" id="main-menu">
									<li>
										<a href="memberUpdate.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>Member Update</a>
									</li>
									<li>
										<a href="memberDelete.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>Membership Withdrawal</a>
									</li>
									<li>
										<a href="blogPost.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>My Blog </a>
									</li>
									<li>
										<a href="cartList.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>My Cart List </a>
									</li>
									<li>
										<a href="orderList.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>My Order List </a>
									</li>
									<%if(fbean.getAboutme()==null){ %>
									<li>
										<a href="myprofileInsert.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>My Profile Insert</a>
									</li>
									<%}else{%>
									<li>
										<a href="myprofileUpdate.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>My Profile Update</a>
									</li>
									<%}%>
									<%if(mbean.getGrade().equals("1")){ %>
									<li>
										<a href="myprofileMgr.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>Client Profile Adm & List</a>
									</li>
									<li>
										<a href="orderMgr.jsp"><i class="fa fa-dashboard" aria-hidden="true"></i>Order Manager </a>
									</li>
									<%}%>
								</ul>
							</div>
						</nav>
						<!-- /. NAV SIDE  -->
					</div>
					
					
					
					
					<div class="col-lg-10 col-md-10 col-sm-9 col-lg-push-2 col-md-push-2 col-sm-push-3">
						<div class="row mrg-0 mrg-top-20">
							<div class="tr-single-box">
								<div class="tr-single-header">
									<h3 class="dashboard-title">View Invoice</h3>
								</div>
								<div class="tr-single-body">	
									<div class="detail-wrapper padd-top-30 padd-bot-30">	
										<div class="row mrg-0">
											<div class="col-md-6">
												<div id="logo"><img src="img/logo.png" class="img-responsive" alt=""></div>
											</div>	
										</div>
										<div class="row  mrg-0 detail-invoice">
											<div class="col-md-12">
												<h2>INVOICE</h2>
											</div>
											<hr />
											<div class="col-12 col-md-12">
												<strong>ITEM DESCRIPTION & DETAILS :</strong>
											</div>
											<hr>
											<div class="col-lg-12 col-md-12 col-sm-12">
												<div class="invoice-table">
													<div class="table-responsive">
														<table class="table table-striped table-bordered">
															<thead>
																<tr>
																	<th>P. No.</th>
																	<th>Custom Name</th>
																	<th>Product</th>
																	<th>Quantity</th>
																	<th>Order Date</th>
																	<th>Order State</th>
																	<th>Detail</th>
																</tr>
															</thead>
															<%
																	Vector<OrderBean> vlist = orderMgr.getOrderList();
																	if(vlist.isEmpty()){
															%>
															<tbody>
																	<td colspan="7" align="center">Empty.</td>
															</tbody>
															<%}else{
																	for(int i=0;i<vlist.size();i++){
																		OrderBean order/*주문 정보*/ = vlist.get(i);
																		 ProductBean product/*제품정보*/ = pMgr.getProduct(order.getProductNo());
															%>
															<tbody>
																 <tr>
																	<td><%=order.getProductNo()%></td>
																	<td><%=order.getId()%></td>
																	<td><%=product.getName()%></td>
																	<td><%=order.getQuantity()%></td>
																	<td><%=order.getDate()%></td>
																	<td>
																		<%
																			switch(order.getState()){
																				case "1" : out.println("Accepting");break;
																				case "2" : out.println("Receipt");break;
																				case "3" : out.println("Confirmation of payment");break;
																				case "4" : out.println("Preparation for delivery");break;
																				case "5" : out.println("S hipping");break;
																				default : out.println("Complete");
																			}
																		%>
																		</td>
																		<td><a href="javascript:orderDetail('<%=order.getProductNo()%>')">Detail</a></td>
																	</tr>			
																	<%	
																				}//---for
																			}//---if
																	%>
															</tbody>
														</table>
													</div>
													<hr>
													<!-- <div>
														<h4>Bill Amount :  USD </h4>
													</div>  -->
												</div>
												<form name="detail" method="post" action="orderDetail.jsp" >
													<input type="hidden" name="productNo">
													<input type="hidden" name="image">
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
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