package netpidia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import netpidia.DBConnectionMgr;
import netpidia.PollItemBean;
import netpidia.PollListBean;

public class PollMgr {

	private DBConnectionMgr pool;
	
	public PollMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	
	//-------------------------관리자 모드-----------------------------
	//Max num
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblPollList";
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
	
	//Poll Insert
	public boolean insertPoll(PollListBean plBean, PollItemBean piBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			//tblPollList 저장 
			sql = "insert tblPollList(question,sdate,edate,wdate,type)"
					+ "values(?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, plBean.getQuestion());
			pstmt.setString(2, plBean.getSdate());
			pstmt.setString(3, plBean.getEdate());
			pstmt.setInt(4, plBean.getType());//1은 복수투표, 0은 단일투표
			int cnt = pstmt.executeUpdate();
			pstmt.close();
			//////////////////////////////////////////////////////////
			if(cnt==1/*정상적인 실행*/) {//for문 돌아야함
				sql="insert tblPollItem values(?,?,?,0)";
				pstmt = con.prepareStatement(sql);
				//for 문 돌려야한다, if 문 때문에
				int listNum = getMaxNum();//방금 저장된 설문 리스트 num값 
				String item[] = piBean.getItem();
				for (int i = 0; i < item.length; i++) {
					if(item[i]==null || item[i].trim().equals("")) 
						break;
					pstmt.setInt(1,listNum);//tblPollList에 num 값이다. 
					pstmt.setInt(2, i);//자동증가가 아니라서..
					pstmt.setString(3, item[i]);
					if(pstmt.executeUpdate()==1)
						flag=true;
				}
			}
			//////////////////////////////////////////////////////////////
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Poll List
	public Vector<PollListBean> getPollList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollListBean> vlist = new Vector<PollListBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblPollList order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PollListBean plBean = new PollListBean();
				plBean.setNum(rs.getInt("num"));
				plBean.setQuestion(rs.getString("question"));
				plBean.setSdate(rs.getString("sdate"));//DB 타입이 date이지만 String 가능
				plBean.setEdate(rs.getString("edate"));
				vlist.addElement(plBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Poll Read
	public PollListBean getPoll(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PollListBean plBean  = new PollListBean(); 
		try {
			con = pool.getConnection();
			sql = "select num, question, type, active from tblPollList where num=?";
			pstmt = con.prepareStatement(sql);
			if(num==0)
				num = getMaxNum();//num 값이 넘어오지 않을때는 가장 최신의 설문이 리턴
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				plBean.setNum(rs.getInt(1));
				plBean.setQuestion(rs.getString(2));
				plBean.setType(rs.getInt(3));
				plBean.setActive(rs.getInt(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return plBean;
	}

	//Poll Item List
	public Vector<String> getItemList(int listNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select item from tblPollItem where listNum=?";
			pstmt = con.prepareStatement(sql);
			if(listNum==0) listNum = getMaxNum();//가장 최신의 설문 아이템으로 리턴하는것
			pstmt.setInt(1, listNum);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				vlist.addElement(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Count Sum
	public int sumCount(int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int sum=0;
		try {
			con = pool.getConnection();
			sql = "select sum(count) from tblPollItem where listnum=?";
			pstmt = con.prepareStatement(sql);
			//listnum값이 0일수도 있다. 
			if(listNum==0) listNum = getMaxNum();
			pstmt.setInt(1, listNum);
			rs = pstmt.executeQuery();
			if(rs.next()) sum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sum;
	}
	
	//Poll Update
	public boolean updatePoll(int listNum, String itemNum[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update tblPollItem set count = count+1 " 
					+"where listNum=? and itemNum=?";
			pstmt = con.prepareStatement(sql);
			//배열들어와서 for문 들어가야함
			if(listNum==0) listNum=getMaxNum();
			for (int i = 0; i < itemNum.length; i++) {
				pstmt.setInt(1, listNum);
				pstmt.setInt(2, Integer.parseInt(itemNum[i]));
				//실행이 여러번 되어야 해서!!
				if(pstmt.executeUpdate()==1)
					flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Poll View 
	public Vector<PollItemBean> getView(int listNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollItemBean> vlist= new Vector<PollItemBean>();
		try {
			con = pool.getConnection();
			sql = "select item, count from tblPollItem where listNum=?";
			pstmt = con.prepareStatement(sql);
			/* if(listNum==0) listNum=getMaxNum(); */
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);//if 로직을 3항연산자로 리턴(ㅇㅇ?는 0이면 getMaxNum, 0이 아니면 listNum이다.
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PollItemBean piBean = new PollItemBean();
				//배열을 만들어야 한다.
				//빈즈를 배열로 만들었어서!
				String item[]=new String[1];
				item[0]=rs.getString("item");
				piBean.setItem(item);
				piBean.setCount(rs.getInt("count"));
				vlist.addElement(piBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Max Item Count
	public int getMaxCount(int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxCnt = 0;
		try {
			con = pool.getConnection();
			sql = "select max(count) from tblPollItem where listNum=?";
			pstmt = con.prepareStatement(sql);
			//listNum이 0이면 getMaxNum()
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);
			rs = pstmt.executeQuery();
			if(rs.next()) maxCnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxCnt;
	}
}
