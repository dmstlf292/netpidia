package netpidia;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class BlogBoardMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/netpidia/admin/fileupload/";
	//private static final String UPLOAD = "C:/Jsp/myapp/WebContent/netpidia/admin/data/";
	public static final String ENCTYPE = "EUC-KR";
	public static int MAXSIZE = 10*1024*1024;
	
	public BlogBoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	//Member Login
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
		
		//Member Information
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
					
					bean.setGrade(rs.getString(5));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
	
	
	
	

	
	//BlogBoard Insert
	public void insertBlogBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			File dir = new File(SAVEFOLDER);
			if(!dir.exists())
				dir.mkdirs();
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER,MAXSIZE,ENCTYPE
							,new DefaultFileRenamePolicy());

			
			String filename = null;
			int filesize = 0;
			if(multi.getFilesystemName("filename")!=null) {
				//게시물에 파일 업로드
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			String content = multi.getParameter("content");//게시물 내용
			String contentType = multi.getParameter("contentType");//내용타입
			if(contentType.equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			//답변을 위한 ref 설정
			int ref = getMaxNum() + 1;
			/////////////////////////////////////
			con = pool.getConnection();
			sql = "insert tblBlogBoard(name,content,subject,ref,pos,depth,";
			sql += "regdate,pass,count,ip,filename,filesize,totalprice, price, cperson,email,id,netemail,image)";
			sql += "values( ?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
	
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, multi.getParameter("ip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			pstmt.setString(9, multi.getParameter("totalprice"));
			
			
			pstmt.setString(10, multi.getParameter("price"));
			pstmt.setString(11, multi.getParameter("cperson"));
			pstmt.setString(12, multi.getParameter("email"));
			pstmt.setString(13, multi.getParameter("id"));
			pstmt.setString(14, multi.getParameter("netemail"));
			
			
			 if(multi.getFilesystemName("image")!=null) 
				 pstmt.setString(15, multi.getFilesystemName("image")); 
			 else 
				 pstmt.setString(15, "cover.jpg");
			 
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//BlogBoard Max Num : num의 최대값
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblBlogBoard";
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
	
	//BlogBoard Total Count : 총 게시물수
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
				sql = "select count(*) from tblBlogBoard";
				pstmt = con.prepareStatement(sql);
			}else {
				//검색인 경우
				sql = "select count(*) from tblBlogBoard where " 
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
	
	//BlogBoard List : 검색 기능(keyField, keyWord)
	public Vector<BlogBoardBean> getBlogBoardList(String keyField, 
			String keyWord, int start, int cnt){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BlogBoardBean> vlist= new Vector<BlogBoardBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닐때
				sql = "select * from tblBlogBoard order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			}else {
				//검색일때
				sql = "select * from tblBlogBoard where " + keyField 
						+ " like ? order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BlogBoardBean bean = new BlogBoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				//여기 추가!!!!
				bean.setImage(rs.getString("image"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//BlogBoard Get : 한개의 게시물 리턴
		public BlogBoardBean getBlogBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			BlogBoardBean bean = new BlogBoardBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblBlogBoard where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setNum(rs.getInt("num"));
					bean.setName(rs.getString("name"));
					bean.setSubject(rs.getString("subject"));
					bean.setContent(rs.getString("content"));
					bean.setPos(rs.getInt("pos"));
					bean.setRef(rs.getInt("ref"));
					bean.setDepth(rs.getInt("depth"));
					bean.setRegdate(rs.getString("regdate"));
					bean.setPass(rs.getString("pass"));
					bean.setIp(rs.getString("ip"));
					bean.setCount(rs.getInt("count"));
					bean.setFilename(rs.getString("filename"));
					bean.setFilesize(rs.getInt("filesize"));
					bean.setTotalprice(rs.getString("totalprice"));
					
					
					bean.setPrice(rs.getString("price"));
					bean.setCperson(rs.getString("cperson"));
					bean.setEmail(rs.getString("email"));
					bean.setId(rs.getString("id"));
					bean.setNetemail(rs.getString("netemail"));
					bean.setImage(rs.getString("image"));
					
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
				sql = "update tblBlogBoard set count = count +1 where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
	//Like Count Up : 증가	
		
		
		
		
	
	//BlogBoard Delete : 파일업로드 파일 삭제
		public void deleteBlogBoard(int num, String filename) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				if(filename!=null&&!filename.equals("")) {
					File f= new File(SAVEFOLDER+filename);
					if(f.exists())
						UtilMgr.delete(SAVEFOLDER+filename);//파일 삭제
				}
				con = pool.getConnection();
				sql = "delete from tblBlogBoard where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	
		
		
		
		
		
		
		
	//BlogBoard Update : 파일업로드 수정  
	public void updateBlogBoard(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			int num = Integer.parseInt(multi.getParameter("num"));

			String name = multi.getParameter("name");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String filename = multi.getFilesystemName("filename");
			if(filename!=null&&!filename.equals("")) {
				//파일이 업로드 수정이 되면 기존에 파일은 삭제가 되어야 한다.
				BlogBoardBean bean = getBlogBoard(num);
				String tempfile = bean.getFilename();
				if(tempfile!=null&&!tempfile.equals("")) {
					//기존에 파일 있다면
					File f = new File(SAVEFOLDER+tempfile);
					if(f.exists()) {
						UtilMgr.delete(SAVEFOLDER+tempfile);
					}
				}
				int filesize = (int)multi.getFile("filename").length();
				sql = "update tblBlogBoard  name=?, subject=?, content=?,"
						+ "filename=?, filesize=? where num=?";
				pstmt = con.prepareStatement(sql);
	
				pstmt.setString(1, name);
				pstmt.setString(2, subject);
				pstmt.setString(3, content);
				pstmt.setString(4, filename);
				pstmt.setInt(5, filesize);
				pstmt.setInt(6, num);
			} else {
				sql = "update tblBlogBoard name=?, subject=?, content=? where num=?";
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, name);
				pstmt.setString(2, subject);
				pstmt.setString(3, content);
				pstmt.setInt(4, num);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}	
	

}






