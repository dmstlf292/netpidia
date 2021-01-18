<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<%-- <jsp:useBean id="mMgr" class="netpidia.MemberMgr"/> --%>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
		/* MemberBean bean = mMgr.getMember(id);  */
		MyprofileBean fbean = fmgr.getMyprofile(id);
%>
<!doctype html>
<html lang="en" dir="ltr">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<title>Netpidia - Blog Post</title>
<link rel="shortcut icon" href="img/minilogo.png">
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="assets/plugins/summernote/dist/summernote.css" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/theme1.css" />
</head>
<body class="font-montserrat">


	<div>
		<div>
			<div id="page_top" class="section-body top_dark">
				<div class="container-fluid">
					<div class="page-header">
						<div class="left">
							<a href="blogList.jsp" class="icon menu_toggle mr-3"><i
								class="fa  fa-align-left"></i></a>
							<h1 class="page-title">Post mine blog</h1>
							<img class="avatar" src="data/<%=fbean.getImage() %>" alt="" data-toggle="tooltip" title="User Menu"/>
							&nbsp;&nbsp;&nbsp;&nbsp; <h1 class="page-title">Hi, <%=id %></h1>
						</div>
					</div>
				</div>
			</div>



			<form name="postFrm" method="post" action="blogPost"
				enctype="multipart/form-data">
				<div class="section-body mt-3">
					<div class="container-fluid">
						<div class="row clearfix">
						
						
						
							<div class="col-lg-4 col-md-12">
								<div class="card c_grid c_yellow">
									<div class="card-body text-center">
										<div class="circle">
											<img class="rounded-circle" src="data/<%=fbean.getImage() %>" alt=""> 	
										</div>


										<h6 class="mt-3 mb-0">Id : <input name="id" value="<%=login.getId()%>"></h6>
										<h6>
											Name : <input name="name" size="20" maxlength="20" value="<%=login.getName()%>">
										</h6>
										<span>Email : <input name="email" size="30" value="<%=login.getEmail()%>"
											maxlength="30">
										</span>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header">
										<h3 class="card-title">My Facebook Link</h3>
									</div>
									<div class="card-body">
										<input name="fhp" size="40" maxlength="40" value="<%=fbean.getFhp()%>">
									</div>
								</div>
								<div class="card">
									<div class="card-header">
										<h3 class="card-title">My Instagram Link</h3>
									</div>
									<div class="card-body">
										<input name="ihp" size="40" maxlength="40" value="<%=fbean.getIhp()%>">
									</div>
								</div>
								<div class="card">
									<div class="card-header">
										<h3 class="card-title">Title</h3>
									</div>
									<div class="card-body">
										<textarea name="subject" rows="5" cols="40" requried></textarea>
									</div>
								</div>

								<div class="card">
									<div class="card-header">
										<h3 class="card-title">Share Netflix Id Info</h3>
									</div>
									<div class="card-body">
										<ul class="list-group">
											<li class="list-group-item"><span>Share ID : <input
													name="netemail" size="30" maxlength="30" requried>
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item"><span>Total price : <input
													name="totalprice" size="10" maxlength="10" requried>
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item"><span class="text-muted"> Price per 1 person
												<input name="price" size="10" maxlength="10" requried>
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item"><span class="text-muted">How many people are you looking for
													: <input name="cperson" size="10" maxlength="10" requried>
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item"><span class="text-muted">Close date will be
													: <input name="date" size="10" maxlength="10" requried>
											</span>
												<p class="mb-0"></p></li>
											
										</ul>
									</div>
								</div>
							</div>
							
							
							
							<div class="col-lg-8 col-md-12">
								<div class="card">
									<div class="card-body">
									
												
										<div class="summernote">
		                                   <textarea name="content" rows="10" cols="113" test></textarea>
		                                </div>
									
										<tr>
											<td>Password</td>
											<td><input type="password" name="pass" size="15"
												maxlength="15" value="1234"></td>
										</tr>
										 <tr>
											<td>Find file</td>
											<td><input type="file" name="filename" size="50"
												maxlength="50"></td>
										</tr> 
										<tr>
											<td>Content Type</td>
											<td>HTML<input type=radio name="contentType"
												value="HTTP">&nbsp;&nbsp;&nbsp; TEXT<input
												type=radio name="contentType" value="TEXT" checked>
											</td>
										</tr>
										<div class="mt-4 text-right">
											<button type="submit" class="btn btn-primary">Post</button>
											<button type="reset" class="btn btn-primary">Rewrite</button>
											<button type="button"
												onClick="javascript:location.href='blogList.jsp'"
												class="btn btn-primary">List</button>

										</div>
									</div>
								</div>
								<div class="card">
								<div id="profile-div" class="feature-media-upload">
												
												<div class="preview">
													<div class="upload">
														<div class="post_btn">
															<div class="plus_icon"></div>
															<h5>Post your BlogCover image</h5>
															<canvas id="imageCanvas"></canvas>
														</div>
													</div>
												</div>
												<p>
										 			<input type="file" name="image" id="id_image" class="btn btn-primary">
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
												
											</div>
								
								</div>
							</div>
							
						</div>
					</div>
				</div>
				<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			</form>
			
		
		
		
			
			
			
		</div>
	</div>
	<script src="assets/bundles/lib.vendor.bundle.js"></script>
	<script src="assets/bundles/summernote.bundle.js"></script>
	<script src="assets/js/core.js"></script>
	<script src="assets/js/page/summernote.js"></script>
</body>
</html>