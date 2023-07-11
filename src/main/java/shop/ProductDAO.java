package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ProductDAO {
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement ps;

	private static ProductDAO pdao;

	public static ProductDAO getInstance() {
		if(pdao==null) {
			pdao = new ProductDAO();
		}
		return pdao;
	}//getInstance()

	private ProductDAO() {
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

	public int insertProduct(MultipartRequest mr) {
		int cnt = -1;
		String sql = "insert into product values(prodseq.nextval, ?,?,?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("pname"));
			ps.setString(2, mr.getParameter("pcategory_fk"));
			ps.setString(3, mr.getParameter("pspec"));
			ps.setString(4, mr.getParameter("pcompany"));
			ps.setString(5, mr.getFilesystemName("pimage"));
			ps.setInt(6, Integer.parseInt(mr.getParameter("stock")));
			ps.setInt(7, Integer.parseInt(mr.getParameter("price")));
			ps.setInt(8, Integer.parseInt(mr.getParameter("point")));
			ps.setString(9, mr.getParameter("pcontents"));
			ps.setString(10, mr.getParameter("pinputdate"));

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
	}//insertProduct

	public ArrayList<ProductBean> getAllProduct(){
		ArrayList<ProductBean> products = new ArrayList<ProductBean>();
		ProductBean pb = null;
		String sql = "select * from product order by pno";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				pb = new ProductBean();
				pb.setPno(rs.getInt("pno"));
				pb.setPname(rs.getString("pname"));
				pb.setPcategory_fk(rs.getString("pcategory_fk"));
				pb.setPspec(rs.getString("pspec"));
				pb.setPcompany(rs.getString("pcompany"));
				pb.setPimage(rs.getString("pimage"));
				pb.setStock(rs.getInt("stock"));
				pb.setPrice(rs.getInt("price"));
				pb.setPoint(rs.getInt("point"));
				pb.setPcontents(rs.getString("pcontents"));
				pb.setPinputdate(rs.getString("pinputdate"));

				products.add(pb);
			}
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
		return products;
	}//getAllProduct

	public ProductBean getProductByPno(String pno) {
		ProductBean pb = null;
		String sql = "select * from product where pno=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pno);

			rs = ps.executeQuery();
			if(rs.next()) {
				pb = new ProductBean();
				pb.setPno(rs.getInt("pno"));
				pb.setPname(rs.getString("pname"));
				pb.setPcategory_fk(rs.getString("pcategory_fk"));
				pb.setPspec(rs.getString("pspec"));
				pb.setPcompany(rs.getString("pcompany"));
				pb.setPimage(rs.getString("pimage"));
				pb.setStock(rs.getInt("stock"));
				pb.setPrice(rs.getInt("price"));
				pb.setPoint(rs.getInt("point"));
				pb.setPcontents(rs.getString("pcontents"));
				pb.setPinputdate(rs.getString("pinputdate"));
			}
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
		return pb;
	} //getProductByPno

	public int updateProduct(MultipartRequest mr, String img) {
		int cnt = -1;
		String sql = "update product set pname=?, pcategory_fk=?, pspec=?, pcompany=?, pimage=?, stock=?, price=?, point=?, pcontents=?, pinputdate=? where pno=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("pname"));
			ps.setString(2, mr.getParameter("pcategory_fk"));
			ps.setString(3, mr.getParameter("pspec"));
			ps.setString(4, mr.getParameter("pcompany"));
			ps.setString(5, img);
			ps.setInt(6, Integer.parseInt(mr.getParameter("stock")));
			ps.setInt(7, Integer.parseInt(mr.getParameter("price")));
			ps.setInt(8, Integer.parseInt(mr.getParameter("point")));
			ps.setString(9, mr.getParameter("pcontents"));
			ps.setString(10, mr.getParameter("pinputdate"));
			ps.setInt(11, Integer.parseInt(mr.getParameter("pno")));

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
	}//updateProduct

	public int deleteProduct(String pno) {
		int cnt = -1;
		String sql = "delete product where pno=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pno);

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
	}//deleteProduct

	public ArrayList<ProductBean> getProductByMcname(String cname){ //메인카테고리 이름으로 조회 간식
		ArrayList<ProductBean> product = new ArrayList<ProductBean>();
		ProductBean pb = null;

		String sql = "select * from product where pcategory_fk like '%"+cname+"%'";
		//select * from product where pcategory_fk like '%간식%';

		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			while(rs.next()) {
				pb = new ProductBean();
				pb.setPno(rs.getInt("pno"));
				pb.setPname(rs.getString("pname"));
				pb.setPcategory_fk(rs.getString("pcategory_fk"));
				pb.setPspec(rs.getString("pspec"));
				pb.setPcompany(rs.getString("pcompany"));
				pb.setPimage(rs.getString("pimage"));
				pb.setStock(rs.getInt("stock"));
				pb.setPrice(rs.getInt("price"));
				pb.setPoint(rs.getInt("point"));
				pb.setPcontents(rs.getString("pcontents"));
				pb.setPinputdate(rs.getString("pinputdate"));

				product.add(pb);
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
		return product;
	}//getProductByMcname

	public int updateStock(Vector<ProductBean> cartlist) {
		int cnt = -1;

		String sql ="update product set stock=stock-? where pno=?";

		try {
			for(ProductBean pb : cartlist) {
				ps = conn.prepareStatement(sql);
				System.out.println("주문수량 :"+pb.getStock());
				ps.setInt(1, +pb.getStock());
				ps.setInt(2, pb.getPno());

				cnt += ps.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}//updateStock
	
	public ArrayList<ProductBean> getProductByPspec(String pspec){
		 ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		 ProductBean pb = null;
		 String sql = "select * from product where pspec=?";
		 try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pspec);
			
			rs = ps.executeQuery();
			while(rs.next()) {
				pb = new ProductBean();
				pb.setPno(rs.getInt("pno"));
				pb.setPname(rs.getString("pname"));
				pb.setPcategory_fk(rs.getString("pcategory_fk"));
				pb.setPspec(rs.getString("pspec"));
				pb.setPcompany(rs.getString("pcompany"));
				pb.setPimage(rs.getString("pimage"));
				pb.setStock(rs.getInt("stock"));
				pb.setPrice(rs.getInt("price"));
				pb.setPoint(rs.getInt("point"));
				pb.setPcontents(rs.getString("pcontents"));
				pb.setPinputdate(rs.getString("pinputdate"));

				lists.add(pb);
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
		 return lists;
	}//getProductByPspec
}
