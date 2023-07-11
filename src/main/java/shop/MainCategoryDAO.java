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

public class MainCategoryDAO {
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement ps;
	private static MainCategoryDAO maincdao;
	
	public static MainCategoryDAO getInstance() {
		if(maincdao==null) {
			maincdao = new MainCategoryDAO();
		}
		return maincdao;
	}
	
	private MainCategoryDAO() {
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
	
	public ArrayList<MainCategoryBean> getAllMainCategory(){
		 ArrayList<MainCategoryBean> mainCategory = new ArrayList<MainCategoryBean>();
		 MainCategoryBean mcb = null;
		 String sql = "select * from maincategory order by mcnum";
		 try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				mcb = new MainCategoryBean();
				mcb.setMcnum(rs.getInt("mcnum"));
				mcb.setMcname(rs.getString("mcname"));
				
				mainCategory.add(mcb);
			}
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
		 return mainCategory;
	}//getAllMainCategory
	
	public boolean checkMainCategory(String mcname) {
		boolean flag = false;
		
		String sql = "select * from maincategory where mcname = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mcname);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
			}
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
		return flag;
	}//checkMainCategory
	
	public int insertMainCategory(String mcname) {
		int cnt = -1;
		String sql = "insert into maincategory values(maincatseq.nextval, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mcname);
			
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
	}//insertMainCategory
	
	public int deleteMainCategory(String Mcnum) {
		int cnt = -1;
		String sql = "delete maincategory where mcnum=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, Mcnum);
			
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
	}//deleteMainCategory
	
	public String getMcnameByMcnum(String Mcnum) {
		String mcname="";
		String sql = "select mcname from maincategory where mcnum =?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, Mcnum);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				mcname = rs.getString("mcname");
			}
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
		return mcname;
	}//getMcnameByMcnum
	
	public int updateMaincategory(String Mcnum, String mcname) {
		int cnt =-1;
		String sql ="update maincategory set mcname=? where mcnum=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mcname);
			ps.setString(2, Mcnum);
			
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
	}//updateMaincategory
}
