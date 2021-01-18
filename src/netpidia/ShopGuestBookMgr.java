package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import netpidia.MemberBean;
import netpidia.CommentBean;
import netpidia.GuestBookBean;
import netpidia.DBConnectionMgr;

public class ShopGuestBookMgr {
	
	
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE =
			new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	private final SimpleDateFormat SDF_TIME =
			new SimpleDateFormat("H:mm:ss");
	
	public ShopGuestBookMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Join Login
	public boolean loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id=? and pwd =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			if(pstmt.executeQuery().next())
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//Join Information
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bean.setId(rs.getString(1));
				bean.setPwd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setEmail(rs.getString(4));
				
				bean.setGrade(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	public void insertShopGuestBook(ShopGuestBookBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblShopGuestBook(id,contents,ip,regdate,regtime,secret)"
					+ "values(?,?,?,now(),now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getContents());
			pstmt.setString(3, bean.getIp());
			pstmt.setString(4, bean.getSecret());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	

	public Vector<ShopGuestBookBean> listShopGuestBook(String id, String grade){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ShopGuestBookBean> vlist = new Vector<ShopGuestBookBean>();
		try {
			con = pool.getConnection();
			if(grade.equals("1")) {//관리자
				sql = "select * from tblShopGuestBook order by num desc";
				pstmt = con.prepareStatement(sql);
			}else if(grade.equals("0")){//일반 로그인 : 본인 + 다른 사람 일반글
				sql = "select * from tblShopGuestBook "
				+ "where id=? or secret='0' order by num desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ShopGuestBookBean bean = new ShopGuestBookBean();
				bean.setNum(rs.getInt("num"));
				bean.setId(rs.getString("id"));
				bean.setContents(rs.getString("contents"));
				bean.setIp(rs.getString("ip"));
				
				String tempDate = SDF_DATE.format(rs.getDate("regDate"));
				bean.setRegdate(tempDate);
				
				String tempTime = SDF_TIME.format(rs.getTime("regTime"));
				bean.setRegtime(tempTime);
				
				bean.setSecret(rs.getString("secret"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	public ShopGuestBookBean getShopGuestBook(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ShopGuestBookBean bean = new ShopGuestBookBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblShopGuestBook where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setId(rs.getString("id"));
				bean.setContents(rs.getString("contents"));
				bean.setIp(rs.getString("ip"));
				String tempDate = SDF_DATE.format(rs.getDate("regDate"));
				bean.setRegdate(tempDate);
				String tempTime = SDF_TIME.format(rs.getTime("regTime"));
				bean.setRegtime(tempTime);
				bean.setSecret(rs.getString("secret"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//ShopGuestBook Update 수정 : Contents, ip, secret
	public void updateShopGuestBook(ShopGuestBookBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblShopGuestBook set contents=?,ip=?,secret=? "
					+ "where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getContents());
			pstmt.setString(2, bean.getIp());
			pstmt.setString(3, bean.getSecret());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
	}
	
	
	public void deleteShopGuestBook(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblShopGuestBook where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	
	}

	public void insertShopComment(ShopCommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblShopComment(num,cid,comment,cip, cregDate)"+"values(?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getCid());
			pstmt.setString(3, bean.getComment());
			pstmt.setString(4, bean.getCip());
		    pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	

	public Vector<ShopCommentBean> shopListComment(int num){//db1이용
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ShopCommentBean> vlist=new Vector<ShopCommentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblShopComment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();//여긴 손 안댄다
			while(rs.next()) {
				ShopCommentBean bean = new ShopCommentBean();
				bean.setProductNo(rs.getInt("productNo"));//댓글번호
				bean.setNum(rs.getInt("num"));//방명록번호
				bean.setCid(rs.getString("cid"));//댓글 id
				bean.setComment(rs.getString("comment"));
				bean.setCip(rs.getString("cip"));
				
				String tempDate = SDF_DATE.format(rs.getDate("cregDate"));
				bean.setCregDate(tempDate);
				
				vlist.addElement(bean);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	

	public void deleteShopComment(int productNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblShopComment where productNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	public void deleteAllShopComment (int num) {//db2 이용
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblShopComment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
}
