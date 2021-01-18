<!-- updateGuestBook.jsp -->
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.GuestBookBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="gmgr" class="netpidia.GuestBookMgr"/>
<jsp:useBean id="login" scope="session" class="netpidia.MemberBean"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int num = 0;
		GuestBookBean bean = null;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
			bean = gmgr.getGuestBook(num);
		}
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
                  <div class="title"><strong>Review 사용자용 - 글 수정하기</strong></div>
                  <form method="post" action="updateGuestBookProc.jsp?num=<%=num%>">
	                  <div class="messages"><a href="#" class="message d-flex align-items-center">
	                      <div class="profile">
	                      	<img src="img/avatar-3.jpg" alt="..." class="img-fluid">
	                      	
	                      </div>
	                      
	                      <div class="content">
	                      		<input name="name" size="9" value="<%=login.getName()%>" readonly readonly class="form-control"> 								
						 </div>	
	                 </div>
					 <input type="text"  name="contents" rows="3"  cols="60"  
					 		value="<%=bean.getContents()%>" class="form-control">
					 		
				      <div class="form-group row">
                        <div class="col-sm-9 ml-auto">
                          <input type="hidden" name="id" value="<%=bean.getId()%>">
								<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
								<input type="submit" value="글수정"> 
								<input type="reset" value="고치기"> 
								<input type="checkbox" name="secret" value="1" 
								<%if(bean.getSecret().equals("1")) out.print("checked");%>>비밀글
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