package shop.mall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import shop.ProductBean;

public class OrderDAO {
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;

	private static OrderDAO odao;

	public static OrderDAO getInstance() {
		if(odao==null) {
			odao = new OrderDAO();
		}
		return odao;
	}

	private OrderDAO() {
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

	public int insertOrder(int mno, Vector<ProductBean> cartlist, String sid) throws SQLException {
		int cnt = -1;
		String sql = "insert into orders values(orderseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for(ProductBean pb : cartlist) {
			ps = conn.prepareStatement(sql);
			int amount = pb.getStock()*pb.getPrice();

			ps.setString(1, sid);
			ps.setInt(2, mno);
			ps.setInt(3, pb.getPno());
			ps.setString(4, pb.getPname());
			ps.setString(5, pb.getPimage());
			ps.setInt(6, pb.getPrice());
			ps.setInt(7, pb.getStock());
			ps.setInt(8, amount);
			ps.setString(9, sdf.format(d));

			cnt += ps.executeUpdate();
		}//for

		if(ps!=null) 
			ps.close();

		return cnt;
	}//insertOrder

	public ArrayList<OrderBean> getAllOrders(){
		ArrayList<OrderBean> orderlist = new ArrayList<OrderBean>();
		OrderBean ob = null;
		String sql = "select o.orderId, m.id, p.pname, p.pimage, p.price, o.qty, o.amount from (orders o inner join members m on o.memno = m.no) inner join product p on o.pnum = p.pno order by orderId";

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				ob = new OrderBean();
				ob.setOrderId(rs.getInt("orderId"));
				ob.setId(rs.getString("id"));
				ob.setPname(rs.getString("pname"));
				ob.setPimage(rs.getString("pimage"));
				ob.setPrice(rs.getInt("price"));
				ob.setQty(rs.getInt("qty"));
				ob.setAmount(rs.getInt("amount"));

				orderlist.add(ob);
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
		return orderlist;
	}//getAllOrders
	
	public ArrayList<OrderBean> getAllOrderbyId(String id){
		ArrayList<OrderBean> orderlist = new ArrayList<OrderBean>();
		OrderBean ob = null;
		String sql = "select * from orders where id=? order by orderid";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				ob = new OrderBean();
				ob.setOrderId(rs.getInt("orderId"));
				ob.setId(rs.getString("id"));
				ob.setPname(rs.getString("pname"));
				ob.setPimage(rs.getString("pimage"));
				ob.setPrice(rs.getInt("price"));
				ob.setQty(rs.getInt("qty"));
				ob.setAmount(rs.getInt("amount"));
				ob.setOrderdate(rs.getString("orderdate"));

				orderlist.add(ob);
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
		return orderlist;
	}//getAllOrderbyId
	
	public int deleteOrder(String id, String orderdate, String orderid){
		int cnt = -1;
		String sql = "delete from orders where id=? and orderdate=? and orderid<=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, orderdate);
			ps.setString(3, orderid);
			
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
	}
	
	public int todayOrderCount() {
		int ordercount = 0;
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String sql = "select count(*) as ordercount from orders where orderdate=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sdf.format(d));
			
			rs = ps.executeQuery();
			if(rs.next()) {
				ordercount = rs.getInt("ordercount");
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
		return ordercount;
	}
}
