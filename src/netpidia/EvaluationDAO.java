package netpidia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.fabric.xmlrpc.base.Array;

public class EvaluationDAO {

	
	private DBConnectionMgr pool;

	public EvaluationDAO() {
		pool = DBConnectionMgr.getInstance();
	}

	public int write(EvaluationDTO evaluationDTO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO tblEva VALUES (NULL, ?, ?, ?, ?, ?, ?, 0);";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, evaluationDTO.getId());
			pstmt.setString(2, evaluationDTO.getTitle());
			pstmt.setString(3, evaluationDTO.getContent());
			pstmt.setString(4, evaluationDTO.getTotalScore());
			pstmt.setString(5, evaluationDTO.getTotalRate());
			pstmt.setString(6, evaluationDTO.getMonth());
			cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return cnt;
	}

	//////좋아요 기능을 위한 4가지 메소드 더 추가////	
	public ArrayList<EvaluationDTO> getList(String title, String searchType, String search, int pageNumber) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		if(title.equals("total")) {
			title = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		try {
			con = pool.getConnection();
			if(searchType.equals("recently")) {
				sql = "SELECT * FROM tblEva WHERE title LIKE ? AND CONCAT(content) LIKE ? ORDER BY productNo DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if(searchType.equals("like")) {
				sql = "SELECT * FROM tblEva WHERE title LIKE ? AND CONCAT(content) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + title + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getInt(8)
				);
				evaluationList.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return evaluationList;
	}

	public int like(int productNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			con = pool.getConnection();
			sql = "UPDATE tblEva SET likeCount = likeCount + 1 WHERE productNo = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return cnt;
	}

	public int delete(int productNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM tblEva WHERE productNo = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return cnt;
	}
	
	public String getUserID(int productNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String id = null;
		try {
			con = pool.getConnection();
			sql = "SELECT id FROM tblEva WHERE productNo = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				 id = rs.getString("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return id;
	}
}

