package netpidia;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class ProductMgr {
	
	private DBConnectionMgr pool;
	private static final String UPLOAD = "C:/Jsp/myapp/WebContent/netpidia/admin/data/";
	private static final String ENCTYPE = "EUC-KR";
	private static final int MAXSIZE = 10*1024*1024;

	public ProductMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	

	
	
	//Product List
	public Vector<ProductBean> getProductList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "select productNo, name, price, date, stock, image from tblProduct "
					+ "order by productNo desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setProductNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(3));
				bean.setDate(rs.getString(4));
				bean.setStock(rs.getInt(5));
				bean.setImage(rs.getString(6));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Product Detail
	public ProductBean getProduct(int productNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean bean = new ProductBean();
		try {
			con = pool.getConnection();
			sql = "select productNo, name, price, detail, date, stock, image "
					+ "from tblProduct where productNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setProductNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(3));
				bean.setDetail(rs.getString(4));
				bean.setDate(rs.getString(5));
				bean.setStock(rs.getInt(6));
				bean.setImage(rs.getString(7));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//
	public void reduceProduct(OrderBean order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblProduct set stock = stock-? where productNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order.getQuantity());
			pstmt.setInt(2, order.getProductNo());
			pstmt.executeUpdate();
		} catch (Exception e) {
				e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//admin mode
    //Product Insert 
	public boolean insertProduct(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, UPLOAD, MAXSIZE,
					ENCTYPE, new DefaultFileRenamePolicy());
			con = pool.getConnection();
			sql = "insert tblProduct(name,price,detail,date,stock,image)"+
					  "values(?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
			pstmt.setString(3, multi.getParameter("detail"));
			pstmt.setString(4, SUtilMgr.getDay());
			pstmt.setInt(5, Integer.parseInt(multi.getParameter("stock")));
			
			if(multi.getFilesystemName("image")!=null)
				pstmt.setString(6, multi.getFilesystemName("image"));
			else
				pstmt.setString(6, "ready.gif");
			int cnt = pstmt.executeUpdate();
			
			if(cnt==1) flag = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Product Update
	public boolean updateProduct(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, UPLOAD, MAXSIZE,
					ENCTYPE, new DefaultFileRenamePolicy());
			con = pool.getConnection();
			if(multi.getFilesystemName("image")!=null) {
			
				sql = "update tblProduct set name=?, price=?, "
						+ "detail=?, stock=?, image=? where productNo=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("stock")));
				pstmt.setString(5, multi.getFilesystemName("image"));
				pstmt.setInt(6, Integer.parseInt(multi.getParameter("productNo")));
			}else {
				
				sql = "update tblProduct set name=?, price=?, "
						+ "detail=?, stock=? where productNo=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("stock")));
				pstmt.setInt(5, Integer.parseInt(multi.getParameter("productNo")));
			}
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Product Delete
	public boolean deleteProduct(int productNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblProduct where productNo=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
}
