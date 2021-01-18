<!-- orderProc.jsp -->
<%@page import="java.util.Enumeration"%>
<%@page import="netpidia.OrderBean"%>
<%@page import="java.util.Hashtable"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" scope="session" class="netpidia.CartMgr"/>
<jsp:useBean id="pMgr" class="netpidia.ProductMgr"/>
<jsp:useBean id="orderMgr" class="netpidia.OrderMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		//세션에 저장된 장바구니 리턴
		Hashtable<Integer, OrderBean> hCart = cMgr.getCartList();
		//Hashtable의 키값들을 리턴
		Enumeration<Integer> hCartKey = hCart.keys();
		String msg="";
		if(!hCart.isEmpty()){
			while(hCartKey.hasMoreElements()){
				//out.println("상품번호 : " + hCartKey.nextElement() + "<br>");
				//장바구니에 주문번호 키값으로 주문객체 리턴
				OrderBean order = hCart.get(hCartKey.nextElement());
				//DB에 주문처리
				orderMgr.insertOrder(order);
				//재고 정리
				pMgr.reduceProduct(order);
				//장바구니에 주문한 상품 삭제
				cMgr.deleteCart(order);
			}
			msg="Completed";
		}else{
			msg="Empty";
		}
%>
<script>
	alert("<%=msg%>");
	location.href="orderList.jsp";
</script>