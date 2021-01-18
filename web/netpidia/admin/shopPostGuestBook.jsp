<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page pageEncoding="EUC-KR"%>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<jsp:useBean id="pbean1" class="netpidia.ProductBean"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>   
<%
   		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey"); 
		MyprofileBean fbean = fmgr.getMyprofile(id); 
		
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop Review</title>
    
    
    <script type="text/javascript">
	function checkInputs() {
		frm = document.postFrm;
		if(frm.contents.value==""){
			alert("내용을 입력해 주세요.");
			frm.contents.focus();
			return;
		}
		frm.submit();
	}
	</script>


    <link rel="shortcut icon" href="img/minilogo.png"> 
	<link rel="stylesheet" href="assets/plugins/css/plugins.css">	
    <link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/responsiveness.css" rel="stylesheet"><link id="jssDefault" rel="stylesheet" href="assets/css/skins/default.css">
	</head>
	<body>
	
	
									<!-- -여기 method="get"!!!!!!! -->
									<form name="postFrm" method="get" action="shopPostGuestBookProc.jsp?">
										<div class="tr-single-body" >
											<div class="review-box">
												<div class="review-thumb">
													<img src="data/<%=fbean.getImage() %> " class="img-responsive img-circle" alt="" />
												</div>
												<div class="review-box-content">
												
													<div class="review-user-info">
														<input name="name" size="9" maxlength="20" value="<%=login.getName()%>" readonly>
														<textarea  name="contents" cols="80" rows="2">Enter...</textarea>
													</div>
													<input type="hidden" name="id" value="<%=login.getId()%>">
													<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
													<input type="button" value="OK" onclick="javascript:checkInputs()" class="btn btn-danger ml-1 mt-2" >  
													<input type="reset" value="Reset" class="btn btn-danger ml-1 mt-2">
													<input type="checkbox" name="secret" value="1"  class="checkbox-template">&nbsp;Secret
													<input type="hidden" name="productNo" value="<%=pbean1.getProductNo()%>">
												</div>
											</div>	
										</div>
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