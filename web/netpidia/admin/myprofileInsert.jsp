<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MyprofileMgr"%>
<%@page import="netpidia.MemberBean"%>
<%@page pageEncoding="EUC-KR"%>
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

    <title>My Profile Insert</title>
	<link rel="shortcut icon" href="img/minilogo.png">

	<script type="text/javascript">

	function zipSearch() {
		url = "zipSearch.jsp?search=n";
		window.open(url,"Search",
				"width=500,height=350,scrollbars=yes");
	}
	


	</script>


    <!-- Plugins CSS -->
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    
    <!-- Custom style -->
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
    
	</head>
	
	<body>
		
		<!-- ======================= Start Navigation ===================== -->
		<nav class="navbar navbar-default navbar-mobile navbar-fixed light bootsnav">
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

		<!-- ======================= Start Checkout ===================== -->
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
										<img src="img/minilogo.png" class="img-responsive img-circle" alt="" />
										
									</div>
									<h4><%=mbean.getName()%></h4>
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
									<%if(mbean.getGrade()=="1"){%>
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
							</div>
						</nav>
						<!-- /. NAV SIDE  -->
					</div>
					
					
					
					
					
					<form method="post" name="regFrm"  action="myprofileProc.jsp?flag=insert" enctype="multipart/form-data">
					<div class="col-lg-10 col-md-10 col-sm-9 col-lg-push-2 col-md-push-2 col-sm-push-3">
						<div class="row mrg-0 mrg-top-20">
							<div class="tr-single-box">
								<div class="tr-single-header">
									<h3 class="dashboard-title">My Profile Insert</h3>
								</div>
								<div class="tr-single-body">
									<div class="row">
										<div class="col-md-4">
										 <p>
												<label>Id</label>
												<input type="text" id="firstname" class="form-control" name="id" value="<%=id%>">
											</p>
											 <p>
												<label>My Name</label>
												<input type="text" id="firstname" class="form-control"  name="name" value="<%=mbean.getName()%>">
											</p> 
											<p>
												Zipcode : <input type="button" value="Search" onClick="zipSearch()" class="btn btn-danger ml-1 mt-2" required></br>
												<input  class="form-control"  size="5"  name="zipcode" readonly>
											</p>
											<p>
												<label>Address</label>
												<input type="text" class="form-control" name="address" size="45" required>
											</p>	 	
											<p>
												<label>About Me</label>
												<textarea id="about_me" class="form-control" placeholder="Enter..." name="aboutme" required></textarea>
											</p>
										</div>
										<div class="col-md-4">
											<p>
												<label>Phone</label>
												<input type="text" id="userphone" class="form-control" placeholder="Enter..." name="phone" required>
											</p>   
											<p>
											<label>I live in</label>
											   <input type="text"  class="form-control" placeholder="Enter..." name="live" >
											</p>
											
											<p>
												<label>I speak</label>
												<input type="text"  class="form-control" placeholder="Enter..." name="speak" >
											</p>
											<p>
												<label>Facebook Url</label>
												<input type="text"  class="form-control" placeholder="Enter..." name="fhp">
											</p>

											 <p>
												<label>Instagram Url</label>
												<input type="text"  class="form-control" placeholder="Enter..." name="ihp">
											</p>		
										</div>		
										<div class="col-md-4">
											<div id="profile-div" class="feature-media-upload">
												
												<div class="preview">
													<div class="upload">
														<div class="post_btn">
															<div class="plus_icon"></div>
															<h5>Post your profile image</h5>
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
												
												</br>
												<div>
												<input type="submit" value="Submit" class="btn btn-danger ml-1 mt-2 full-width">
												</div>
												</br>
												<input type="reset" value="reset" class="btn btn-danger ml-1 mt-2 full-width">
											</div>
										</div> 				
									</div>
								</div>
							</div>
						</div>
					</div>
					</form>	
				</div>
			</div>
		</section>


		 
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
