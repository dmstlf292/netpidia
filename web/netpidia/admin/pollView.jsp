<!-- 관리자용 -->
<%@page import="java.util.Random"%>
<%@page import="netpidia.PollItemBean"%>
<%@page import="java.util.Vector"%>
<%@page import="netpidia.PollListBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="netpidia.PollMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int listNum=Integer.parseInt(request.getParameter("num"));		
		PollListBean plBean = mgr.getPoll(listNum);
		Vector<PollItemBean> vlist= mgr.getView(listNum);
		int sumCnt = mgr.sumCount(listNum);
		int maxCnt = mgr.getMaxCount(listNum);
%> 
<!doctype html>
<html lang="en" dir="ltr">
<!-- soccer/project/index.html  07 Jan 2020 03:37:47 GMT -->
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="shortcut icon" href="img/minilogo.png"> 
<!-- Bootstrap Core and vandor -->
<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />
<!-- Plugins css -->
<link rel="stylesheet" href="assets/plugins/charts-c3/c3.min.css"/>
<!-- Core css -->
<link rel="stylesheet" href="assets/css/main.css"/>
<link rel="stylesheet" href="assets/css/theme1.css"/>
</head>
<body class="font-montserrat">
<!-- Page Loader -->
<div class="page-loader-wrapper">
    <div class="loader">
    </div>
</div>
    <div class="page">
        <div class="section-body mt-3">
            <div class="container-fluid">
                <div class="row clearfix">
                    <div class="col-lg-12">
                        <div class="mb-4">
                            <h4 class="card-title">Question : <%=plBean.getQuestion()%></h4>
                        </div>                      
                    </div>
                </div>
                <div class="row clearfix row-deck">
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="card">
                            <div class="card-header">
                               <h3 class="card-title">Total voters : <%=sumCnt%> prs</h3>
                            </div>
                        </div>
                    </div>
                 </div>
                 <div class="row clearfix row-deck">
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="card">
                        <!-- 벡타 돌려야해서 form 들어가야함 -->
						<%
							Random r =new Random();
							for(int i = 0; i<vlist.size();i++){
							PollItemBean piBean = vlist.get(i);
							String item[]=piBean.getItem();
							int count = piBean.getCount();
							int ratio = (int)(Math.round((double)count/sumCnt*100));
							String rgb="#"+Integer.toHexString(r.nextInt(255*255*255));
						%>	
                            <div class="card-header">
                               <h3 class="card-title">
                               <%=i+1 %>
                               <%if(maxCnt==count){%><font color="red"><b><%}%>
							   <%=item[0]%><%if(maxCnt==count){%></b></font><%}%></h3>
                            </div>
                            <div class="card-body">
                                <h5 class="number mb-0 font-32 counter" color="<%=rgb%>"><%=count%></h5>
                                <span class="font-12"><%=ratio %>%</span>
                            </div> 
                        <%}//--for%>    
                        </div>
                    </div>
                 </div>   
              </div>  
            </div>    
           </div>      
        <!--  <a href="javascript:window.close()">닫기</a>  -->
<script src="assets/bundles/lib.vendor.bundle.js"></script>
<script src="assets/bundles/apexcharts.bundle.js"></script>
<script src="assets/bundles/counterup.bundle.js"></script>
<script src="assets/bundles/knobjs.bundle.js"></script>
<script src="assets/bundles/c3.bundle.js"></script>
<script src="assets/js/core.js"></script>
<script src="assets/js/page/project-index.js"></script>
</body>
</html>
                    