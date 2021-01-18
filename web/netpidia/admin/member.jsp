<%@ page  contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>회원가입</title>
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
	 <script type="text/javascript">
		function idCheck(id) {
			if(id==""){
				alert("아이디를 입력하세요.");
				document.regFrm.id.focus();
				return;//이후에 코드를 실행이 안됨. 함수를 빠져나감.
			}
			url = "idCheck.jsp?id="+id;
			window.open(url,"ID중복체크","width=300,height=150");
		}
		
		function zipSearch() {
			url = "zipSearch.jsp?search=n";
			window.open(url,"우표번호검색",
					"width=500,height=350,scrollbars=yes");
		}
	</script> 
  </head>
  <body onLoad="regFrm.id.focus()">
    <div class="login-page">
      <div class="container d-flex align-items-center">
        <div class="form-holder has-shadow">
          <div class="row">
            <!-- Logo & Information Panel-->
            <div class="col-lg-6">
              <div class="info d-flex align-items-center">
                <div class="content">
                  <div class="logo">
                    <h1>Member Form</h1>
                  </div>
                  <p>Member Form</p>
                </div>
              </div>
            </div>
            <!-- Form Panel    -->
            <div class="col-lg-6 bg-white">
              <div class="form d-flex align-items-center">
                <div class="content">
                
                <!-- --form 형식---------------------- -->
                  <form class="text-left form-validate" name="regFrm" method="post" action="memberProc.jsp">
                    <div class="form-group-material">
	                      <input id="register-username" type="text" name="id" required data-msg="Please enter your username" class="input-material">
	                      <label for="register-username" class="label-material">Username</label>
	                      <div class="form-group">
	                      <input onClick="idCheck(this.form.id.value)" type="button" value="중복확인" class="btn btn-primary" onClick="idCheck(this.form.id.value)">
	                      </div>
                    </div>
                    
                    <div class="form-group-material">
                      <input id="register-email" type="password" name="pwd" required data-msg="Please enter a valid email address" class="input-material">
                      <label for="register-email" class="label-material">Password     </label>
                    </div>
                    <div class="form-group-material">
                      <input id="register-password" type="password" name="repwd" required data-msg="Please enter your password" class="input-material">
                      <label for="register-password" class="label-material">Re-Password        </label>
                    </div>
                    
                    <div class="form-group-material">
                      <input id="register-password" name="name" required data-msg="Please enter your name" class="input-material">
                      <label for="register-password" class="label-material">name        </label>
                    </div>
                    
                    <div class="line"></div>
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Gender</label>
                        <div class="col-sm-9">
                          <label class="checkbox-inline">
                            <input id="inlineCheckbox1" type="radio" name="gender" value="1" checked> 여자
                          </label>
                          <label class="checkbox-inline">
                            <input id="inlineCheckbox2" type="radio" name="gender" value="2"> 남자
                          </label>
                        </div>
                      </div>
                    
                    <div class="form-group-material">
                      <input id="register-password" name="birthday" size="6" required data-msg="ex)941122" class="input-material">
                      <label for="register-password" class="label-material">Birthday      </label>
                    </div>
                    
                    <div class="form-group-material">
                      <input id="register-password" name="email" size="27" required data-msg="Please enter your Email" class="input-material">
                      <label for="register-password" class="label-material">Email       </label>
                    </div>
                    
                    <!-- <div class="form-group-material">
                      <input id="register-password" name="zipcode"  size="5" required data-msg="Zipcode" class="input-material">
                      <input type="button" value="우편번호찾기"  class="btn btn-primary" onClick="zipCheck()">
                    </div> -->
                    
                    <!-- <div class="form-group-material">
                      <input id="register-password"  name="address" size="40" required data-msg="Please enter your address" class="input-material">
                      <label for="register-password" class="label-material">address       </label>
                    </div> -->
                    
                    <div class="line"></div>
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Taste</label>
                        <div class="col-sm-9">
                          <label class="checkbox-inline">
                            <input type="checkbox" name="taste" value="SF" >SF
                            <input type="checkbox" name="taste" value="판타지" >판타지
                            <input type="checkbox" name="taste" value="공포/스릴러" >공포/스릴러
                            <input type="checkbox" name="taste" value="드라마" >드라마
                            <input type="checkbox" name="taste" value="미스터리" >미스터리
                            <input type="checkbox" name="taste" value="어드벤쳐" >어드벤쳐
                            <input type="checkbox" name="taste" value="코미디" >코미디
                            <input type="checkbox" name="taste" value="애니메이션" >애니메이션
                            <input type="checkbox" name="taste" value="액션" >액션
                            <input type="checkbox" name="taste" value="멜로" >멜로
                          </label>
                        </div>
                      </div>
                    <!-- <div class="form-group terms-conditions text-center">
                      <input id="register-agree" name="registerAgree" type="checkbox" required value="1" data-msg="Your agreement is required" class="checkbox-template">
                      <label for="register-agree">I agree with the terms and policy</label>
                    </div> -->
                    
                    <div class="form-group terms-conditions text-center">
                      <input id="register-agree" name="registerAgree" type="checkbox" required value="1" data-msg="Your agreement is required" class="checkbox-template">
                      <label for="register-agree">I agree with the terms and policy</label>
                    </div>
                    <div class="form-group text-center">
                      <input id="register" type="submit" value="Register" class="btn btn-primary" onclick="inputCheck()">
                      <input id="register" type="Reset" value="Reset" class="btn btn-primary" >
                    </div>
                  </form><small>Already have an account? </small><a href="login.jsp" class="signup">Login</a>

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