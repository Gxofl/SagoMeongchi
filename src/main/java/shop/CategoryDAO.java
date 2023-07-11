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

public class CategoryDAO {
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement ps;
	private static CategoryDAO cdao;

	public static CategoryDAO getInstance() {
		if(cdao==null) {
			cdao = new CategoryDAO();
		}
		return cdao;
	}

	private CategoryDAO() {
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

	public ArrayList<CategoryBean> getAllCategory(){
		ArrayList<CategoryBean> category = new ArrayList<CategoryBean>();
		CategoryBean cb = null;
		String sql = "select mcnum, mcname, scnum, scname from maincategory left outer join subcategory on mcname = supercname order by mcnum,scnum";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				cb = new CategoryBean();
				cb.setMcnum(rs.getInt("mcnum"));
				cb.setMcname(rs.getString("mcname"));
				cb.setScnum(rs.getInt("scnum"));
				cb.setScname(rs.getString("scname"));

				category.add(cb);
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
		return category;
	}//getAllCategory
}
