<%@ page contentType="text/html; charset=EUC-KR" %>
 <%@ page import="netpidia.BoardBean"%>
<% 
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String numPerPage = request.getParameter("numPerPage");
	  BoardBean bean = (BoardBean)session.getAttribute("bean");
	  String subject = bean.getSubject();
	  String name = bean.getName(); 
	  String content = bean.getContent();
	  //read.jsp에서 session에 빈즈 단위로 저장 했기 때문에 파일명도 가져 올 수 있다.
	  String filename = bean.getFilename();
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
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Custom Font Icons CSS-->
    <link rel="stylesheet" href="css/font.css">
    <!-- Google fonts - Muli-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="img/minilogo.png"> 
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
  
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
  
  
  
  </head>
  <body>
    <div class="d-flex align-items-stretch">
      <!-- Sidebar Navigation end-->
      <div class="page-content">
        <div class="container-fluid">
          <ul class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Admin</a></li>
            <li class="breadcrumb-item active">Repost          </li>
          </ul>
        </div>
        <section class="no-padding-top">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-6">
                <div class="block">
                  <div class="title"><strong class="d-block">Posting Form</strong></div>
                  <div class="block-body">
                  
                  
                    <form class="form-horizontal" name="updateFrm" method="post" action="boardUpdate" enctype="multipart/form-data">
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Name</label>
                        <div class="col-sm-9">
                          <input name="name" size="10" maxlength="8" value="<%=name%>" required class="form-control form-control-success">
                        </div>
                      </div>
                      
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Title</label>
                        <div class="col-sm-9">
                          <input name="subject" size="50" maxlength="30" value="<%=subject%>" required class="form-control form-control-warning">
                        </div>
                      </div>

                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Content</label>
                        <div class="col-sm-9">
                          <textarea name="content" rows="7" cols="50" required  class="form-control form-control-warning"><%=content%></textarea>
                        </div>
                      </div>
                      
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Password</label>
                        <div class="col-sm-9">
                          <input name="pass" size="15" maxlength="15" value="1234" type="password" placeholder="password" required class="form-control form-control-warning">
                        </div>
                      </div>
                      
                       <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Upload File</label>
                        <div class="col-sm-9">
                          <%=filename!=null?filename:"No file attached."%>
                          <input  type="file"  name="filename" size="50" maxlength="50">
                        </div>
                      </div>
                      
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Password</label>
                        <div class="col-sm-9">
                         Requires passwoard
                          <input name="pass" size="15" maxlength="15"   type="password" required class="form-control form-control-warning">
                        </div>
                      </div>

                      <div class="form-group row">       
                        <div class="col-sm-9 offset-sm-3">
                          
                          <input type="button" value="Submit" onClick="check()" class="btn btn-primary">
					      <input type="reset" value="Rewrite" class="btn btn-primary"> 
					      <input type="button" value="Back" onClick="history.go(-1)" class="btn btn-primary">
                          
                          
                         
                        </div>
                      </div>
                     <input type="hidden" name="nowPage" value="<%=nowPage %>">
					 <input type='hidden' name="num" value="<%=num%>">
					 <input type='hidden' name="numPerPage" value="<%=numPerPage%>">
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
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