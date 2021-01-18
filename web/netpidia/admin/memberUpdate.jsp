<!-- memberUpdate.jsp -->
<%@page import="netpidia.MemberBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="netpidia.MemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
		MemberBean bean = mgr.getMember(id);
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>회원 수정하기</title>
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
	 <script type="text/javascript">
	 	function zipCheck() {
			url = "zipSearch.jsp?search=n";
			window.open(url, "ZipCodeSearch","width=500,height=300,scrollbars=yes");
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
                    <h1>Member Update Form</h1>
                  </div>
                  <p>Member Update Form</p>
                </div>
              </div>
            </div>
            <!-- Form Panel    -->
            <div class="col-lg-6 bg-white">
              <div class="form d-flex align-items-center">
                <div class="content">
                
                
                
                <!-- --form 형식---------------------- -->
                  <form class="text-left form-validate" name="regFrm" method="post" action="memberUpdateProc.jsp">
                    <div class="form-group-material">
	                      <input id="register-username" type="text" name="id" value="<%=bean.getId() %>" readonly required data-msg="Please enter your username" class="input-material">
	                      <label for="register-username" class="label-material">Username</label>
                    </div>
                    
                    <div class="form-group-material">
                      <input id="register-email" type="password" name="pwd" value="<%=bean.getPwd()%>" required data-msg="Please enter a valid email address" class="input-material">
                      <label for="register-email" class="label-material">Password     </label>
                    </div>
                    
                    <div class="form-group-material">
                      <input id="register-password" name="name" value="<%=bean.getName()%>" required data-msg="Please enter your name" class="input-material">
                      <label for="register-password" class="label-material">name        </label>
                    </div>
                    
                    <div class="line"></div>
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Gender</label>
                        <div class="col-sm-9">
                          <label class="checkbox-inline">
                            <input id="inlineCheckbox1" type="radio" name="gender" value="1" <%if(bean.getGender().equals("1")) 
										   			out.println("checked");%>> 여자
                          </label>
                          <label class="checkbox-inline">
                            <input id="inlineCheckbox2" type="radio" name="gender" value="2" <%if(bean.getGender().equals("2")) 
										   			out.println("checked");%>> 남자
                          </label>
                        </div>
                      </div>
                    
                    <div class="form-group-material">
                      <input id="register-password" name="birthday" size="6" value="<%=bean.getBirthday()%>" required data-msg="ex)830815" class="input-material">
                      <label for="register-password" class="label-material">Birthday      </label>
                    </div>
                    
                    <div class="form-group-material">
                      <input id="register-password" name="email" size="27" value="<%=bean.getEmail()%>" required data-msg="Please enter your Email" class="input-material">
                      <label for="register-password" class="label-material">Email       </label>
                    </div>
                  
                    
                    <div class="line"></div>
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Taste</label>
                        <div class="col-sm-9">
                          <label class="checkbox-inline">
                          		<%
										String list[] = {"SF", "판타지", "공포/스릴러", "드라마", "미스터리", "어드벤쳐", "코미디", "애니메이션", "액션", "멜로"};
										String ts[] = bean.getTaste();
										for(int i=0;i<ts.length;i++){
								%>
								<%=list[i] %>
								<input type="checkbox" name="taste" value="<%=list[i]%>" 
								<%=ts[i].equals("1")?"checked":""%>>
								<%}//---for%>	 
                          </label>
                        </div>
                      </div>
                 
                    <div class="form-group text-center">
                      <input type="submit" value="수정완료" class="btn btn-primary">&nbsp; &nbsp; 
                      <input type="reset" value="다시쓰기" class="btn btn-primary">
                    </div>
                  </form><small>Already have an account? </small><a href="login.jsp" class="signup">Login</a>
                
                
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="js/front.js"></script>
  </body>
</html>