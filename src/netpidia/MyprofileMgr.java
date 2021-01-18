package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import shop.ProductBean;




public class MyprofileMgr {
	
	private DBConnectionMgr pool;
	private static final String UPLOAD = "C:/Jsp/myapp/WebContent/netpidia/admin/data/";
	private static final String ENCTYPE = "EUC-KR";
	private static final int MAXSIZE = 10*1024*1024;
	
	public MyprofileMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	
		//주소검색
		//select * from tblZipcode where area3 like ?
		public Vector<ZipcodeBean> searchZipcode(String area3){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
			try {
				con = pool.getConnection();
				sql = "select * from tblZipcode where area3 like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+area3+"%");// '%강남대로%'
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ZipcodeBean bean = new ZipcodeBean();
					bean.setZipcode(rs.getString(1));
					bean.setArea1(rs.getString(2));
					bean.setArea2(rs.getString(3));
					bean.setArea3(rs.getString(4));
					vlist.addElement(bean);//vlist.add 가능
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
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
					bean.setGrade(rs.getString(4));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		
	// Myprofile Insert 
		public boolean insertMyprofile(HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				MultipartRequest multi = new MultipartRequest(req, UPLOAD, MAXSIZE,
						ENCTYPE, new DefaultFileRenamePolicy());
				con = pool.getConnection();
				sql = "insert tblMyprofile(id,aboutme,phone,live,speak,fhp,ihp,image, name,zipcode,address)"+
						  "values(?,?,?,?,?,?,?,?, ?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("id"));
				pstmt.setString(2, multi.getParameter("aboutme"));
				pstmt.setString(3, multi.getParameter("phone"));
				pstmt.setString(4, multi.getParameter("live"));
				pstmt.setString(5, multi.getParameter("speak"));
				pstmt.setString(6, multi.getParameter("fhp"));
				pstmt.setString(7, multi.getParameter("ihp"));

				if(multi.getFilesystemName("image")!=null)
					pstmt.setString(8, multi.getFilesystemName("image"));
				else
					pstmt.setString(8, "null.jpg");

				pstmt.setString(9, multi.getParameter("name"));
				pstmt.setString(10, multi.getParameter("zipcode"));
				pstmt.setString(11, multi.getParameter("address"));
				int cnt = pstmt.executeUpdate();
				if(cnt==1) flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
	

		
	
		
		//Myprofile detail 정보가져오기
		public MyprofileBean getMyprofile(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MyprofileBean bean = new MyprofileBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblMyprofile where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setId(rs.getString("id"));
					bean.setAboutme(rs.getString("aboutme"));
					bean.setPhone(rs.getString("phone"));
					bean.setLive(rs.getString("live"));
					bean.setSpeak(rs.getString("speak"));
					bean.setFhp(rs.getString("fhp"));
					bean.setIhp(rs.getString("ihp"));
					bean.setImage(rs.getString("image"));
					bean.setName(rs.getString("name"));
					bean.setZipcode(rs.getString("zipcode"));
					bean.setAddress(rs.getString("address"));
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
			
			
			
		}
	
		//Myprofile 리스트 ==>관리자모드
		public Vector<MyprofileBean> getMyprofileList(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MyprofileBean> vlist= new Vector<>();
			try {
				con = pool.getConnection();
				sql = "select * from tblMyprofile";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MyprofileBean bean = new MyprofileBean();
					bean.setId(rs.getString("id"));
					bean.setAboutme(rs.getString("aboutme"));
					bean.setPhone(rs.getString("phone"));
					bean.setLive(rs.getString("live"));
					bean.setSpeak(rs.getString("speak"));
					bean.setFhp(rs.getString("fhp"));
					bean.setIhp(rs.getString("ihp"));
					bean.setImage(rs.getString("image"));
					bean.setName(rs.getString("name"));
					bean.setZipcode(rs.getString("zipcode"));
					bean.setAddress(rs.getString("address"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
	
		
		
		
		
		
		
		
		//Myprofile Update
		public boolean updateMyprofile(HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				MultipartRequest multi = new MultipartRequest(req, UPLOAD, MAXSIZE,
						ENCTYPE, new DefaultFileRenamePolicy());
				con = pool.getConnection();
				if(multi.getFilesystemName("image")!=null) {
					sql = "update tblMyprofile set aboutme=?, phone=?, live=?, speak=?, fhp=?, ihp=?, image=?, zipcode=?, address=? where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, multi.getParameter("aboutme"));
					pstmt.setString(2, multi.getParameter("phone"));
					pstmt.setString(3, multi.getParameter("live"));
					pstmt.setString(4, multi.getParameter("speak"));
					pstmt.setString(5, multi.getParameter("fhp"));
					pstmt.setString(6, multi.getParameter("ihp"));
					pstmt.setString(7, multi.getFilesystemName("image"));
					pstmt.setString(8, multi.getParameter("zipcode"));
					pstmt.setString(9, multi.getParameter("address"));	
					pstmt.setString(10, multi.getParameter("id"));	
				}else {
					sql = "update tblMyprofile set aboutme=?, phone=?, live=?, speak=?, fhp=?, ihp=?, zipcode=?, address=? where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, multi.getParameter("aboutme"));
					pstmt.setString(2, multi.getParameter("phone"));
					pstmt.setString(3, multi.getParameter("live"));
					pstmt.setString(4, multi.getParameter("speak"));
					pstmt.setString(5, multi.getParameter("fhp"));
					pstmt.setString(6, multi.getParameter("ihp"));
					pstmt.setString(7, multi.getParameter("zipcode"));
					pstmt.setString(8, multi.getParameter("address"));	
					pstmt.setString(9, multi.getParameter("id"));
				}
				if(pstmt.executeUpdate()==1) flag=true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
	
}
