<%@ page  contentType="text/html; charset=EUC-KR"%>
<%
	String id = "";
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}

	String nick = "";
	if (session.getAttribute("nick") != null) {
		nick = (String) session.getAttribute("nick");
	} else {
		nick = "NICK NULL";
	}
%>
<!doctype html>
<html lang="en" dir="ltr">>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="icon" href="favicon.ico" type="image/x-icon"/>
<title>Chat</title>
<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/plugins/dropify/css/dropify.min.css">
<link rel="stylesheet" href="assets/css/main.css"/>
<link rel="stylesheet" href="assets/css/theme1.css"/>
<script type="text/javascript">
	
	//������ ����
	var webSocket = new WebSocket('ws://192.168.2.17:8005/netpidia/admin/broadcasting');
	var inputMessage = document.getElementById('inputMessage');
	//���� �̰� ������ ������ �̸� �Ǻ��� ����
	var re_send = "";

	webSocket.onerror = function(event) {
		onError(event)
	};
	webSocket.onopen = function(event) {
		onOpen(event)
	};
	webSocket.onmessage = function(event) {
		onMessage(event)
	};

	//	OnClose�� �� ������ ������ �� �����ϴ� �Լ�.
	function onClose(event){
		var div=document.createElement('div');
		
		//�������� �� �����ڵ鿡�� �˸� ����.
		webSocket.send("<%=nick%> is DisConnected\n");
	}

	//	OnMessage�� Ŭ���̾�Ʈ���� ���� ������ �޽����� ������ ȣ��Ǵ� �Լ�.
	function onMessage(event) {

		//Ŭ���̾�Ʈ���� ���ƿ� �޽����� |\| ������ �и��Ѵ�
		var message = event.data.split("|\|");
		
			//�ݹ� ���� �̸� re_send�� �����ϰ�,
			//�ݹ� ���� �̰� �ٽ� ������� ������ ��� ������ ��.
			if(message[0] != re_send){
				//messageWindow2�� ���̱�
				var who = document.createElement('div');

				who.style["padding"]="3px";
				who.style["margin-left"]="3px";

				who.innerHTML = message[0];
				document.getElementById('messageWindow2').appendChild(who);

				re_send = message[0];
			}
		
			//div�� ���� �޽��� ����� ����.
			var div=document.createElement('div');
		
			div.style["width"]="auto";
			div.style["word-wrap"]="break-word";
			div.style["display"]="inline-block";
			div.style["background-color"]="#fcfcfc";
			div.style["border-radius"]="3px";
			div.style["padding"]="3px";
			div.style["margin-left"]="3px";

			div.innerHTML = message[1];
			document.getElementById('messageWindow2').appendChild(div);
		
		//clear div �߰�. �ٹٲ޿�.		
		var clear=document.createElement('div');
		clear.style["clear"]="both";
		document.getElementById('messageWindow2').appendChild(clear);
		
		//div ��ũ�� �Ʒ���.
		messageWindow2.scrollTop = messageWindow2.scrollHeight;
		
	}

	//	OnOpen�� ���� ������ Ŭ���̾�Ʈ�� �� ���� ������ �Ǿ��� �� ȣ��Ǵ� �Լ�.
	function onOpen(event) {
		
		//�������� ��, �� ������ ���̴� ��.
		var div=document.createElement('div');
		
		div.style["text-align"]="center";
		
		div.innerHTML = "�ݰ����ϴ�.";
		document.getElementById('messageWindow2').appendChild(div);
		
		var clear=document.createElement('div');
		clear.style["clear"]="both";
		document.getElementById('messageWindow2').appendChild(clear);
		
		//�������� �� �����ڵ鿡�� �˸� ����.
		webSocket.send("<%=nick%>|\|�ȳ��ϼ���^^");
	}

	//	OnError�� �� ������ ������ ���� �߻��� �ϴ� �Լ�.
	function onError(event) {
		alert("chat_server connecting error " + event.data);
	}
	
	// send �Լ��� ���ؼ� ���������� �޽����� ������.
	function send() {

		//inputMessage�� �������� ���۰���
		if(inputMessage.value!=""){
			
			//	������ ������ ���ư��� ��.
			webSocket.send("<%=nick%>|\|" + inputMessage.value);
			
			// ä��ȭ�� div�� ���� ����
			var div=document.createElement('div');
			
			div.style["width"]="auto";
			div.style["word-wrap"]="break-word";
			div.style["float"]="right";
			div.style["display"]="inline-block";
			div.style["background-color"]="#ffea00";
			div.style["padding"]="3px";
			div.style["border-radius"]="3px";
			div.style["margin-right"]="3px";

			//div�� innerHTML�� ���� �ֱ�
			div.innerHTML = inputMessage.value;
			document.getElementById('messageWindow2').appendChild(div);

			//clear div �߰�
			var clear = document.createElement('div');
			clear.style["clear"] = "both";
			document.getElementById('messageWindow2').appendChild(clear);
			
			//	?
			//inputMessage.value = "";

			//	inputMessage�� value���� �����.
			inputMessage.value = '';

			//	textarea�� ��ũ���� �� ������ ������.
			messageWindow2.scrollTop = messageWindow2.scrollHeight;
			
			//	�ݹ� ���� ����� �ӽ� �����Ѵ�.
			re_send = "<%=nick%>";
		}//inputMessage�� �������� ���۰��� ��.
		
	}
</script>
</head>
<body class="font-montserrat">
<div class="page-loader-wrapper">
    <div class="loader">
    </div>
</div>
<div id="main_content">    
    <div id="header_top" class="header_top">
        <div class="container">
            <div class="hleft">
                <a class="header-brand" href="main.jsp"><i class="fa fa-soccer-ball-o brand-logo"></i></a>
               
            </div>
            <div class="hright">
                <div class="dropdown">
                  
                    <a href="javascript:void(0)" class="nav-link icon menu_toggle"><i class="fa  fa-align-left"></i></a>
                </div>            
            </div>
        </div>
    </div>

 

    <div id="left-sidebar" class="sidebar ">
        <h5 class="brand-name">Name <a href="javascript:void(0)" class="menu_option float-right"><i class="icon-grid font-16" data-toggle="tooltip" data-placement="left" title="Grid & List Toggle"></i></a></h5>
        <nav id="left-sidebar-nav" class="sidebar-nav">
            <ul class="metismenu">
                <li class="g_heading">Chat</li>                    
                <li><a href="main.jsp"><i class="fa fa-dashboard"></i><span>Back</span></a></li>                        
                
            </ul>
        </nav>        
    </div>

    <div class="page">
        <div class="section-light py-3 chat_app">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 col-md-12">
                    <input id="inputMessage" type="text" onkeydown="if(event.keyCode==13){send();}" />
<input type="submit" value="send" onclick="send();" />
<div id="messageWindow2" style="padding:10px 0;height: 20em; overflow: auto; background-color: #a0c0d7;"></div>
                       <!--  <div class="card bg-none b-none">
                            <div class="card-header bline bg-none">
                                <h3 class="card-title">Chat now </h3>
                                
                            </div>                        
                            <div class="chat_windows" id="chat">
                                <ul class="mb-0">
                                    <li class="other-message">
                                        <img class="avatar mr-3" src="assets/images/xs/avatar2.jpg" alt="avatar">
                                        <div class="message">
                                            <p class="bg-light-blue">Are we meeting today?</p>
                                            
                                        </div>
                                    </li>    
                                </ul>
                                <div id="chatList" ></div>
                                <div class="chat-message clearfix">
                                    <div class="input-group mb-0">
                                   		<input id="inputMessage" type="text" id="chatContent" class="form-control" onkeydown="if(event.keyCode==13){send();}" placeholder="Enter text here..."/>
                                    </div>
                                     <div>
	                                	<input class="btn btn-default pull-right" type="submit" value="send" onclick="send();" />
	                                </div>
                                </div>  
                            </div>
                        </div> -->
                </div>
            </div>
            <div class="chat_list section-white" id="users">
                <a href="javascript:void(0)" class="chat_list_btn float-right"><i class="fa  fa-window-close"></i></a>
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="users-tab" data-toggle="tab" href="#users-list" role="tab" aria-controls="users-list" aria-selected="true">Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="groups-tab" data-toggle="tab" href="#groups" role="tab" aria-controls="groups" aria-selected="false">Groups</a>
                    </li>                    
                </ul>
                <div class="input-group mt-2 mb-2">
                    <input type="text" class="form-control search" placeholder="Search...">
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="users-list" role="tabpanel" aria-labelledby="users-tab">
                        
                    </div>
                    <div class="tab-pane fade" id="groups" role="tabpanel" aria-labelledby="groups-tab">
                       
                    </div>
                </div>
            </div>
        </div>        
    </div>
</div>


<!-- Add New Task -->
<div class="modal fade" id="addtask" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="title" id="defaultModalLabel">Add Picture</h6>
            </div>
            <div class="modal-body">
                <input type="file" class="dropify">
                <small class="text-danger">Recommended image size is 5MB</small>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary">Add</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="assets/bundles/lib.vendor.bundle.js"></script>

<script src="assets/plugins/dropify/js/dropify.min.js"></script>

<script src="assets/js/core.js"></script>

</body>

<!-- soccer/project/app-chat.html  07 Jan 2020 03:40:36 GMT -->
</html>