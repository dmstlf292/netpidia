package netpidia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeyDAO {
	
	private DBConnectionMgr pool;

	public LikeyDAO() {
		pool = DBConnectionMgr.getInstance();
	}

	public int like(String id, int productNo, String ip) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0 ;
		try {
			con = pool.getConnection();
			sql = "INSERT tbllikey VALUES (?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, productNo);
			pstmt.setString(3, ip);
			cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return cnt; // 추천중복오류
	}
	
}
