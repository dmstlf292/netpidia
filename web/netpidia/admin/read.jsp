<!-- read.jsp -->
<%@page import="java.util.Vector"%>
<%@page import="netpidia.BCommentBean"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="netpidia.BoardBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="netpidia.BoardMgr"/>
<!-- 댓글 mgr 만들기 -->
<jsp:useBean id="cmgr" class="netpidia.BCommentMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
        String nowPage = request.getParameter("nowPage");	
		String numPerPage = request.getParameter("numPerPage");	
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");	
		int num = UtilMgr.parseInt(request, "num");	
		String flag = request.getParameter("flag");
		if(flag!=null){
			if(flag.equals("insert")){
				BCommentBean cbean = new BCommentBean();
				cbean.setNum(num);
				cbean.setName(request.getParameter("cName"));
				cbean.setComment(request.getParameter("comment"));
				cmgr.insertBComment(cbean);
			}else if(flag.equals("del")){//"delete 말고" "del" 해야지 댓글 삭제가 된다
				//댓글 삭제 기능, 정수로 바꿔야한다.
				cmgr.deleteBComment(UtilMgr.parseInt(request, "cnum"));
			}
		}else{
			//list.jsp에서 넘어오는 경우, flag값은 안가져오지만 조회수는 증가
			//조회수 증가
			mgr.upCount(num);
		}
		//조회수 증가
		mgr.upCount(num);
		//게시물 읽기
		BoardBean bean = mgr.getBoard(num);
		String name = bean.getName();
		String subject = bean.getSubject();
		String regdate = bean.getRegdate();
		String content = bean.getContent();
		String filename = bean.getFilename();
		int filesize = bean.getFilesize();
		String ip = bean.getIp();
		int count = bean.getCount();	
		//읽어온 게시물을 수정 및 삭제를 위해 세션저장
		session.setAttribute("bean", bean);		
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
  
  <script type="text/javascript">
	function down(filename) {
		document.downFrm.filename.value=filename;
		document.downFrm.submit();
	}
	function surveyList() {
		document.listFrm.action ="surveyList.jsp";
		document.listFrm.submit();
	}
	function cInsert() {
		if(document.cFrm.comment.value==""){
			alert("댓글을 입력하세요.");
			document.cFrm.comment.focus();
			return;
		}
		document.cFrm.submit();
	}
	function cDel(cnum) {
		document.cFrm.cnum.value=cnum;
		document.cFrm.flag.value="del";
		document.cFrm.submit();
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
          </ul>
        </div>
        <section class="no-padding-top">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-6">
                <div class="block">
                  <div class="title"><h3><strong class="d-block">Posted&nbsp;&nbsp;&nbsp;<small>View  <%=count%></small></strong></h3></div>
                  
                  <div class="block-body">
                  
                  
                  
                    <form class="form-horizontal" name="postFrm" method="post" action="lboardPost" enctype="multipart/form-data">
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Name</label>
                        <div class="col-sm-9">
                        
                          <%=name%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                         
                        
                          
                          <label class="col-sm-3 form-control-label">Date</label>
                          <%=regdate%>
                        </div>
                      </div>
                      
                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Title</label>
                        <div class="col-sm-9">
                         <%=subject%>
                        </div>
                      </div>

                      <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Content</label>
                        <div class="col-sm-9">
                          <%=content%>
                        </div>
                      </div>
                      
                       <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Incluied file</label>
                        <div class="col-sm-9">
                         <%if(filename!=null&&!filename.equals("")){%>
				    		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
				    		<font color="blue">(<%=UtilMgr.intFormat(filesize)%>bytes)</font>
				    	<%}else{out.println("첨부된 파일이 없습니다.");}%>
                        </div>
                      </div>
                      
                    </form>
                    </br>
                    <p><h3><string>Leave your comment</string></h3></p>
                    <form method="post" name="cFrm">
                     <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Name</label>
                        <div class="col-sm-9">
                        	 <input name="cName" size="10" maxlength="8" placeholder="name" required class="form-control form-control-success">
                    
                        </div>
                      </div>
                     <div class="form-group row">
                        <label class="col-sm-3 form-control-label">Content</label>
                        <div class="col-sm-9">
                         	<textarea name="comment" rows="3" cols="10" placeholder="content" required  class="form-control form-control-warning"></textarea>
							
                        </div>
                      </div>
                      <input type="submit" value="Post" onclick="cInsert()"class="btn btn-primary">
                      <input type="hidden" name="flag" value="insert">
                     
                     
                     
					 <!-- 아래있는 변수들 재요청한다. 댓글쓸때 요청하면 모든 변수는 reset 된다. -->
					 <input type="hidden" name="num" value="<%=num%>">
					 <input type="hidden" name="cnum">
				    <input type="hidden" name="nowPage" value="<%=nowPage%>">
				    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
				   <%if(!(keyWord==null||keyWord.equals(""))){ %>
				    <input type="hidden" name="keyField" value="<%=keyField%>">
				    <input type="hidden" name="keyWord" value="<%=keyWord%>">
					<%}%>
					</form>
				  <!-- 댓글 입력폼 End -->
				  
				     <form method="post" name="downFrm" action="download.jsp">
					<input type="hidden" name="filename">
				</form>
				
				<form name="listFrm">
					<input type="hidden" name="nowPage" value="<%=nowPage%>">
					<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
					<%if(!(keyWord==null||keyWord.equals(""))){%>
					<input type="hidden" name="keyField" value="<%=keyField%>">
					<input type="hidden" name="keyWord" value="<%=keyWord%>">
					<%}%>
				</form>
				  <div class="block">
		                 <%
			                 Vector<BCommentBean> cvlist=cmgr.getBComment(num);
			             	if(!cvlist.isEmpty()){
		                 %>
		                 <div class="block-body">
		                <%
							for(int i=0; i<cvlist.size(); i++){
								BCommentBean cbean = cvlist.get(i);
								int cnum = cbean.getCnum();
								String cname = cbean.getName();
								String comment = cbean.getComment();
								String cregdate = cbean.getRegdate();
						%>
						
						<div class="form-group row">
                        <label class="col-sm-3 form-control-label"><%=cname%></label>
                        <div class="col-sm-9">
                          <textarea name="comment" rows="2" cols="10" placeholder="content" required  class="form-control form-control-warning"><%=comment%></textarea>
                          Leaved <%=cregdate%>
                          <div>
                           <input value="Delete" href="cDel('<%=cnum%>')" class="btn btn-primary">
                          </div>
                        </div>
                       
                        </div>
						<%}//for%> 
						
                		 </div>
                		</div>
                		<% }//--if%>
				  
                  </div>
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                   <a href="javascript:surveyList()" >List </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <a href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>&numPerPage=<%=numPerPage%>" >Modify</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <a href="reply.jsp?nowPage=<%=nowPage%>&numPerPage=<%=numPerPage%>" >Reply</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <a href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">Delete</a> <br/> 		
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