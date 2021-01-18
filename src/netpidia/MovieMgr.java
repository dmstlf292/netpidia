package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.BoardBean;
import board.BoardMgr;

public class MovieMgr {
	
	
	private DBConnectionMgr pool;
	private static final String UPLOAD = "C:/Jsp/myapp/WebContent/netpidia/admin/data/";
	private static final String ENCTYPE = "EUC-KR";
	private static final int MAXSIZE = 10*1024*1024;
	
	public MovieMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Max Num : num의 최대값
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblMovie";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) maxNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	//insert
	public boolean insertMyprofile(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, UPLOAD, MAXSIZE,
					ENCTYPE, new DefaultFileRenamePolicy());
			con = pool.getConnection();
			sql ="insert tblMovie(name,title,story,nation,genre,grade,direc,actor,runtime,poster,";
			sql += "ref, pos, depth,regdate,rdate,viewCount,likeCount,hateCount,rateScore)";
			sql += 	"values(?,?,?,?,?,?,?,?,?,?,   ?,0,0,now(),?,0,0,0,0)";	
			
			int ref = getMaxNum() + 1;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, multi.getParameter("title"));
			pstmt.setString(3, multi.getParameter("story"));
			pstmt.setString(4, multi.getParameter("nation"));
			pstmt.setString(5, multi.getParameter("genre"));
			pstmt.setString(6, multi.getParameter("grade"));
			pstmt.setString(7, multi.getParameter("direc"));
			pstmt.setString(8, multi.getParameter("actor"));
			pstmt.setString(9, multi.getParameter("regdate"));
			pstmt.setString(10, multi.getParameter("runtime"));
			
			if(multi.getFilesystemName("poster")!=null)
				pstmt.setString(11, multi.getFilesystemName("poster"));
			else
				pstmt.setString(11, "null.jpg");
			
			pstmt.setInt(12, ref);
			pstmt.setString(13, multi.getParameter("rdate"));
			
			int cnt = pstmt.executeUpdate();
			if(cnt==1) flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	

	//Total Count : 총 게시물수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "select count(*) from tblMovie";
				pstmt = con.prepareStatement(sql);
			}else {
				//검색인 경우
				sql = "select count(*) from tblMovie where " 
				+ keyField +" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//검색 기능(keyField, keyWord)
	public Vector<MovieBean> getMovieList(String keyField, 
			String keyWord, int start, int cnt){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MovieBean> vlist= new Vector<MovieBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닐때
				sql = "select * from tblMovie order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			}else {
				//검색일때
				sql = "select * from tblMovie where " + keyField 
						+ " like ? order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieBean bean = new MovieBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setStory(rs.getString("story"));
				bean.setNation(rs.getString("nation"));
				bean.setGenre(rs.getString("genre"));
				bean.setGrade(rs.getString("grade"));
				bean.setDirec(rs.getString("direc"));
				bean.setActor(rs.getString("actor"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setRdate(rs.getString("rdate"));
				bean.setRuntime(rs.getString("runtime"));
				bean.setPoster(rs.getString("poster"));
				
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setViewCount(rs.getInt("viewCount"));
				bean.setLikeCount(rs.getInt("likeCount"));
				bean.setHateCount(rs.getInt("hateCount"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Get : 한개의 게시물, 13개 컬럼 모두 리턴
	public MovieBean getMovie(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MovieBean bean = new MovieBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblMovie where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setStory(rs.getString("story"));
				bean.setNation(rs.getString("nation"));
				bean.setGenre(rs.getString("genre"));
				bean.setGrade(rs.getString("grade"));
				bean.setDirec(rs.getString("direc"));
				bean.setActor(rs.getString("actor"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setRdate(rs.getString("rdate"));
				bean.setRuntime(rs.getString("runtime"));
				bean.setPoster(rs.getString("poster"));
				
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setViewCount(rs.getInt("viewCount"));
				bean.setLikeCount(rs.getInt("likeCount"));
				bean.setHateCount(rs.getInt("hateCount"));
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//Count Up : 조회수 증가
	public void upCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblMovie set viewCount = viewCount +1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Delete
	public boolean deleteMovie(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblMovie where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
	
	

	//Update(나중에 추가하기)
	
	
	
	
	
	//모든 평점을 평균내기
	public int rateAvg(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt = 0 ;
		try {
			con = pool.getConnection();
			sql = "select id,avg from tblRate group by id";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return cnt;
	}
	
	
}
