package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import netpidia.CommentBean;
import netpidia.DBConnectionMgr;
import netpidia.GuestBookBean;
import netpidia.MemberBean;

public class GuestBookMgr {

	
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE =
			new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	private final SimpleDateFormat SDF_TIME =
			new SimpleDateFormat("H:mm:ss");
	
	public GuestBookMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Member Login(join 대체)
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
					bean.setGender(rs.getString(4));
					bean.setBirthday(rs.getString(5));
					bean.setEmail(rs.getString(6));
					////taste 배열/////
					bean.setGrade(rs.getString(8));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		
		//GuestBook Insert
		public void insertGuestBook(GuestBookBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert tblGuestBook(id,contents,ip,regdate,regtime,secret)"
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
		
		//GuestBook List
		public Vector<GuestBookBean> listGuestBook(String id, String grade){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<GuestBookBean> vlist = new Vector<GuestBookBean>();
			try {
				con = pool.getConnection();
				if(grade.equals("1")) {//관리자
					sql = "select * from tblGuestBook order by num desc";
					pstmt = con.prepareStatement(sql);
				}else if(grade.equals("0")){//일반 로그인 : 본인 + 다른 사람 일반글
					sql = "select * from tblGuestBook "
					+ "where id=? or secret='0' order by num desc";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					GuestBookBean bean = new GuestBookBean();
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
		
		//GuestBook Read : 날짜와 시간은 list 동일하게
		public GuestBookBean getGuestBook(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			GuestBookBean bean = new GuestBookBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblGuestBook where num=?";
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
		
		//GuestBook Update 수정 : Contents, ip, secret
		public void updateGuestBook(GuestBookBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update tblGuestBook set contents=?,ip=?,secret=? "
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
			//return; 여기서 리턴 안하네...? 왜?/// 수정이라서 그런가.?
		}
		
		//GuestBook Delete 삭제
		public void deleteGuestBook(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblGuestBook where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			//return; 여기서 리턴 안하네...? 왜?/// 수정이라서 그런가.?
		}

		
		
		
		
		
		/////댓글 Comment 기능 4가지/////////// 
		////Comment Insert////db2 사용
		public void insertComment(CommentBean bean) {//void 써주는 이유? 기능은 뭐지? 리턴하는 값이 없다는뜻
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				//cnum은 댓글번호
				//cnum은 없다 + ?물음표도 사용하지 않는다!왜냐면 자동증가라서!, reg는 registe의 약자
				//자동증가는 우리가 넣는 것이아니고 하이큐db에서 알아서 넣어주기 때문
				//자동증가는 자동증가라서 쿼리문에 안쓰는것
				
				sql = "insert tblComment(num,cid,comment,cip, cregDate)"+"values(?,?,?,?,now())";
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
		
		////Comment List////db1 사용
		public Vector<CommentBean> listComment(int num){//db1이용
			//날짜는 SDF_DATE 타입으로 세팅하기 
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<CommentBean> vlist=new Vector<CommentBean>();
			try {
				con = pool.getConnection();
				sql = "select * from tblComment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();//여긴 손 안댄다
				while(rs.next()) {
					CommentBean bean = new CommentBean();
					bean.setCnum(rs.getInt("cnum"));//댓글번호
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
		
		
		////Comment Delete : 댓글 삭제//// db2 사용
		public void deleteComment(int cnum) {//cnum은 댓글번호
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblComment where cnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
		////Comment All Delete : 방명록 글 삭제시 관련된 댓글 모두 삭제 ////
		public void deleteAllComment (int num) {//db2 이용
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblComment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				//업데이트를 몇개했는지 알지 않아도 되어서 int cnt 없앤것 같아요
				pstmt.executeUpdate();//int cnt = pstmt.executeUpdate();를 왜 이렇게 변경해서 pstmt.executeUpdate();로 쓰는지?
				
				//그럼 db1에서는 pstmt.executeQuery(); 사용하는 이유? 먼저 사용한 적 있는지 확인하기
				//pstmt.executeQuery(); 자체로만 사용하지는 않고, 항상 rs = pstmt.executeQuery();이런식으로 완전체로만 사용하던지 혹은
				//아니면 if(pstmt.executeQuery().next()); flag = true; 이렇게 사용
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
	
	
	
	
	
}
