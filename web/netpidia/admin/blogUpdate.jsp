<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@ page import="netpidia.BlogBoardBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<jsp:useBean id="mbean" class="netpidia.MyprofileBean"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>

<% 
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String numPerPage = request.getParameter("numPerPage");
	  BlogBoardBean bean = (BlogBoardBean)session.getAttribute("bean");
	  String subject = bean.getSubject();
	  String name = bean.getName(); 
	  String content = bean.getContent();
	  //read.jsp에서 session에 빈즈 단위로 저장 했기 때문에 파일명도 가져 올 수 있다.
	  String filename = bean.getFilename();
	  String id = (String)session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
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
<script>
	function check() {
	   if (document.updateFrm.pass.value == "") {
		 alert("수정을 위해 비밀번호를 입력하세요.");
		 document.updateFrm.pass.focus();
		 return false;
		 }
	   document.updateFrm.submit();
	}
</script>
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
							<h1 class="page-title">블로그 글 작성하기</h1>
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
											<img class="rounded-circle" src="data/<%=mbean.getImage() %>" alt=""> 
											<img src="data/<%=fbean.getImage() %>" class="img-responsive img-circle" alt="" /> 
										</div>


										<h6 class="mt-3 mb-0"></h6>
										<h6>
											이름 : <input name="name" size="20" maxlength="20" value="<%=login.getName()%>">
										</h6>
										<span>이메일 : <input name="email" size="30" value="<%=login.getEmail()%>"
											maxlength="30">
										</span>
									</div>
								</div>
								<div class="card">
									<div class="card-header">
										<h3 class="card-title">제목</h3>
									</div>
									<div class="card-body">
										<textarea name="subject" rows="5" cols="53" value="<%=subject%>"></textarea>
									</div>
								</div>


								<div class="card">
									<div class="card-header">
										<h3 class="card-title">넷플릭스 아이디 쉐어 모집 Info</h3>
									</div>
									<div class="card-body">
										<ul class="list-group">
											<li class="list-group-item"><span>넷플릭스 아이디 : <input
													name="netemail" size="30" maxlength="30">
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item"><span>총가격 : <input
													name="totalprice" size="10" maxlength="10">
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item"><span class="text-muted">1사람당
													가격 : <input name="price" size="10" maxlength="10">
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item"><span class="text-muted">모집인원수
													: <input name="cperson" size="10" maxlength="10">
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item"><span class="text-muted">날짜마감
													: <input name="date" size="10" maxlength="10">
											</span>
												<p class="mb-0"></p></li>
											<li class="list-group-item">
												<div>In Progress</div>
												<div class="progress progress-xs mb-0">
													<div class="progress-bar bg-info" style="width: 58%"></div>
												</div>
											</li>
										</ul>
									</div>
								</div>


							</div>
							<div class="col-lg-8 col-md-12">
								<div class="card">
									<div class="card-body">
										<div class="summernote">
		                                   <textarea name="content" rows="10" cols="113"></textarea>
		                                </div>
										<tr>
											<td>비밀 번호</td>
											<td><input type="password" name="pass" size="15"
												maxlength="15" value="1234"></td>
										</tr>
										 <tr>
											<td>파일찾기</td>
											<td><input type="file" name="filename" size="50"
												maxlength="50"></td>
										</tr> 
										<tr>
											<td>내용타입</td>
											<td>HTML<input type=radio name="contentType"
												value="HTTP">&nbsp;&nbsp;&nbsp; TEXT<input
												type=radio name="contentType" value="TEXT" checked>
											</td>
										</tr>
										<div class="mt-4 text-right">
											<button type="submit" class="btn btn-primary">Post</button>
											<button type="reset" class="btn btn-primary">다시쓰기</button>
											<button type="button"
												onClick="javascript:location.href='blogList.jsp'"
												class="btn btn-primary">리스트</button>

										</div>
									</div>
								</div>

								</td>
								</tr>
								</table>
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