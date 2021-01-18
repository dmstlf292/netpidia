package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import shop.ProductBean;

public class ContactMgr {
	
	private DBConnectionMgr pool;
	
	public ContactMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<ContactBean> getContactList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ContactBean> vlist = new Vector<ContactBean>();
		try {
			con = pool.getConnection();
			sql = "select no, name, email, phone, subject, message from tblContact order by no desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ContactBean bean = new ContactBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setPhone(rs.getString(4));
				bean.setSubject(rs.getString(5));
				bean.setMessage(rs.getString(6));
			
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public ContactBean getContact(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ContactBean bean = new ContactBean();
		try {
			con = pool.getConnection();
			sql = "select no, name,email,phone,subject,message from tblContact where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setPhone(rs.getString(4));
				bean.setSubject(rs.getString(5));
				bean.setMessage(rs.getString(6));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public boolean insertContact(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "";
			pstmt = con.prepareStatement(sql);
			int cnt = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}
