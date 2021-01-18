<!-- post.jsp --> 
<%@ page  contentType="text/html; charset=EUC-KR"%>
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
    <link rel="shortcut icon" href="img/favicon.ico">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
  </head>
  <body>
    <div class="d-flex align-items-stretch">
      <!-- Sidebar Navigation end-->
      <div class="page-content">
        <div class="container-fluid">
          <ul class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Admin</a></li>
          </ul>
        </div>
        <section class="no-padding-top">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-6">
                <div class="block">
                 
                  <div class="block-body">
                  
                  
                    <form class="form-horizontal" name="postFrm" method="post" action="lboardPost" enctype="multipart/form-data">
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Name</label>
                        <div class="col-sm-9">
                          <input name="name" size="10" maxlength="8" placeholder="name" required class="form-control form-control-success">
                        </div>
                      </div>
                      
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Title</label>
                        <div class="col-sm-9">
                          <input name="subject" size="50" maxlength="30" placeholder="title" required class="form-control form-control-warning">
                        </div>
                      </div>

                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Content</label>
                        <div class="col-sm-9">
                          <textarea name="content" rows="7" cols="50" placeholder="content" required  class="form-control form-control-warning"></textarea>
                        </div>
                      </div>
                      
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Password</label>
                        <div class="col-sm-9">
                          <input name="pass" size="15" maxlength="15" value="1234" type="password" placeholder="password" required class="form-control form-control-warning">
                        </div>
                      </div>
                      
                       <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Search File</label>
                        <div class="col-sm-9">
                          <input  type="file"  name="filename" size="50" maxlength="50" placeholder="type">
                        </div>
                      </div>
                      
                      
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Content type</label>
                        <div class="col-sm-9">
	                         HTML<input type=radio name="contentType" value="HTTP" >&nbsp;&nbsp;&nbsp;
	  			 			 TEXT<input type=radio name="contentType" value="TEXT" checked>
                        </div>
                      </div>
                      
                      <div class="form-group row">       
                        <div class="col-sm-9 offset-sm-3">
                          <input type="submit" value="Post" class="btn btn-primary">
                          <input type="reset" value="Reset" class="btn btn-primary">
                         
                        </div>
                      </div>
                      <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
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