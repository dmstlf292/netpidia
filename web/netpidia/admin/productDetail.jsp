<%@page import="java.net.URLEncoder"%>
<%@page import="netpidia.EvaluationDAO"%>
<%@page import="netpidia.EvaluationDTO"%>
<%@page import="netpidia.EvaluationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="netpidia.OrderBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.MyprofileBean"%>
<%@page import="java.util.Vector"%>
<%@page import="netpidia.ProductBean"%>
<%@page import="netpidia.SUtilMgr"%>
<%@page import="netpidia.ShopCommentBean"%>
<%@page import="netpidia.ShopGuestBookBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pMgr" class="netpidia.ProductMgr"/>
<jsp:useBean id="smgr" class="netpidia.ShopGuestBookMgr"/>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<jsp:useBean id="cMgr" class="netpidia.CartMgr"/>
<jsp:useBean id="orderMgr" class="netpidia.OrderMgr" />
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>

<%
		request.setCharacterEncoding("EUC-KR");
		int productNo = SUtilMgr.parseInt(request, "productNo");
		ProductBean pbean = pMgr.getProduct(productNo); 
		
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			//현재 접속된 url값
			StringBuffer url = request.getRequestURL();
			response.sendRedirect("login.jsp?url="+url);
			return;//이후에 jsp 코드 실행 안됨.
		}
		
		MemberBean mbean = mMgr.getMember(id);//여기만 bBean으로 했음(원래 bean으로 했는데 방명록 계속 오류생길까봐..)
		MyprofileBean fbean = fmgr.getMyprofile(id);
		OrderBean order = orderMgr.getOrderDetail(productNo);
		
		

%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail - Admin</title>
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="script3.js"></script>
    
     <script type="text/javascript">
	     $( "#test" ).load(function() {
	         
	     });
	     
	     $( window ).load(function() {
	    	 
	     });

	     $( document ).ready(function() {
	         
	     });


	     $( ".star_rating a" ).click(function() {
	         $(this).parent().children("a").removeClass("on");
	         $(this).addClass("on").prevAll("a").addClass("on");
	         return false;
	    });

		function updateFn(num) {//기능 : 대댓글 수정창
			url = "updateShopGuestBook.jsp?num="+num;
			window.open(url,"GuestBook Update","width=520,height=150");
		}
		function commentFn(frm) { //this.form 
			if(frm.comment.value==""){
				alert("내용을 입력하세요.");
				frm.comment.focus();
				return;
			}
			frm.submit();
		}

		function addCartFn() {
			quantity = document.getElementById("quantity");
			document.cartadd.quantity.value = quantity.value;
			document.cartadd.submit();
		}
	</script>
    <link rel="shortcut icon" href="img/minilogo.png"> 
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
	</head>
	<body>
	<%
		
			request.setCharacterEncoding("UTF-8");
			String title = "total";
			String searchType = "recently";
			String search="";
			int pageNumber = 0;
			if(request.getParameter("title")!=null){
				title = request.getParameter("title");
			}if(request.getParameter("searchType")!=null){
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
							<!-- -----------------------상품이미지!!! ------------------>
							<img src="img/minilogo.png" class="img-responsive img-circle" alt="" />
						</div>
						<div class="tr-list-info">
							<h4>Netpidia - Admin</h4>
							<p>Minishop </p>
						</div>
					</div>
				</div>
			</div>
		</section>
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
		<section class="profile-header-nav padd-0 bb-1">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-sm-8">
						<div class="tab" role="tabpanel">
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#Overview" aria-controls="home" role="tab" data-toggle="tab"><i class="ti-gallery"></i>Overview</a></li>
								<li role="presentation"><a href="#Review" aria-controls="messages" role="tab" data-toggle="tab"><i class="ti-thumb-up"></i>Review</a></li>
								<li role="presentation"><a href="#Photos" aria-controls="messages" role="tab" data-toggle="tab"><i class="ti-user"></i>Evaluation</a></li>
							</ul>
						</div>
					</div>
					<div class="col-md-4 col-sm-4">
						<div class="fl-right">
							<button type="submit" class="btn btn-danger ml-1 mt-2" data-toggle="modal" data-target="#messages" align="right"><span class="fa fa-paper-plane mrg-r-10"></span>Send Messages</button>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="tr-single-detail gray-bg">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-sm-12">
						<div class="tab-content tabs">	
							<div role="tabpanel" class="tab-pane fade in active" id="Overview">
								<div class="row">
									<div class="tr-single-box">
										<div class="tr-single-header">
											<h4><i class="fa fa-star-o"></i>Overview</h4>
										</div>
										<div class="tr-single-body">
											<div class="row">
											
												<div class="col-md-6 col-sm-6">
													<div class="list-thumb-box">
														<img src="data/<%=pbean.getImage() %>" class="img-responsive" alt="" />
														<a href="#" class="list-like left"><i class="ti-heart"></i></a>
														<!-- <h5>4.8/<sub class="theme-cl">5</sub></h5> -->
													</div>
												</div>
												<!-- href="img/minilogo.png" -->
												<div class="col-md-6 col-sm-6">
													<div class="listing-features">
														<div class="listing-features-box">
															<div class="listing-features-thumb">
																<img src="img/minilogo.png" class="img-responsive" alt="" />
															</div>
															<div class="listing-features-detail">
																<h4>Name : <%=pbean.getName()%> </h4>
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
																<h4>Price :  <%=SUtilMgr.monFormat(pbean.getPrice()) %></h4>
																
															</div>
														</div>
													</div>
												</div>
												<div class="col-md-6 col-sm-6">
													<input id="quantity" value="1" size="5" class="form-control" >
												</div>
											</div>
										</div>	
										<div class="tr-single-header">
											<h4><i class="ti-files"></i>Description</h4>
										</div>
										<div class="tr-single-body">
											<p><%=pbean.getDetail() %></p>
										</div>
									</div>
								</div>
							</div>
							 <div role="tabpanel" class="tab-pane fade in" id="Review">
								<div class="row">
									<div class="tr-single-box">
										 <div class="tr-single-header">
											<h4><i class="ti-write"></i>All Review</h4>
										</div>
										 <jsp:include page="shopPostGuestBook.jsp"/>
										 
										 <%
										 	Vector<ShopGuestBookBean> vlist = smgr.listShopGuestBook(id, login.getGrade());
										 	//out.print(vlist.size());
										 	if(vlist.isEmpty()){
										 %>
										 <div class="tr-single-body" >
											<div class="review-box">
												<div class="review-thumb">
													<img src="img/minilogo.png" class="img-responsive img-circle" alt="" />
												</div>
												<div class="review-box-content">
													<div class="review-user-info">
														<td>등록된 글이 없습니다.</td>
													</div>
												</div>
											</div>	
										</div>
										<%}else {
													for(int i=0; i<vlist.size();i++){
													ShopGuestBookBean bean = vlist.get(i);
													MemberBean writer = smgr.getMember(bean.getId());
										
										%>
										<div class="tr-single-body" >
											<div class="review-box">
												<div class="review-thumb">
								<!----------------------------------메인 댓글---------------------------------------->
													<img src="data/<%=fbean.getImage() %>" class="img-responsive img-circle" alt="" />
												</div>
												<div class="review-box-content">
													
													<div class="review-user-info">
														<h4><%=writer.getName() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<%=bean.getRegdate()+" "+bean.getRegtime()%></h4>
														<p><%=bean.getContents() %></p>
													</div>
													<%
															boolean chk = login.getId().equals(writer.getId());
															if(chk||login.getGrade().equals("1")){
																if(chk){
															%>
																<a class="btn btn-danger ml-1 mt-2"  href="javascript:updateFn('<%=bean.getNum()%>')">Modify</a>
															<%}//---if2%>
																<a class="btn btn-danger ml-1 mt-2"  href="deleteShopGuestBook.jsp?num=<%=bean.getNum()%>">Delete</a>
															<%if(bean.getSecret().equals("1")){%>	
															비밀글
															<%
																}//---if3
															}//---if1
													%>
												</div>
											</div>	
											<!-- Comment List Start -->	
											 <div class="tr-single-body" id="cmt<%=bean.getNum() %>">
											 <%
											 	Vector<ShopCommentBean> cvlist = smgr.shopListComment(bean.getNum());
											 	if(!cvlist.isEmpty()){
											 %>
													 <div class="review-box">
													 <div class="review-thumb">
						<!-- ------------------------댓글의 댓글-------------------------------- -->
														<img src="data/<%=fbean.getImage() %>" class="img-responsive img-circle" alt="" />
													</div>
											<%
												for(int j=0; j<cvlist.size(); j++){
													ShopCommentBean cbean = cvlist.get(j);
											%>		
													<div class="review-box-content">
													
														<div class="review-user-info">
															<h4><%=cbean.getCid()%> &nbsp;&nbsp;&nbsp; leaved one comment
															<p><%=cbean.getComment() %></p>
															<h4><%if(login.getId().equals(cbean.getCid())){ %><%}%></h4>
															<a href="shopCommentProc.jsp?flag=delete&productNo=<%=cbean.getProductNo()%>" class="btn btn-danger ml-1 mt-2" >
															Delete</a>
															
														</div>
														<div class="review-lc text-right">
															<a href="#"><%=cbean.getCip()%></a>
															<a href="#"><%=cbean.getCregDate()%></a>
														</div>
													</div>
												<%}//--for(comment)%>
												</div>
										<%}//--if(comment)%>
											</div> 
											<!-- Comment List End -->
											<!-- Comment Form Start -->	
											<table width="500">
												<tr><td>
												<h4>+ Reply(<%=cvlist.size()>0?cvlist.size():"" %>)</h4>
												</td></tr>
											</table>
											<!-- Comment Form Start -->	
											<form name="cFrm" method="post" action="shopCommentProc.jsp">
											<table>
												<tr>
												<div class="review-thumb">
								<!----------------------------------메인 댓글---------------------------------------->
													<img src="data/<%=fbean.getImage() %>" class="img-responsive img-circle" alt="" />
												</div>
													<div>
														<h4>Leave your comment too!</h4>
														<textarea placeholder="Enter..." name="comment" rows="2" 
														cols="65" maxlength="1000"></textarea>
													</div>
													<div align = "right">
														<input type="button" value="OK" onclick="commentFn(this.form)" class="btn btn-danger ml-1 mt-2">
													</div>
													<div>
														<input type="hidden" name="flag" value="insert">
														<input type="hidden" name="num" value="<%=bean.getNum()%>">
														<input type="hidden" name="cid" value="<%=login.getId()%>">
														<input type="hidden" name="cip" value="<%=request.getRemoteAddr()%>">
														<!-- 여길 추가해야지 대댓글 입력후 no값 받아서 넘기고 에러없이 원페이지로 돌아온다!! -->
														<input type="hidden" name="productNo" value="<%=pbean.getProductNo()%>">
													</div>
												</tr>
											</table>	
											</form>
											<!-- Comment  Form End -->	
										</div>
											<%} %>
										 <%} %>
									</div>
								</div>
							</div>  
								<!-- 게시글 등록 모달팝업창 -->
							<div class="modal fade" id="eva" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content" id="myModalLabel1">
									  <form method="post" action="evaluationRegisterAction.jsp">
										<div class="modal-body">
											<div class="text-center"></div>
											<div class="tab-content">
												<div class="tab-pane fade in show active" id="eva" role="tabpanel">
													 <form method="get" action="productDetail.jsp" class="form-inline mt-3">
													 	<div class="form-group">
															<h5>Leave your evaluation of our products!</h5>
															 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
												              <span aria-hidden="true">&times;</span>
												            </button>
														</div>
														</br>
														<div class="form-group">
															<label>Total Score</label>
															<select name="totalScore" class="form-control">
										            			<option value="A" selected>A</option>
										            			<option value="B" >B</option>
										            			<option value="C" >C</option>
										            			<option value="D" >D</option>
										            			<option value="E" >E</option>
										            		</select>
														</div>
														<div class="form-group">
															<label>Rate</label>
															<select name="totalRate" class="form-control">
										            			<option value="1" selected>1</option>
										            			<option value="2" >2</option>
										            			<option value="3" >3</option>
										            			<option value="4" >4</option>
										            			<option value="5" >5</option>
										            			<option value="6" >6</option>
										            			<option value="7" >7</option>
										            			<option value="8" >8</option>
										            			<option value="9" >9</option>
										            			<option value="10" >10</option>
										            		</select>
														</div>
														<div class="form-group">
															<label>Month</label>
															<select name="month" class="form-control">
										            			<option value="1" selected>1</option>
										            			<option value="2" >2</option>
										            			<option value="3" >3</option>
										            			<option value="4" >4</option>
										            			<option value="5" >5</option>
										            			<option value="6" >6</option>
										            			<option value="7" >7</option>
										            			<option value="8" >8</option>
										            			<option value="9" >9</option>
										            			<option value="10" >10</option>
										            			<option value="11" >11</option>
										            			<option value="12" >12</option>
										            		</select>
														</div>
														<div class="form-group">
															<label>Title</label>
															<input type="text" name="title" class="form-control" placeholder="Enter title...">
														</div>
														<div class="form-group">
															<label>Content</label>
															 <textarea  name="content" class="form-control" mexlength="2048" style="height : 140px;"placeholder="Enter content..."></textarea>
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
							
							<!-- -후기 게시판 리뷰 & 사진 올리는 공간 -->
							 <div role="tabpanel" class="tab-pane fade in" id="Photos">
								<div class="row">
									<div class="tr-single-box">
										<div class="tr-single-header">
											<h4><i class="ti-user"></i>All Evaluation of Service </h4>
										</div>
										<div class="tr-single-header" align = "left">
										
										
											<form method="get" action="productDetail.jsp?productNo=<%=title%>" class="form-inline mt-3">
											  	  <select name="title" class="form-control mx-1 mt-2">
											  		<option value="total">total</option>
											  		<option value="totalScore" <%if(title.equals("totalScore")) out.println("selected");%>>Total Score</option>
											  		<option value="totalRate" <%if(title.equals("totalRate")) out.println("selected");%>>Total Rate</option>
											  	  </select>
											  	  <select name="searchType" class="form-control mx-1 mt-2">
											  	  	<option value="recently">recently</option>
											  	  	<option value="like" <%if(searchType.equals("like")) out.println("selected");%>>like</option>
											  	  </select>
											  	  <input type="text" name="search" class="form-control mx-1 mt-2" value="<%= search %>" placeholder="Enter...">
											  	  <button type="submit" class="btn btn-danger ml-1 mt-2">Search</button>
											  	 
											  </form>
											  
										</div>
										<div class="tr-single-header" align = "right">
											<button type="submit" class="btn btn-danger ml-1 mt-2" data-toggle="modal" data-target="#eva" align="right">Post</button>	
										</div>
										</br>
										<div class="container">
											  <div class="row">
												<div class="col-sm-8">
												 <%
														ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
							
														evaluationList = new EvaluationDAO().getList(title, searchType, search, pageNumber);
							
														if(evaluationList != null)
							
														for(int i = 0; i < evaluationList.size(); i++) {
							
															if(i == 5) break;
							
															EvaluationDTO evaluation = evaluationList.get(i);
												%>
													<div class="blog-box blog-grid-box">
														
														 <div class="blog-grid-box-content">
															<div class="col-3 text-left">
																<h4>From <%=evaluation.getId() %></h4>
															</div>
															<h5>Total score <span style="color: red;"><%=evaluation.getTotalScore() %></span>
																&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
															    Total rate <span style="color: red;"><%=evaluation.getTotalRate() %></span>
															    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
															    Month <span style="color: red;"><%=evaluation.getMonth() %></span></h5>
															</br>
															<div class="col-3 text-left">
																<p><strong>Title : <%=evaluation.getTitle() %></strong></p>
															</div>
															<p>Content : <%=evaluation.getContent() %></p>
															<div class="col-3 text-left">
																<h4><span  style="color:red;">Like: <%=evaluation.getLikeCount() %></span></h4>
															</div>
															<div class="col-3 text-right">
																<a onclick="return confirm('Like?')" href="likeAction.jsp?productNo=<%=evaluation.getProductNo() %>"><i class="ti-thumb-up"></i>&nbsp;like</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                  
																<a onclick="return confirm('Delete?')" href="deleteAction.jsp?productNo=<%=evaluation.getProductNo()%>">delete</a>
															</div>
														</div> 
													</div>
													<%} %>
												</div> 
												
											</div> 	
										 </div>	
									</div>
								</div>
								<ul class="pagination justify-content-center mt-3">
     								 <li class="page-item">
									<%
										if(pageNumber <= 0) {
									%>     
									        <a class="page-link disabled"><</a>
									<%
										} else {
									%>
											<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(title, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a>
									<%
										}
									%>
									 </li>
									 <li class="page-item">
									<%
										if(evaluationList.size() < 6) {
									%>     
									        <a class="page-link disabled">></a>
									<%
										} else {
									%>
											<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(title, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>
									<%
										}
									%>
									  </li>
								 </ul>
								
								
							</div> 
						</div>
					</div>
					<div class="col-md-4 col-sm-12">
						<div class="tr-single-box">
							<div class="tr-single-header">
								<div class="entry-meta">
									<div class="meta-item meta-comment fl-right">
										<div class="view-box">
											<div class="fl-right">
												<h4 class="font-20"><span class="theme-cl font-20">$</span><%=SUtilMgr.monFormat(pbean.getPrice()) %></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tr-single-body">
								<form name="cartadd"  action="cartProc.jsp" method="post" name="cartadd">	
									<div class="row">
										<div class="col-xs-12 mrg-top-15">
											<a href="#" class="btn btn-danger ml-1 mt-2 full-width" >Pay Now</a>		
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12 mrg-top-15">
										    <input type="button" onclick="addCartFn()" value="Cart Add" class="btn btn-danger ml-1 mt-2 full-width" >	
										    <input type="hidden" name="productNo" value="<%=pbean.getProductNo()%>">
										    <input type="hidden" name="quantity">	
											<input type="hidden" name="flag" value="insert">
										</div>	
									</div>
								</form>
							</div>
							<div class="tr-single-body">
								<form class="book-form">	
									<div class="row">
										<div class="col-xs-12 mrg-top-15">
											<a href="javascript:productUpdate('<%=pbean.getProductNo()%>')"  class="btn btn-danger ml-1 mt-2 full-width" >Modify</a>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12 mrg-top-15">
											<a href="javascript:productDelete('<%=pbean.getProductNo()%>')" class="btn btn-danger ml-1 mt-2 full-width" >Delete</a>		
										</div>
									</div>
								</form>
							</div>	
						</div>
						<div class="tr-single-box">
							<div class="tr-single-header">
								<h4>Star rate</h4>
							</div>
							<div class="tr-single-body">
								<ul class="extra-service half">
									<li>
										<div class="icon-box-icon-block">
											<div class="form-group">
												<p class="star_rating">
													<a href="#" class="on">★</a>
													<a href="#" class="on">★</a>
													<a href="#" class="on">★</a>
													<a href="#">★</a>
													<a href="#">★</a>
												</p>
											</div>
										</div>
									</li>		
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>		
		</div>
	</div>
</section>

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

		<script src="assets/plugins/js/markerclusterer.js"></script>

		<script src="assets/plugins/js/jquery.slimscroll.min.js"></script>
		<script src="assets/plugins/js/jquery.metisMenu.js"></script>
		<script src="assets/plugins/js/jquery.easing.min.js"></script>	
		
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
		
		
		
		
		<!-- update form -->
		<form name="update" method="post" action="productUpdate.jsp">
			<input type=hidden name=productNo>
		</form>
		
		<!-- delete form 끝 -->
		<form name="del" method="post" action="productProc.jsp?flag=delete">
			<input type=hidden name=productNo>
		</form>
		
    </body>
</html>