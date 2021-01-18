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
		//���ǿ� ����� ��ٱ��� ����
		Hashtable<Integer, OrderBean> hCart = cMgr.getCartList();
		//Hashtable�� Ű������ ����
		Enumeration<Integer> hCartKey = hCart.keys();
		String msg="";
		if(!hCart.isEmpty()){
			while(hCartKey.hasMoreElements()){
				//out.println("��ǰ��ȣ : " + hCartKey.nextElement() + "<br>");
				//��ٱ��Ͽ� �ֹ���ȣ Ű������ �ֹ���ü ����
				OrderBean order = hCart.get(hCartKey.nextElement());
				//DB�� �ֹ�ó��
				orderMgr.insertOrder(order);
				//��� ����
				pMgr.reduceProduct(order);
				//��ٱ��Ͽ� �ֹ��� ��ǰ ����
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