package netpidia;

import java.util.Hashtable;

import netpidia.OrderBean;

public class CartMgr {
	private Hashtable<Integer, OrderBean> hCart
	= new Hashtable<Integer, OrderBean>();

	//Cart Add 
	public void addCart(OrderBean order) {
		int productNo = order.getProductNo();
		int quantity= order.getQuantity();
		if(quantity>0) {
			if(hCart.containsKey(productNo)) {
				OrderBean temp = hCart.get(productNo);
				quantity+=temp.getQuantity();
				order.setQuantity(quantity);
				hCart.put(productNo, order);
			} else {
				hCart.put(productNo, order);
			}
		}
		//System.out.println(hCart.size());
	}
	
	//Cart Update 
	public void updateCart(OrderBean order) {
		hCart.put(order.getProductNo(), order);
	}
	
	//Cart Delete
	public void deleteCart(OrderBean order) {
		hCart.remove(order.getProductNo());
	}
	
	//Cart List
	public Hashtable<Integer, OrderBean> getCartList(){
		return hCart;
	}

}
