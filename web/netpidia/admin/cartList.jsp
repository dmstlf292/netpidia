<!-- cartList.jsp -->
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.SUtilMgr"%>
<%@page import="netpidia.ProductBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="netpidia.OrderBean"%>
<%@page import="java.util.Hashtable"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" scope="session" class="netpidia.CartMgr"/>
<jsp:useBean id="pMgr" class="netpidia.ProductMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			//현재 접속된 url값
			StringBuffer url = request.getRequestURL();
			response.sendRedirect("login.jsp?url="+url);
			return;//이후에 jsp 코드 실행 안됨.
		}
		
		if(session.getAttribute("idKey")==null){
			response.sendRedirect("login.jsp");
			return;
		}
		Hashtable<Integer, OrderBean> hCart = cMgr.getCartList();
		int totalPrice = 0;
		MyprofileBean fbean = fmgr.getMyprofile(id);
		MemberBean mbean = mMgr.getMember(id);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Netpidia My Cart List</title>
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
		
		<div class="page-title image-title" style="background-image:url(img/bg.jpg);">
			<div class="container">
				<div class="page-title-wrap">
				<h2>Add To cart</h2>
				<p><a href="#" class="theme-cl">Home</a> | <span>Add To cart</span></p>
				</div>
			</div>
		</div>
		<section class="cart gray-bg">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-sm-8">
						<div class="tg-cartproductdetail table-responsive">
							<table class="table" cellspacing="0">
								<thead>
									<tr>
										<th class="product-name">Name</th>
										<th class="product-detail">Detail</th>
										<th class="product-quantity">Quantity</th>
										<th class="product-price">Price</th>
										<th class="product-modify">Modify</th>
										<th class="product-remove">Delete</th>
									</tr>
								</thead>
								<form method="post" action="cartProc.jsp">
								<%if(hCart.isEmpty()){%>
								<tr>
									<td colspan="5" align="center">Empty</td>
								</tr>												
							  <tbody>
							  <%}else{
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
								
								<input type="hidden" name="productNo" value="<%=productNo%>">
									<tr class="cart_item">
										<td>
											<div class="tg-tourname">
												<figure>
													<a href="#"><img src="data/<%=pbean.getImage() %>" class="img-responsive" alt=""></a>
													
												</figure>
												<div class="tg-populartourcontent">
													<div class="tg-populartourtitle">
														<h3>
															<a href="#"><%=pName%></a> / $<%=SUtilMgr.monFormat(subTotal)%>									</h3>
													</div>
													<span>1 x <span class="Price-amount amount"><span class="Price-currencySymbol">$</span><%=SUtilMgr.monFormat(subTotal)%></span>										</span>
												</div>
											</div>
										</td>
										<td>
											<a href="javascript:productDetail('<%=productNo%>')"class="btn btn-danger ml-1 mt-2" >Detail</a>
										</td>
										<td class="product-quantity">
											<div class="form-group">
												<div class="quantity">
													<input type="number" class="form-control" name="quantity" size="3" value="<%=quantity%>">
												</div>
											</div>
										</td>
										<td>
											<span class="Price-amount amount"><span class="Price-currencySymbol">$</span><%=SUtilMgr.monFormat(subTotal)%></span>
										</td>
										
										<td class="product-modify">
											<input type="button" value="Modify" size="3" onclick="javascript:cartUpdate(this.form)" class="btn btn-danger ml-1 mt-2">
										</td>
										<td class="product-delete">
											<input type="button" value="Delete" size="3" onclick="javascript:cartDelete(this.form)" class="btn btn-danger ml-1 mt-2">
										</td>
									</tr>
									<%}//---------------while %>
								</tbody>
								<input type="hidden" name="flag" value="Want to modify?">
							   </form>	
							</table>
						</div>
					</div>
					<div class="col-md-4 col-sm-4">
						<div class="tr-single-box">
							<div class="tr-single-header">
								<h4>Total<span class="fl-right">$<%=SUtilMgr.monFormat(totalPrice)%></span></h4>
							</div>
							<div class="tr-single-body">
								<div class="booking-price-detail side-list no-border">
									<a href="paymentMethod.jsp" class="btn btn-success full-width">Proceed now</a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-sm-4">
						<div class="tr-single-box">
							
							<div class="tr-single-body">
								<div class="booking-price-detail side-list no-border">
									<a href="productMgr.jsp" class="btn btn-danger ml-1 mt-2 full-width">Back to Shop Page</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%}//--------------if-else %>	
			</div>
			
			
		</section>
		<form name="detail" method="post" action="productDetail.jsp" >
			<input type="hidden" name="productNo">
		</form>	
		
		
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