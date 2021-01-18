package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class PaidMgr {//apply_num값 & paid_amount값을 DB에 연동
	
	
	private DBConnectionMgr pool;
	public PaidMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//Paid Amount Insert
	public void insertPaid(PaidBean paid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblPaid(apply_num) values(?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, paid.getApply_num());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	//Paid All List - admin mode
	public Vector<PaidBean> getPaidList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PaidBean> vlist= new Vector<PaidBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblPaid order by apply_num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PaidBean paid = new PaidBean();
				paid.setApply_num(rs.getInt("apply_num"));
				paid.setPaid_amount(rs.getInt("paid_amount"));
				vlist.addElement(paid);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	
	//Paid Detail
	public PaidBean getPaid (int apply_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		String sql = null;
		PaidBean paid = new PaidBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblPaid where apply_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, apply_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				paid.setApply_num(rs.getInt("apply_num"));
				paid.setPaid_amount(rs.getInt("paid_amount"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return paid;
	}
	



	
}
