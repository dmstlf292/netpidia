/////////////////////////////Netpidia Member///////////////////////////
///hobby[]   ----->   taste[] 이걸로 바꾸고
// job은 삭제함
package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import netpidia.DBConnectionMgr;
import netpidia.MemberBean;
import netpidia.MemberMgr;
import netpidia.ZipcodeBean;

public class MemberMgr {

	private DBConnectionMgr pool;
	
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	/////////////////////사용자 모드//////////////////////////////////////
	//id 중복 체크 : 중복 -> true
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag  = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//주소검색
	public Vector<ZipcodeBean> zipcodeRead(String area3){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+area3+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				vlist.addElement(bean);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	//회원가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblMember(id,pwd,name,gender,"
					+ "birthday,email,taste)"
					+ "values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getEmail());
			///////////////////////////////////	
			String taste[] = bean.getTaste();
			char ts[] = {'0','0','0','0','0','0','0','0','0','0'};
			String lists[] = {"SF, 판타지, 공포/스릴러, 드라마, 미스터리, 어드벤쳐, 코미디, 애니메이션, 액션, 멜로"}; 
			if(taste!=null) { //
			for (int i = 0; i < taste.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if(taste[i].equals(lists[j])) {
						ts[j] = '1';
						break;
					}//---if
				}//---for2
			}//---for1
			//new String(char value[])
			}
			pstmt.setString(7, new String(ts));
			///////////////////////////////////
		
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//로그인 : 성공 -> true
	public int loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int mode = 0;
		// 0-id false, 1-id true pass-false, 2-id&pass true
		try {
			if (!checkId(id))
				return mode;
			con = pool.getConnection();
			sql = "select id, pwd from tblMember where id = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next())
				mode = 2;
			else
				mode = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mode;
	}
	
	
	
	
	
	
	//회원정보가져오기 detail
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				bean.setGrade(rs.getString("grade"));//여기 코드 추가!!!
				///////////////////////////////////////////
				String taste = rs.getString("taste");
				String ts[] = new String[taste.length()];
				for (int i = 0; i < ts.length; i++) {
					ts[i] = taste.substring(i, i+1);
				}
				bean.setTaste(ts);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	//회원정보수정
	public boolean updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblMember set pwd=?, name=?, gender=?, birthday=?, email=? taste=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getEmail());
			//////////////////////////////////////////////////
			String lists[] = {"SF","판타지","공포/스릴러","드라마","미스터리","어드벤쳐","코미디","애니메이션","액션","멜로"}; 
			String taste[] = bean.getTaste();
			char ts[] = {'0','0','0','0','0','0','0','0','0','0'};
			for (int i = 0; i < taste.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if(taste[i].equals(lists[j])) {
						ts[j] = '1';
						break;
					}
				}
			}
			pstmt.setString(6, new String(ts));
			///////////////////////////////////
			pstmt.setString(7, bean.getId());
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	//회원탈퇴하기(delete-db2)
		public boolean deleteMember(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag=false;
			try {
				con = pool.getConnection();
				sql = "delete from tblMember where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				/* int cnt = pstmt.executeUpdate(); */
				pstmt.executeUpdate();//여기 추가함, upgrade
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		

	//Send id, pwd --> 구글을 연동해서 회원가입 축하 이메일 보낼 예정
	public void sendAccount(String id) {//id : aaa로 넘어가면 받아야한다.
		MemberMgr mgr = new MemberMgr();
		MemberBean bean = mgr.getMember(id);
		String pwd = bean.getPwd();
		String title = "OOO.com 에서 아이디와 비밀번호를 전송합니다.";
		String content = "<font color='red'><b>id :" +id;
		content+=" / pwd : " +pwd +"</b></font>";
		String toEmail = bean.getEmail();
		MailSend.send(title, content, toEmail);
		}
	
}
