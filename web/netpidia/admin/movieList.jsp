<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="netpidia.MovieBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="mgr" class="netpidia.MovieMgr"/>
<jsp:useBean id="cmgr" class="netpidia.MovieCommentMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			//���� ���ӵ� url��
			StringBuffer url = request.getRequestURL();
			response.sendRedirect("login.jsp?url="+url);
			return;//���Ŀ� jsp �ڵ� ���� �ȵ�.
		}
		MemberBean mbean = mMgr.getMember(id);
%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<title>Netpidia - Movie List Admin</title>
	<link rel="shortcut icon" href="img/minilogo.png"> 
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="author" content="">
	<link rel="profile" href="#">
    <link rel="stylesheet" href='http://fonts.googleapis.com/css?family=Dosis:400,700,500|Nunito:300,400,600' />
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="format-detection" content="telephone-no">
	<link rel="stylesheet" href="css/plugins.css">
	<link rel="stylesheet" href="css/style.css">
	
	
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	//crossDomain �ذ��ڵ�
	$(function() {
		$.ajaxPrefilter(function(options, originalOptions, jqXHR) {
			if (options.crossDomain && jQuery.support.cors) {
				options.url = "https://cors-anywhere.herokuapp.com/" + options.url;
			}
		});
	});

	//��ȸ�� ��¥�� ���
	var dt = new Date();

	//0(1��)���� �����ϱ⶧���� 1�����ֱ�
	var m = dt.getMonth() + 1;
	if (m < 10) { 
		var month = "0" + m;
	} else { 
		var month = m + ""; }

	//���� �ڽ����ǽ��� �ȳ����⶧���� ���� �ڽ����Ǹ� ������������ -1����
	var d = dt.getDate() - 1;
	if (d < 10) { 
		var day = "0" + d;
	} else { 
		var day = d + ""; }

	var y = dt.getFullYear();
	var year = y + "";

	var result = year + month + day;
	

	//õ�������� �޸�����ִ� �Լ�
	function addComma(num) {
		// ���ڿ� ���̰� 3�� ���ų� ���� ��� �Է� ���� �״�� ����
		if (num.length <= 3) {
			return num;
		}
		// 3�ܾ �ڸ� �ݺ� Ƚ�� ���ϱ�
		var count = Math.floor((num.length - 1) / 3);

		// ��� ���� ������ ����
		var result = "";

		// ���� ���ʿ��� 3���� �ڸ��� �޸�(,) �߰�
		for (var i = 0; i < count; i++) {

			// ������ ����(length)��ġ - 3 �� �Ͽ� �������ε������� ����° ���ڿ� �ε����� ���ϱ�
			var length = num.length;
			var strCut = num.substr(length - 3, length);
			// �ݺ����� ���� value ���� �ڿ��� ���� ���ڸ��� ���� ���ϵ�.

			// �Է°� ���ʿ��� 3���� ���ڿ��� �߶� ������ ������ �Է°� ����
			num = num.slice(0, length - 3);

			// �޸�(,) + �űԷ� �ڸ� ���ڿ� + ���� ��� ��
			result = "," + strCut + result;
		}
		// ���������� ������ ���� ���� ���� �Է°�(value)�� ���� ��� �տ� �߰�
		result = num + result;

		// ������ ����
		return result;
	}

	//�ڽ����ǽ� �ε��ϴ� �Լ�����
	$(function() {
		$.ajax({
					//&itemPerPage: 1-10�� ������ �����Ͱ� ��µǵ��� ����
					url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?key=df5e3a1e2892f4cb84d6c91c0d170ede&targetDt="
							+ result + "&itemPerPage=20",
					dataType : "xml",
					success : function(data) {
						var $data = $(data).find("boxOfficeResult>dailyBoxOfficeList>dailyBoxOffice");
						//�����͸� ���̺� ������ ����.
						if ($data.length > 0) {
							var table = $("<table/>").attr("class", "table");
							//<table>�ȿ� ���̺��� �÷� Ÿ��Ʋ �κ��� thead �±�
							var thead = $("<thead/>").append($("<tr/>"))
									.append(
											//�����ϰ��� �ϴ� �÷����� Ÿ��Ʋ ����
											$("<th width='100px'  style='background-color:#020d18'/>").html("Ranking"),
											$("<th width='500px' style='background-color:#020d18'/>").html("Title"),
											$("<th width='200px' style='background-color:#020d18'/>").html("Release date"),
											$("<th width='200px' style='background-color:#020d18'/>").html("Today's audience"),
											$("<th width='200px' style='background-color:#020d18'/>").html("Cumulative audience"));

							var tbody = $("<tbody align='center'/>");
							
							$.each($data, function(i, o) {
								//���� API�� ���ǵ� ������ ���� ������ ���� ������ �Ľ�
								var $rank = $(o).find("rank").text(); // ����
								var $movieNm = $(o).find("movieNm").text(); //��ȭ��
								var $openDt = $(o).find("openDt").text();// ��ȭ ������
								var $audiCnt = $(o).find("audiCnt").text(); //�ش����� ������
								var $audiAcc = $(o).find("audiAcc").text(); //���� ������

								//<tbody><tr><td>�±׾ȿ� �Ľ��Ͽ� ����� ������ �ֱ�
								var row = $("<tr style='background-color:#020d18'/>").append(
										$("<td style='background-color:#020d18'/>").text($rank),
										$("<td style='background-color:#020d18'/>").text($movieNm),
										$("<td style='background-color:#020d18'/>").text($openDt),
										$("<td style='background-color:#020d18'/>").text(addComma($audiCnt)),
										$("<td style='background-color:#020d18'/>").text(addComma($audiAcc)));

								tbody.append(row);

							});// end of each 

							table.append(thead);
							table.append(tbody);
							$(".wrap").append(table);

						}
					},
					//���� �߻��� "�ǽð� �ڽ����ǽ� �ε���"�޽����� �ߵ��� �Ѵ�.
					error : function() {
						alert("�ǽð� �ڽ����ǽ� �ε���...");
					}
				});
	}); //�ڽ����ǽ� �ε��ϴ� �Լ���
	
	
	
	
	
	
	
	//�˻���� �޾ƿ��� �Լ� ����	
	$(function() {
		// �߱޹��� ���̹� id�� ��ũ��Ű ������ ��������
		var XNaverClientId = "IZ4rKvVn6LRiAtMd92HV";
		var XNaverClientSecret = "QHZ_JqeKl1";

		$.popup = function() {
			$('.wrap3').css('display','block');
		}

		$.close = function() {
			$('.wrap3').css('display','none');
			
			//������ ��µ��ִ� ������ ��������
			$('#table2').remove();
		}

		// form���� �� �޾ƿ���
		$.serviceAPISearchBlog = function() {
			if ("" == $.trim($("#query").val())) {
				$("#query").val("�˻���");
			}

			$.ajax({
						crossDomain : true,
						context : this,
						traditional : true,
						//json ��û url
						url : "https://openapi.naver.com/v1/search/movie.json",
						method : "GET",
						type : "GET",
						dataType : "JSON",
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						headers : {
							//���̹����� �߱޹��� ���̵�� ��ũ��Ű �Է�
							"X-Naver-Client-Id" : XNaverClientId,
							"X-Naver-Client-Secret" : XNaverClientSecret
						},
						//Form�� ���� ��������
						data : $("#serviceAPISearchForm").serialize(),
						success : function(data, textStatus, jqXHR) {
							
							if (data != null) {
								//JSON�� ���ڿ��� �ٲ���
								var json = JSON.stringify(data);

								if (json.length > 0) {
									var table2 = $("<table/>").attr("id","table2");
									$('#table2').remove();
									
									//<table>�ȿ� ���̺��� �÷� Ÿ��Ʋ �κ��� thead �±�
									var thead2 = $("<thead/>").append(
											$("<tr/>")).append(
									//�����ϰ��� �ϴ� �÷����� Ÿ��Ʋ ����
											$("<th />").html("poster"),
											$("<th width='200px;'/>").html("title"),
											$("<th width='300px;'/>").html("director"),
											$("<th width='500px;'/>").html("actor"),
											$("<th width='100px;'/>").html("rate"));

									var tbody2 = $("<tbody/>");

									var item = JSON.parse(json);

									$.each(item.items, function(i) {
														var data = item.items;
														
														var title = data[i].title.replace(/<b>|<\/b>/g,'');
														var link = data[i].link
														var img = data[i].image;
														var director = data[i].director.replace('|','');
														var actor = data[i].actor.replace(/\|/g,' | ');
														var rate = data[i].userRating;

														var row2 = $("<tr/>").append(
																		//�������̹���Ŭ���� ��ũ�̵�
																		$("<td> <a href="+ link +"> <img id=\"img_src\" src="+ img +"></a> </td>"),
																		$("<td/>").text(title),
																		$("<td/>").text(director),
																		$("<td/>").text(actor),
																		$("<td/>").text(rate));

														tbody2.append(row2);

													});// end of each 

									table2.append(thead2);
									table2.append(tbody2);
									$(".wrap2").append(table2);

								}
							}
						},

						error : function(jqXHR, textStatus, errorThrown) { //����������
							var errorResponseCode = "";
							errorResponseCode += "readyState : ";
							errorResponseCode += jqXHR.readyState;
							if ("0" == jqXHR.readyState) {
								errorResponseCode += "-UNSENT";
							}
							if ("1" == jqXHR.readyState) {
								errorResponseCode += "-OPENED";
							}
							if ("2" == jqXHR.readyState) {
								errorResponseCode += "-HEADERS_RECEIVED";
							}
							if ("3" == jqXHR.readyState) {
								errorResponseCode += "-LOADING";
							}
							if ("4" == jqXHR.readyState) {
								errorResponseCode += "-DONE";
							}
							alert(errorResponseCode);
						},
						complete : function(jqXHR, textStatus) {
						}
					});
		}
	}); //�˻���� ����ϴ� �Լ� ��
</script>
</head>
<body>
<div id="preloader">
    <img class="logo" src="img/minilogo.png" alt="" width="119" height="58">
    <div id="status">
        <span></span>
        <span></span>
    </div>
</div>




<header class="ht-header">
	<div class="container">
		<nav class="navbar navbar-default navbar-custom">
				<div class="navbar-header logo">
				    <div class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					    <span class="sr-only">Toggle navigation</span>
					    <div id="nav-icon1">
							<span></span>
							<span></span>
							<span></span>
						</div>
				    </div>
				    <a href="index.jsp"><img class="logo" src="img/logo.png" alt="" width="119" height="58"></a>
			    </div>
				<div class="collapse navbar-collapse flex-parent" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav flex-child-menu menu-left">
						<li class="hidden">
							<a href="index.jsp"></a>
						</li>
						<li class="dropdown first">
							<a  href="index.jsp" >Home </a>
						</li>
						<li class="dropdown first">
							<a  href="movieList.jsp" >Movie </a>
						</li>
						<li class="dropdown first">
							<a  href="surveyList.jsp">Poll </a>
						</li>
						<li class="dropdown first">
							<a  href="productMgr.jsp" >Minishop </a>
						</li>
						<li class="dropdown first">
							<a  href="blogList.jsp" >Our Blog </a>
						</li>
						<li class="dropdown first">
							<a  href="orderList.jsp" >My page <i class="fa fa-angle-down" aria-hidden="true"></i></a>
						</li>
					</ul>
					<ul class="nav navbar-nav flex-child-menu menu-right">
						<%
							if(id==null){
						%>
						<li><a href="login.jsp">Log In</a></li>
						<li><a href="member.jsp">Sign Up</a></li>
						<%}else{ %>
						<li><a href="logout.jsp">Log Out</a></li>
						<%}%>
						<%if(mbean.getGrade().equals("1")){ %>
						<li class="btn signupLink"><a href="#">Post Movie List</a></li>
						<%}%>
					</ul>
				</div>
	    </nav>
	     <!-- top search form -->
	     <form name="serviceAPISearchForm" id="serviceAPISearchForm"	method="post" action="" onsubmit="return false;">
	<div id="mo_inline">
		<div id="MovieSearchInput"  class="top-search">	
			<input class="form-control" type="text" id="query"  name="query" placeholder="��ȭ������ �˻��ϼ���" value="" style="font-weight: bold; font-family:����" />
			<input type ="button" onclick="$.serviceAPISearchBlog(); $.popup();" value="Search">
			<!-- <button class="btn btn-default"  type="button" onclick="$.serviceAPISearchBlog(); $.popup();" style="background-color:#fa3246">
				<i class="glyphicon glyphicon-search"></i><span>Search</span>
			</button> -->
		</div>
	</div>					
</form>
</header>
<div class="hero common-hero">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="hero-ct">
					<h1>What do you want to know today?</h1>
					<ul class="breadcumb">
						<li class="active"><a href="index.jsp">Home</a></li>
						<li> <span class="ion-ios-arrow-right"></span> Netpidia Movie List - Admin</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="page-single movie_list">
	<div class="container" align="center">
		<div class="hero-ct">
			<h1>Real-time box office Ranking</h1>
		</div>
		</br>
		<div class="wrap"></div>
	</div>
</div>

<div class="page-single movie_list">
	<div class="wrap3" align="center">
		<div class="wrap2" id="popup" align="center"></div>
	</div>
</div>


<footer class="ht-footer">
	<div class="container">
		<div class="flex-parent-ft">
			<div class="flex-child-ft item1">
				 <a href="index.jsp"><img class="logo" src="img/logo.png" alt=""></a>
				 <p>�ּ�</p>
				<p>Call us: <a href="#">(+01) 202 342 6789</a></p>
			</div>
		</div>
	</div>
</footer>
<script src="js/jquery.js"></script>
<script src="js/plugins.js"></script>
<script src="js/plugins2.js"></script>
<script src="js/custom.js"></script>
</body>
</html>