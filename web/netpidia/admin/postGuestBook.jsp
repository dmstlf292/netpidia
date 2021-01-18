<!-- postGuestBook.jsp 말 그대로 방명록만 작성하는 공간 -->
<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page pageEncoding="EUC-KR"%>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/> 
<%
	String id = (String)session.getAttribute("idKey");
	if(id==null){
		//현재 접속된 url값
		StringBuffer url = request.getRequestURL();
		response.sendRedirect("login.jsp?url="+url);
		return;//이후에 jsp 코드 실행 안됨.
	}
	MyprofileBean fbean = fmgr.getMyprofile(id);
%>
<!DOCTYPE html>
<html>
  <head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Post </title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/font.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <link rel="stylesheet" href="css/custom.css">
    <link rel="shortcut icon" href="img/minilogo.png"> 
    
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
</head>
  <body>
    
      <!-- Sidebar Navigation end-->
          
         <section class="no-padding-bottom">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-6">                                           
                <div class="messages-block block">
                  <div class="title"><strong>Leave any review</strong></div>
                  <form name="postFrm" method="post" action="postGuestBookProc.jsp">
	                  <div class="messages"><a href="#" class="message d-flex align-items-center">
	                      <div class="profile">
	                      	<img src="data/<%=fbean.getImage()%>" alt="..." class="img-fluid">
	                      	<!-- <img src="img/face.bmp" border="0" alt="성명">  -->
	                      </div>
	                      
	                      <div class="content">
	                      		<input   name="name" size="9" maxlength="20" value="<%=id%>" readonly class="form-control"> 								
						 </div>	
						 
						 <div>
						 
						  <button class="btn btn-primary" onclick="javascript:checkInputs()">Post</button>
						  <button type="reset" class="btn btn-secondary">Modify</button>
						   secret <input type="checkbox" name="secret" value="1" class="checkbox-template"> 
						  </div>
	                 </div>
					 <input type="text"  name="contents" rows="3"  cols="60"  
					 		placeholder="Enter..." class="form-control">
					 		
				      <div class="form-group row">
                        <div class="col-sm-9 ml-auto">
                          <input type="hidden" name="id" value="<%=login.getId()%>">
                          <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
                        
                          
                        </div>
                      </div>
                 </form>
              </div>
            </div>
          </div>
        </section>       
     
	
    <!-- JavaScript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="js/front.js"></script>
  </body>
</html>