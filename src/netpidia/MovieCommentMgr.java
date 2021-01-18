package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class MovieCommentMgr {
	
	private DBConnectionMgr pool;
	
	public MovieCommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Comment List
	
	public Vector<MovieCommentBean> getMovieComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		 Vector<MovieCommentBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblMovieComment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MovieCommentBean bean = new MovieCommentBean();
				bean.setCnum(rs.getInt("cnum"));
				bean.setId(rs.getString("id"));
				bean.setOpinion(rs.getString("opinion"));
				bean.setComment(rs.getString("comment"));
				bean.setRateScore(rs.getInt("rateScore"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setNum(rs.getInt("num"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	//Comment Insert
		public void insertComment(MovieCommentBean bean){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert tblMovieComment(id,opinion,comment,rateScore,regdate,num) "
						+ "values(?,?,?,1,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getId());
				pstmt.setString(2, bean.getOpinion());
				pstmt.setString(3, bean.getComment());
				pstmt.setInt(4, bean.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	
		//Comment Count
		public int getMovieCommentCount(int num){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int count  = 0;
			try {
				con = pool.getConnection();
				sql = "select count(num) from tblMovieComment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next())
					count = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return count;
		}

		
		//Comment Delete
		public void deleteComment(int cnum){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblMovieComment where cnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	
		//Comment All Delete
		public void deleteAllComment(int num){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblMovieComment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		
		
		
		
		
		
		
		
		//평점 주는 메소드
		public int rateScore(int cnum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			int cnt = 1;
			try {
				con = pool.getConnection();
				sql = "update tblMovieComment set rateScore where cnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				cnt = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return cnt;
		}
		//한개의 id만 허용
		public String id(int cnum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String id = null;
			try {
				con = pool.getConnection();
				sql = "select id from tblMovieComment where cnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					id=rs.getString("id");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return id;
		}
		

	
}
