<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="login" class="netpidia.MemberBean" scope="session"/>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Netpidia User Login Form </title>
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
  </head>
  <body>
    <div class="login-page">
      <div class="container d-flex align-items-center">
        <div class="form-holder has-shadow">
          <div class="row">
            <div class="col-lg-6">
              <div class="info d-flex align-items-center">
                <div class="content">
                  <div class="logo">
                    <h1>Login Form</h1>
                  </div>
                  <p>Login Form Example</p>
                </div>
              </div>
            </div>
            <div class="col-lg-6 bg-white">
	              <div class="form d-flex align-items-center">
	                <div class="content">
	                <!-- Form Panel ½ÃÀÛ   -->
	                   <form method="post" action="loginProc.jsp">
	                    <div class="form-group">
	                      <input name="id"  type="text" required data-msg="Please enter your username" class="input-material">
	                      <label for="login-username" class="label-material">UserName</label>
	                    </div>
	                    <div class="form-group">
	                      <input name="pwd"  type="password" required data-msg="Please enter your user password" class="input-material">
	                      <label for="login-password" class="label-material">UserPassword</label>
	                    </div>
	                    <input type="submit" value="login"  class="btn btn-primary"> 
	                  </form><small>Do not have an account? </small><a href="javascript:location.href='member.jsp'" class="signup">Signup</a>
	                <!-- Form Panel ³¡ -->
	                </div>
	              </div>
	            </div>
          </div>
        </div>
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