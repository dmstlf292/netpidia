<%@page import="netpidia.MyprofileBean"%>
<%@page import="netpidia.MemberBean"%>
<%@page import="netpidia.PaidBean"%>
<%@page import="netpidia.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="paMgr" class="netpidia.PaidMgr"/>
<jsp:useBean id="mMgr" class="netpidia.MemberMgr"/>
<jsp:useBean id="fmgr" class="netpidia.MyprofileMgr"/>

<%
     String name = (String)request.getParameter("name");
     String email = (String)request.getParameter("email");
     String phone = (String)request.getParameter("phone");
     String address = (String)request.getParameter("address");
     String stotalPrice = (String)request.getParameter("totalPrice");
     int totalPrice = Integer.parseInt(stotalPrice);
     
     String id = (String)session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
	MemberBean bean = mMgr.getMember(id);	
	MyprofileBean fbean = fmgr.getMyprofile(id);
%>
<!-- PG사 이니식스 & 카카오페이 : 일반결제용 사이트 코드 TC0ONETIME /////    가맹점 식별코드 imp31381830 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Processing...</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <script>
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('imp31381830'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'inicis',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : 'Netpidia Payment',
            amount : <%=totalPrice%>,
            buyer_email : '<%=bean.getEmail()%>',
            buyer_name : '<%=bean.getName()%>',
            buyer_tel : '<%=fbean.getPhone()%>',
            buyer_addr : '<%=fbean.getAddress()%>',
            buyer_postcode : '123-456',
            m_redirect_url : 'http://netflix.com'
        }, function(rsp) {
            if (rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = 'Completed';
                        msg += '\nUnique id : ' + rsp.imp_uid;
                        msg += '\nStore transaction id : ' + rsp.merchant_uid;
                        msg += '\Amount : ' + rsp.paid_amount;
                        msg += 'Accept card number is ' + rsp.apply_num;
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
               location.href='<%=request.getContextPath()%>/netpidia/admin/paymentProc.jsp?apply_num='+rsp.apply_num+'&paid_amount='+rsp.paid_amount;
            } else {
                msg = 'Fail';
                msg += '에러내용 : ' + rsp.error_msg;
                alert(msg);
                //실패시 이동할 페이지
                location.href="<%=request.getContextPath()%>/netpidia/admin/paymentMethod.jsp";
            }
        });
    });
    </script> 
</body>
</html>
