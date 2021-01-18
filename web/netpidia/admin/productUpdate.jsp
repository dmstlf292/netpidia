<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="java.util.*,netpidia.*"%>
<jsp:useBean id="pMgr" class="netpidia.ProductMgr" />
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
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
    <title>Product Modify - Admin</title>
    <script src="script3.js"></script>
    <link rel="shortcut icon" href="img/minilogo.png"> 
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
	</head>
	<body>
	<%
		int productNo = Integer.parseInt(request.getParameter("productNo"));
		ProductBean product = pMgr.getProduct(productNo);
	%>


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
		<section class="page-title-banner" style="background-image:url(img/bg.jpg);">
			<div class="container">
				<div class="row">
					<div class="tr-list-detail">
						<div class="tr-list-thumb">
						
							<img src="img/minilogo.png" class="img-responsive img-circle" alt="" />
						</div>
						<div class="tr-list-info">
							<h4>Netpidia - Product Modify</h4>
							<p>Minishop </p>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="profile-header-nav padd-0 bb-1">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-sm-8">
						<div class="tab" role="tabpanel">
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#Overview" aria-controls="home" role="tab" data-toggle="tab"><i class="ti-user"></i>Overview - Product Update</a></li>
							
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="tr-single-detail gray-bg">
			<div class="container">
			
			
			  	<form method="post" action="productProc.jsp?flag=update" enctype="multipart/form-data">
				<div class="row">
					<div class="col-md-8 col-sm-12">
						<div class="tab-content tabs">	
							<div role="tabpanel" class="tab-pane fade in active" id="Overview">
								<div class="row">
									<div class="tr-single-box">
										<div class="tr-single-header">
											<h4><i class="fa fa-star-o"></i>Overview - Product Modify</h4>
										</div>
										<div class="tr-single-body">
											<div class="row">
												<div class="col-md-6 col-sm-6">
												
													<div class="preview">
														<div class="upload">
															<div class="post_btn">
																<div class="plus_icon"></div>
																<h5>Post Product Image</h5>
																<canvas id="imageCanvas"></canvas>
															</div>
														</div>
													</div>
													<p>
											 			<input type="file" name="image" id="id_image" class="btn btn-danger ml-1 mt-2 full-width">
													</p>
													<script>
														var fileInput = document.querySelector("#id_image"), button = document
																.querySelector(".input-file-trigger"), the_return = document
																.querySelector(".file-return");
														// Show image
														fileInput.addEventListener('change', handleImage, false);
														var canvas = document.getElementById('imageCanvas');
														var ctx = canvas.getContext('2d');
												
														function handleImage(e) {
															var reader = new FileReader();
															reader.onload = function(event) {
																var img = new Image();
																img.onload = function() {
																	canvas.width = 300;
																	canvas.height = 300;
																	ctx.drawImage(img, 0, 0, 300, 300);
																};
																img.src = event.target.result;
															};
															reader.readAsDataURL(e.target.files[0]);
														}
													</script>
												</div> 
												<!-- href="img/minilogo.png" -->
												<div class="col-md-6 col-sm-6">
													<div class="listing-features">
														<div class="listing-features-box">
															<div class="listing-features-thumb">
																<img src="img/minilogo.png" class="img-responsive" alt="" />
															</div>
															<div class="listing-features-detail">
																<h4>Name :  <input name="name" value="<%=product.getName()%>" class="form-control"></h4>
															</div>
														</div>
													</div>
												</div>
												<div class="col-md-6 col-sm-6">
													<div class="listing-features">
														<div class="listing-features-box">
															<div class="listing-features-thumb">
																<img src="img/minilogo.png" class="img-responsive" alt="" />
															</div>
															<div class="listing-features-detail">
																<h4>Price : $<input name="price" size="20" value="<%=product.getPrice()%>" class="form-control"></h4>
																
															</div>
														</div>
													</div>
												</div>
												<div class="col-md-6 col-sm-6">
													<div class="listing-features">
														<div class="listing-features-box">
															<div class="listing-features-thumb">
																<img src="img/minilogo.png" class="img-responsive" alt="" />
															</div>
															<div class="listing-features-detail">
															
																<h4>Goods received quantity : <input name="stock" size="5" value="<%=product.getStock()%>" class="form-control"></h4>
																
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>	
										<div class="tr-single-header">
											<h4><i class="ti-files"></i>Description</h4>
										</div>
										<div class="tr-single-body">
											<textarea rows="10" cols="95" name="detail"><%=product.getDetail()%></textarea>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-sm-12">
						<div class="tr-single-box">
							<div class="tr-single-body">
								<form class="book-form"  method="post" action="productProc.jsp?flag=update" enctype="multipart/form-data">
									<div class="row">
										<div class="col-xs-12 mrg-top-15">
											<input type="submit" value="Modify" class="btn btn-danger ml-1 mt-2 full-width"> 
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12 mrg-top-15">
											<input type="reset" value="Reset" class="btn btn-danger ml-1 mt-2 full-width">	
										</div>
									</div>
								  <input type=hidden name="productNo" value="<%=product.getProductNo()%>">
								</form>
							</div>
						</div>
					</div>
				</div>
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
		<script src="http://maps.google.com/maps/api/js?key="></script>
		<script src="assets/plugins/js/markerclusterer.js"></script>
		<script src="assets/js/map.js"></script>
		<script src="assets/plugins/js/jquery.slimscroll.min.js"></script>
		<script src="assets/plugins/js/jquery.metisMenu.js"></script>
		<script src="assets/plugins/js/jquery.easing.min.js"></script>	
		<script src="assets/js/custom.js"></script>
		<script>
			$('#checkin').daterangepicker({
				"singleDatePicker": true,
				"timePicker": true,
				"startDate": "12/12/2018",
				"endDate": "12/14/2018"
			}, function(start, end, label) {
			  console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
			});
		</script>
		
		<script>
			$('#checkout').daterangepicker({
				"singleDatePicker": true,
				"timePicker": true,
				"startDate": "12/18/2018",
				"endDate": "12/18/2018"
			}, function(start, end, label) {
			  console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
			});
		</script>

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