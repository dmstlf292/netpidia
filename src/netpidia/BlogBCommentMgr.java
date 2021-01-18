package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;



public class BlogBCommentMgr {

	
	private DBConnectionMgr pool;
	public BlogBCommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	
	
	

	//Comment List
		public Vector<BlogBCommentBean> getBlogBComment(int num){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			 Vector<BlogBCommentBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				sql = "select * from tblBlogBComment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				while(rs.next()){
					BlogBCommentBean bean = new BlogBCommentBean();
					bean.setCnum(rs.getInt("cnum"));
					bean.setId(rs.getString("id"));
					bean.setName(rs.getString("name"));
					bean.setComment(rs.getString("comment"));
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
		public void insertBlogBComment(BlogBCommentBean bean){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert tblBlogBComment(id,name,comment,regdate,num) "
						+ "values(?,?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getId());
				pstmt.setString(2, bean.getName());
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
		public int getBlogBCommentCount(int num){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int count  = 0;
			try {
				con = pool.getConnection();
				sql = "select count(num) from tblBlogBComment where num=?";
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
		public void deleteBlogBComment(int cnum){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblBlogBComment where cnum=?";
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
		public void deleteAllBlogBComment(int num){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblBlogBComment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	
	
	
	
	
}
