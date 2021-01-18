package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class OrderMgr {
	
	private DBConnectionMgr pool;
	
	public OrderMgr() {
		pool = DBConnectionMgr.getInstance();
	}	
	
	//Order Insert 
	public void insertOrder(OrderBean order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblOrder(id,quantity,date,state)"
					+ "values(?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, order.getId()); 
			pstmt.setInt(2, order.getQuantity()); 
			pstmt.setString(3, SUtilMgr.getDay());
			pstmt.setString(4, "1");
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//Order List
	public Vector<OrderBean> getOrderList(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder where id=? order by productNo desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setProductNo(rs.getInt("productNo"));
				order.setId(rs.getString("id"));
				order.setQuantity(rs.getInt("quantity"));
				order.setDate(rs.getString("date"));
				order.setState(rs.getString("state"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//admin mode//
	//Order All List
	public Vector<OrderBean> getOrderList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder order by productNo desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setProductNo(rs.getInt("productNo"));
				order.setId(rs.getString("id"));
				order.setQuantity(rs.getInt("quantity"));
				order.setDate(rs.getString("date"));
				order.setState(rs.getString("state"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Order Detail 
	public OrderBean getOrderDetail(int productNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		OrderBean order = new OrderBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder where productNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order.setProductNo(rs.getInt("productNo"));
				order.setId(rs.getString("id"));
				order.setQuantity(rs.getInt("quantity"));
				order.setDate(rs.getString("date"));
				order.setState(rs.getString("state"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return order;
	}
	
	//Order Update
	public boolean updateOrder(int productNo, String state){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblOrder set state=? where productNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setInt(2, productNo);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Order Delete
	public boolean deleteOrder(int productNo){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblOrder where productNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
}
