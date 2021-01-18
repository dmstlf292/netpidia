<%@page import="java.util.Vector"%>
<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.MovieBean"%>
<%@page import="netpidia.MovieCommentBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<jsp:useBean id="mgr" class="netpidia.MovieMgr"/>
<jsp:useBean id="cmgr" class="netpidia.MovieCommentMgr"/>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/> 
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		MemberBean mbean = mMgr.getMember(id);
		MyprofileBean fbean = fmgr.getMyprofile(id);
        String nowPage = request.getParameter("nowPage");	
		String numPerPage = request.getParameter("numPerPage");	
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");	
		int num = UtilMgr.parseInt(request, "num");	
		
		
		//댓글입력시 flag값 insert값으로 넘어간다.
		String flag = request.getParameter("flag");
		if(flag!=null){
			if(flag.equals("insert")){
				MovieCommentBean cbean = new MovieCommentBean();
				cbean.setNum(num);
				cbean.setId(request.getParameter("id"));
				cbean.setOpinion(request.getParameter("opinion"));
				cbean.setComment(request.getParameter("comment"));
				cbean.setRegdate(request.getParameter("regdate"));
				cmgr.insertComment(cbean);
			}else if(flag.equals("del")){//"delete 말고" "del" 해야지 댓글 삭제가 된다
				//댓글 삭제 기능, 정수로 바꿔야한다.
				cmgr.deleteComment(UtilMgr.parseInt(request, "cnum"));
			}
		}else{
			//조회수 증가
			mgr.upCount(num);
		}
		//조회수 증가
		mgr.upCount(num);
		//게시물 읽기
		MovieBean bean = mgr.getMovie(num);
		String name = bean.getName();
		String title = bean.getTitle();
		String story = bean.getStory();
		String nation = bean.getNation();
		String genre = bean.getGenre();
		String grade = bean.getGrade();
		String direc = bean.getDirec();
		String actor = bean.getActor();
		String regdate = bean.getRegdate();
		String rdate = bean.getRdate();
		String runtime = bean.getRuntime();
		String poster = bean.getPoster();
		int pos = bean.getPos();
		int ref = bean.getRef();
		int depth = bean.getDepth();
		int viewCount = bean.getViewCount();
		int likeCount = bean.getLikeCount();
	
		//총 합구하기
		
		//총평균 구하기
		
		
		
		session.setAttribute("bean", bean);		
%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<!-- Basic need -->
	<title>Open Pediatrics</title>
	<link rel="shortcut icon" href="img/minilogo.png"> 
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="author" content="">
	<link rel="profile" href="#">
    <link rel="stylesheet" href='http://fonts.googleapis.com/css?family=Dosis:400,700,500|Nunito:300,400,600' />
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="format-detection" content="telephone-no">
	<link rel="stylesheet" href="css/plugins.css">
	<link rel="stylesheet" href="css/style.css">
	<script type="text/javascript">
		function down(filename) {
			document.downFrm.filename.value=filename;
			document.downFrm.submit();
		}
		function list() {
			document.listFrm.action = "movieList.jsp";
			document.listFrm.submit();
		}
		function cInsert() {
			if(document.cFrm.comment.value==""){
				alert("Enter your comment.");
				document.cFrm.comment.focus();
				return;
			}
			document.cFrm.submit();
		}
		function cDel(cnum) {
			document.cFrm.cnum.value=cnum;
			document.cFrm.flag.value="del";
			document.cFrm.submit();
		}
</script>
</head>
<body>
<div id="preloader">
    <img class="logo" src="img/minilogo.png" alt="" width="119" height="58">
    <div id="status">
        <span></span>
        <span></span>
    </div>
</div>
<header class="ht-header">
	<div class="container">
		<nav class="navbar navbar-default navbar-custom">
				<div class="navbar-header logo">
				    <div class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					    <span class="sr-only">Toggle navigation</span>
					    <div id="nav-icon1">
							<span></span>
							<span></span>
							<span></span>
						</div>
				    </div>
				    <a href="index.jsp"><img class="logo" src="img/logo.png" alt="" width="119" height="58"></a>
			    </div>
				<div class="collapse navbar-collapse flex-parent" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav flex-child-menu menu-left">
						<li class="hidden">
							<a href="index.jsp"></a>
						</li>
						<li class="dropdown first">
							<a  href="index.jsp" >Home </a>
						</li>
						<li class="dropdown first">
							<a  href="movieList.jsp" >Movie </a>
						</li>
						<li class="dropdown first">
							<a  href="surveyList.jsp">Poll </a>
						</li>
						<li class="dropdown first">
							<a  href="productMgr.jsp" >Minishop </a>
						</li>
						<li class="dropdown first">
							<a  href="blogList.jsp" >Our Blog </a>
						</li>
						<li class="dropdown first">
							<a  href="orderList.jsp" >My page <i class="fa fa-angle-down" aria-hidden="true"></i></a>
						</li>
					</ul>
					<ul class="nav navbar-nav flex-child-menu menu-right">
						<%
							if(id==null){
						%>
						<li><a href="login.jsp">Log In</a></li>
						<li><a href="member.jsp">Sign Up</a></li>
						<%}else{ %>
						<li><a href="logout.jsp">Log Out</a></li>
						<%}%>
						<%if(mbean.getGrade().equals("1")){ %>
						<li class="btn signupLink"><a href="#">Post Movie List</a></li>
						<%}%>
					</ul>
				</div>
	    </nav>
	</div>
</header>

<div class="hero sr-single-hero sr-single">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
			</div>
		</div>
	</div>
</div>
<div class="page-single movie-single movie_single">
	<div class="container">
		<div class="row ipad-width2">
			<div class="col-md-4 col-sm-12 col-xs-12">
				<div class="movie-img sticky-sb">
					<img src="data/<%=poster%>" alt="">
					<div class="movie-btn">	
						<div class="btn-transform transform-vertical red">
							<div><a href="#" class="item item-1 redbtn"> <i class="ion-play"></i> Watch Trailer</a></div>
							<div><a href="https://www.youtube.com/embed/o-0hcF97wy0" class="item item-2 redbtn fancybox-media hvr-grow"><i class="ion-play"></i></a></div>
						</div>
						<div class="btn-transform transform-vertical">
							<div><a href="#" class="item item-1 yellowbtn"> <i  class="ion-heart"></i>Add to Favorite</a></div>
							<div><a href="#" class="item item-2 yellowbtn"><i  class="ion-heart"></i></a></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-8 col-sm-12 col-xs-12">
				<div class="movie-single-ct main-content">
					<h1 class="bd-hd"><%=name %></span></h1>
					<h4 class="bd-hd">Total <%=viewCount %> views and reviews</span></h4>
					<div class="social-btn">
						
						<div class="hover-bnt">
							<a href="#" class="parent-btn"><i class="ion-android-share-alt"></i>share</a>
							<div class="hvr-item">
								<a href="#" class="hvr-grow"><i class="ion-social-facebook"></i></a>
								<a href="#" class="hvr-grow"><i class="ion-social-instagram"></i></a>
								<a href="#" class="hvr-grow"><i class="ion-social-kakao"></i></a>
							</div>
						</div>		
					</div>
					<div class="movie-rate">
						
						<div class="rate">
							<i class="ion-android-star"></i>
							<p><span>총평점</span> /10<br>
							</p>
						</div>
						<div class="rate-star">
							<p>Rate This Movie:  </p>
							<i class="ion-ios-star"></i>
							<i class="ion-ios-star-outline"></i>
						</div>
					</div>
					<div class="movie-tabs">
						<div class="tabs">
							<ul class="tab-links tabs-mv tabs-series">
								<li class="active"><a href="#overview">Overview</a></li>
								<li><a href="#reviews"> Reviews</a></li>
								<li><a href="#cast">  Cast & Crew </a></li>
								<li><a href="#media"> Media</a></li> 
								            
							</ul>
						    <div class="tab-content">
						        <div id="overview" class="tab active">
						            <div class="row">
						            	<div class="col-md-8 col-sm-12 col-xs-12">
						            		<p><%=story %></p>
						            		
						            		<div class="title-hd-sm">
												<h4>Videos & Photos</h4>
												<a href="#" class="time">All 5 Videos & 245 Photos <i class="ion-ios-arrow-right"></i></a>
											</div>
											<div class="mvsingle-item ov-item">
												<a class="img-lightbox"  data-fancybox-group="gallery" href="images/uploads/image41.jpg" ><img src="images/uploads/image4.jpg" alt=""></a>
												<a class="img-lightbox"  data-fancybox-group="gallery" href="images/uploads/image51.jpg" ><img src="images/uploads/image5.jpg" alt=""></a>
												<a class="img-lightbox"  data-fancybox-group="gallery" href="images/uploads/image61.jpg" ><img src="images/uploads/image6.jpg" alt=""></a>
												<div class="vd-it">
													<img class="vd-img" src="images/uploads/image7.jpg" alt="">
													<a class="fancybox-media hvr-grow" href="https://www.youtube.com/embed/o-0hcF97wy0"><img src="images/uploads/play-vd.png" alt=""></a>
												</div>
											</div>
											<div class="title-hd-sm">
												<h4>cast</h4>
												<a href="#" class="time">Full Cast & Crew  <i class="ion-ios-arrow-right"></i></a>
											</div>
											<!-- movie cast -->
											<div class="mvcast-item">											
												<div class="cast-it">
													<div class="cast-left">
														<img src="images/uploads/cast1.jpg" alt="">
														<a href="#">Robert Downey Jr.</a>
													</div>
													<p>...  Robert Downey Jr.</p>
												</div>
												
											</div>
											<div class="title-hd-sm">
												<h4>User reviews</h4>
												<a href="#" class="time">See All 총 리뷰 개수 <i class="ion-ios-arrow-right"></i></a>
											</div>
											<!-- movie user review -->
											<div class="mv-user-review-item">
												<h3>Best Marvel movie in my opinion</h3>
												<div class="no-star">
													<i class="ion-android-star"></i>
													<i class="ion-android-star last"></i>
												</div>
												<p class="time">
													작성날짜 by <a href="#"> 작성id</a>
												</p>
												<p>영화후기 답글</p>
											</div>
						            	</div>
						            	<div class="col-md-4 col-xs-12 col-sm-12">
						            		<div class="sb-it">
						            			<h6>Director: </h6>
						            			<p><a href="#"><%=direc %></a></p>
						            		</div>
						            		
						            		<div class="sb-it">
						            			<h6>Stars: </h6>
						            			<p><a href="#"><%=actor %></a></p>
						            		</div>
						            		<div class="sb-it">
						            			<h6>Genres:</h6>
						            			<p><a href="#"><%=genre %></a></p>
						            		</div>
						            		<div class="sb-it">
						            			<h6>Release Date:</h6>
						            			<p><%=rdate %> released</p>
						            		</div>
						            		<div class="sb-it">
						            			<h6>Run Time:</h6>
						            			<p><%=runtime %></p>
						            		</div>
						            	
						            	</div>
						            </div>
						        </div>
						        <div id="reviews" class="tab review">
						           <div class="row">
						            	
						            	<div class="topbar-filter">
											<p>Found <span>56 reviews</span> in total</p>
											<label>Filter by:</label>
											<select>
												<option value="range">-- Choose option --</option>
												<option value="saab">-- Choose option 2--</option>
											</select>
										</div>
										
										
										<!-- 댓글 입력폼 Start -->
										<form method="post" name="cFrm">
											<div class="mv-user-review-item">
												<div class="user-infor">
													<img src="data/<%=fbean.getImage() %>" alt="">
													<div class="form-group col-sm-3">
														<input type="text" name="opinion" class="form-control" maxlength="300" placeholder="Enter your opinion...">
														
														
														<p class="time">
															 by <a href="#"> <%=id%></a>
														</p>
														
													</div>
													<div class="form-group col-sm-3" align="right">
														<p>Your Rate?</p>
													</div>
													<div class="form-group col-sm-3">
									                  <select name="rateScore">
									                    <option name="1" selected>1</option>
									                    <option name="2">2</option>
									                    <option name="3">3</option>
									                    <option name="4">4</option>
									                    <option name="5">5</option>
									                    <option name="6">6</option>
									                    <option name="7">7</option>
									                    <option name="8">8</option>
									                    <option name="9">9</option>
									                    <option name="10">10</option>
									                  </select>
									                </div>
													<div class="form-group col-sm-3" align = "right">
														<input type="button" value="OK" onclick="cInsert()">
													</div>
													
												</div>
												<textarea type="text" name="comment" class="form-control" maxlength="2048" style="height: 80px;" placeholder="Enter your Comment..."></textarea>
											</div>
											 <input type="hidden" name="flag" value="insert"><!--여기 중요!!! -->
											 <!-- 아래있는 변수들 재요청한다. 댓글쓸때 요청하면 모든 변수는 reset 된다. -->
											 <input type="hidden" name="num" value="<%=num%>">
											 <input type="hidden" name="cnum">
										    <input type="hidden" name="nowPage" value="<%=nowPage%>">
										    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
										   <%if(!(keyWord==null||keyWord.equals(""))){ %>
										    <input type="hidden" name="keyField" value="<%=keyField%>">
										    <input type="hidden" name="keyWord" value="<%=keyWord%>">
											<%}%>
											<input type="hidden" name="id" value="<%=login.getId()%>">
										</form>
 										<!-- 댓글 입력폼 End -->
										<hr/>
										 <!-- 댓글 List Start -->
										<%
											Vector<MovieCommentBean> cvlist=cmgr.getMovieComment(num);
											if(!cvlist.isEmpty()){
												//out.println(cvlist.size());
										%>
										<%
											for(int i=0; i<cvlist.size(); i++){
												MovieCommentBean cbean = cvlist.get(i);
												int cnum = cbean.getCnum();
												String cid = cbean.getId();
												String opinion = cbean.getOpinion();
												String comment = cbean.getComment();
												int crateScore = cbean.getRateScore();
												String cregdate = cbean.getRegdate();
										%>
										
										<div class="mv-user-review-item">
											<div class="user-infor">
												<img src="data/<%=fbean.getImage() %>" alt=""> 
												<div>
													<h3><%=opinion%></h3>
													<div class="no-star">
														<p class="rate"><i class="ion-android-star"></i><span><%=crateScore %></span> /10</p>
													</div>
													<p class="time">
														<%=cregdate %> by <a href="#"> <%=cid %></a>
													</p>
												</div>
											</div>
											<p><%=comment %></p>
											<input type="button" value="Delete" onclick="cDel('<%=cnum%>')">
										</div> 
										
									   <%}//for%> 
									  <% }//--if%>
										
										
									
										<div class="topbar-filter">
											<label>Reviews per page:</label>
											<select>
												<option value="range">5 Reviews</option>
												<option value="saab">10 Reviews</option>
											</select>
											<div class="pagination2">
												<span>Page 1 of 6:</span>
												<a class="active" href="#">1</a>
												
												<a href="#"><i class="ion-arrow-right-b"></i></a>
											</div>
										</div>
						            </div>
						        </div>
						        <div id="cast" class="tab">
						        	<div class="row">
						            	<h3>Cast & Crew of</h3>
					       	 			<h2>Avengers: Age of Ultron</h2>
										<!-- //== -->
					       	 			
										<div class="title-hd-sm">
											<h4>Cast</h4>
										</div>
										<div class="mvcast-item">											
											<div class="cast-it">
												<div class="cast-left">
													<img src="images/uploads/cast1.jpg" alt="">
													<a href="#">Robert Downey Jr.</a>
												</div>
												<p>...  Robert Downey Jr.</p>
											</div>
											
										</div>
										
						            </div>
					       	 	</div>
					       	 	<div id="media" class="tab">
						        	<div class="row">
						        		<div class="rv-hd">
						            		<div>
						            			<h3>Videos & Photos of</h3>
					       	 					<h2>The Big Bang Theory</h2>
						            		</div>
						            	</div>
						            	<div class="title-hd-sm">
											<h4>Videos <span>(8)</span></h4>
										</div>
										<div class="mvsingle-item media-item">
											<div class="vd-item">
												<div class="vd-it">
													<img class="vd-img" src="images/uploads/vd-item1.jpg" alt="">
													<a class="fancybox-media hvr-grow"  href="https://www.youtube.com/embed/o-0hcF97wy0"><img src="images/uploads/play-vd.png" alt=""></a>
												</div>
												<div class="vd-infor">
													<h6> <a href="#">Trailer:  Watch New Scenes</a></h6>
													<p class="time"> 1: 31</p>
												</div>
											</div>
											
											
										</div>
										<div class="title-hd-sm">
											<h4>Photos <span> (21)</span></h4>
										</div>
										<div class="mvsingle-item">
											<a class="img-lightbox"  data-fancybox-group="gallery" href="images/uploads/image11.jpg" ><img src="images/uploads/image1.jpg" alt=""></a>
											
										</div>
						        	</div>
					       	 	</div>
					       	 
						    </div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form name="listFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){%>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>
<footer class="ht-footer">
	<div class="container">
		<div class="flex-parent-ft">
			<div class="flex-child-ft item1">
				 <a href="index.jsp"><img class="logo" src="img/logo.png" alt=""></a>
				 <p>주소</p>
				<p>Call us: <a href="#">(+01) 202 342 6789</a></p>
			</div>
			
		</div>
	</div>
	<div class="ft-copyright">
		<div class="ft-left">
			<p><a target="_blank" href="https://www.templateshub.net">Templates Hub</a></p>
		</div>
		<div class="backtotop">
			<p><a href="#" id="back-to-top">Back to top  <i class="ion-ios-arrow-thin-up"></i></a></p>
		</div>
	</div>
</footer>
<script src="js/jquery.js"></script>
<script src="js/plugins.js"></script>
<script src="js/plugins2.js"></script>
<script src="js/custom.js"></script>
</body>
</html>