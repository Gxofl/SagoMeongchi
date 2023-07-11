package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class SubCategoryDAO {
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement ps;
	private static SubCategoryDAO subcdao;
	
	public static SubCategoryDAO getInstance() {
		if(subcdao==null) {
			subcdao = new SubCategoryDAO();
		}
		return subcdao;
	}
	
	private SubCategoryDAO() {
		Context initContext; 
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
			System.out.println("conn:" + conn);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//생성자
	
	public ArrayList<SubCategoryBean> getAllSubCategory(String supercname){
		ArrayList<SubCategoryBean> subCategory = new ArrayList<SubCategoryBean>();
		SubCategoryBean scb = null;
		String sql = "select * from subcategory where supercname =?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, supercname);
			
			rs = ps.executeQuery();
			while(rs.next()) {
				scb = new SubCategoryBean();
				scb.setScnum(rs.getInt("scnum"));
				scb.setSupercname(rs.getString("supercname"));
				scb.setScname(rs.getString("scname"));
				
				subCategory.add(scb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					if(rs!=null)
						rs.close();
					if(ps!=null)
						ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return subCategory;
	}//getAllSubCategory
	
	public boolean checkSubCategory(String scname) {
		boolean flag = false;
		String sql = "select scname from subcategory where scname=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, scname);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}//checkSubCategory
	
	public int insertSubCategory(SubCategoryBean subbean) {
		int cnt = -1;
		
		String sql = "insert into subcategory values(subcatseq.nextval, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, subbean.getSupercname());
			ps.setString(2, subbean.getScname());
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}//insertSubCategory
	
	public int deleteSubCategory(String Scnum) {
		int cnt = -1;
		String sql = "delete subcategory where scnum=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, Scnum);
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}//deleteSubCategory
	
	public String getScnameByScnum(String Scnum) {
		String scname = "";
		String sql ="select scname from subcategory where scnum=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, Scnum);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				scname=rs.getString("scname");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return scname;
	}//getScnameByScnum
	
	public int updateSubcategory(String Scnum, String scname) {
		int cnt =-1;
		String sql ="update subcategory set scname=? where scnum=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, scname);
			ps.setString(2, Scnum);
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}//updateSubcategory
}
