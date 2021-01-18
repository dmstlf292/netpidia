package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class RateMgr {
	
	private DBConnectionMgr pool;
	
	public RateMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//평점내기
	public int rateScore(String id, int num, String ip, int rateScore) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 1 ;
		try {
			con = pool.getConnection();
			sql = "insert tblRate VALUES (?, ?, ?, 1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, num);
			pstmt.setString(3, ip);
			pstmt.setInt(4, rateScore);
			cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return cnt;
	}
	
	
	
	
	
}
