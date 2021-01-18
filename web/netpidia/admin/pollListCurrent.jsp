<!-- 관리자용 -->
<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.PollListBean"%>
<%@page import="netpidia.PollItemBean"%>
<%@page import="java.util.Vector"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="netpidia.PollMgr"/>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	String id = (String)session.getAttribute("idKey");
	if(id==null){
		response.sendRedirect("login.jsp");
		return;
	}
	MemberBean bean = mMgr.getMember(id);
	MyprofileBean fbean = fmgr.getMyprofile(id);
%>
<!DOCTYPE html>
<html>
  <head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Netpidia </title>
    <script type="text/javascript">
	function send() {//<input type="button" value="작성하기" onclick="send()">
		f = document.frm;
		f.sdate.value = f.sdateY.value+"-"
		+ f.sdateM.value+"-"+f.sdateD.value;
		f.edate.value = f.edateY.value+"-"
		+ f.edateM.value+"-"+f.edateD.value;
		f.submit();
	}
	</script>
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
  </head>
  <body>
   <header class="header">   
      <nav class="navbar navbar-expand-lg">
        <div class="search-panel">
          <div class="search-inner d-flex align-items-center justify-content-center">
            <div class="close-btn">Close <i class="fa fa-close"></i></div>
            <form id="searchForm" action="#">
              <div class="form-group">
                <input type="search" name="search" placeholder="What are you searching for...">
                <button type="submit" class="submit">Search</button>
              </div>
            </form>
          </div>
        </div>
        <div class="container-fluid d-flex align-items-center justify-content-between">
          <div class="navbar-header">
            <!-- Navbar Header--><a href="index.jsp" class="navbar-brand">
              <div class="brand-text brand-big visible text-uppercase"><strong class="text-primary">Netpidia Poll List</strong></div>
              <div class="brand-text brand-sm"></div></a>
            <!-- Sidebar Toggle Btn-->
            <button class="sidebar-toggle"><i class="fa fa-long-arrow-left"></i></button>
          </div>
          <div class="right-menu list-inline no-margin-bottom">    
          	<%if (id==null){ %>
          	<div class="list-inline-item logout">                   <a id="login" href="login.jsp" class="nav-link">Login <i class="icon-logout"></i></a></div> 
          	<div class="list-inline-item logout">                   <a id="member" href="member.jsp" class="nav-link">Sign up <i class="icon-logout"></i></a></div> 
            <%}else{ %>
            <div class="list-inline-item logout">                   <a id="logout" href="login.jsp" class="nav-link">Logout <i class="icon-logout"></i></a></div>
           	<%} %>
          </div>
        </div>
      </nav>
    </header>
    <div class="d-flex align-items-stretch">
      <!-- Sidebar Navigation-->
      <nav id="sidebar">
        <!-- Sidebar Header-->
        <div class="sidebar-header d-flex align-items-center">
          <div class="avatar"><img src="data/<%=fbean.getImage() %>" alt="..." class="img-fluid rounded-circle"></div>
          <div class="title">
            <h1 class="h5">Hi, <%=id%></b> </h1>
            <p></p>
          </div>
        </div>
        <!-- Sidebar Navidation Menus--><span class="heading">Admin</span>
        <ul class="list-unstyled">
             
                <li ><a href="surveyList.jsp"> <i class="icon-padnote"></i>Event & Review </a></li>   
                <li ><a href="pollInsert.jsp"> <i class="icon-padnote"></i>Form for poll(Admin)</a></li>
                <li class="active"><a href="pollListCurrent.jsp" > <i class="icon-padnote"></i>Current Poll List</a></li>
        </ul>
      </nav>
<!-- ------------------------------------공통헤더부분 ----------------------------------------------- -->
      <!-- Sidebar Navigation end-->
      <div class="page-content">
        <!-- Page Header-->
        <div class="page-header no-margin-bottom">
          <div class="container-fluid">
            <h2 class="h5 no-margin-bottom">Charts</h2>
          </div>
        </div>
        <!-- Breadcrumb-->
        <div class="container-fluid">
          <ul class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Main</a></li>
            <li class="breadcrumb-item active">Current Poll List           </li>
          </ul>
        </div>
        
        
         <section class="no-padding-top">
          <div class="container-fluid">
            <div class="row"> 
              <div class="col-lg-6">
                <div class="block margin-bottom-sm">
                  <div class="title"><strong>Current Poll List </strong></div>
                  <div class="table-responsive"> 
                    <table class="table table-striped">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th>Question</th>
                          <th>Start Day</th>
                          <th>Close Day</th>
                        </tr>
                      </thead>
                      <tbody>
                      	<%
                      	 	Vector<PollListBean> vlist = mgr.getPollList();
                			for(int i=0; i<vlist.size(); i++){
                				PollListBean plBean = vlist.get(i);
                				int num = plBean.getNum();
                				String question = plBean.getQuestion();
                				String sdate = plBean.getSdate();
                				String edate = plBean.getEdate();
                      	%>
                        <tr>
                          <th scope="row"><%=vlist.size()-i%></th>
                          <td><a href="pollListCurrent.jsp?num=<%=num%>"><%=question%></a></td>
                          <td><%=sdate%></td>
                          <td><%=edate%></td>
                        </tr>
                       <%}//---for%>
                      </tbody>
                    </table>
                  </div> 
                </div>
              </div>   

              <div class="col-lg-6">
                <div class="block margin-bottom-sm">
                  <div class="title"><strong>Poll</strong></div>
                  <div class="table-responsive">  
                  <!-- 여기 추가하기!!! -->
                  <jsp:include page="pollCurrentForm.jsp"/>
                  </div>
                </div>
              </div>
              
            
            </div>
          </div>
        </section> 
        <footer class="footer">
        </footer>
      </div>
    </div>
    <!-- JavaScript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="js/charts-custom.js"></script>
    <script src="js/front.js"></script>
  </body>
</html>