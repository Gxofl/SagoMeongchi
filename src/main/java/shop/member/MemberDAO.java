package shop.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDAO {
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;

	private static MemberDAO mdao;

	public static MemberDAO getInstance() {
		if(mdao == null) {
			mdao = new MemberDAO();
		}	
		return mdao;
	}//getInstance()

	private MemberDAO() {
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

	public MemberBean getMemberInfo(String id, String password) {
		MemberBean mb = new MemberBean();
		mb.setId("");
		boolean flag = false;
		String sql = "select * from members where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);

			rs = ps.executeQuery();
			

			if(rs.next()) { //아이디가 있으면
				//flag = true;
				String sql2 = "select * from members where id=? and password=?";
				ps = conn.prepareStatement(sql2);
				ps.setString(1, id);
				ps.setString(2, password);
				
				rs=ps.executeQuery();
				if(rs.next()) {
						mb.setNo(rs.getInt("no"));
						mb.setName(rs.getString("name"));
						mb.setId(rs.getString("id"));
						mb.setPassword(rs.getString("password"));
						mb.setBirth(rs.getString("birth"));
						mb.setEmail(rs.getString("email"));
						mb.setHp1(rs.getString("hp1"));
						mb.setHp2(rs.getString("hp2"));
						mb.setHp3(rs.getString("hp3"));
						mb.setAddress(rs.getString("address"));
				}else {
					mb.setId("defaultpassword"); // 아이디가 없으면 아이디에 no가 들어가있음
				}
			}else {
				mb.setId("noid"); // 아이디가 없으면 아이디에 noid가 들어가있음
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
		return mb;
	}//getMemberInfo

	//	public MemberBean getMemberInfo(String id, String password) {
	//		MemberBean mb = null;
	//		String sql = "select * from members where id=? and password=?";
	//		try {
	//			ps = conn.prepareStatement(sql);
	//			ps.setString(1, id);
	//			ps.setString(2, password);
	//			
	//			rs = ps.executeQuery();
	//			if(rs.next()) {
	//				mb = new MemberBean();
	//				mb.setNo(rs.getInt("no"));
	//				mb.setName(rs.getString("name"));
	//				mb.setId(rs.getString("id"));
	//				mb.setPassword(rs.getString("password"));
	//				mb.setBirth(rs.getString("birth"));
	//				mb.setEmail(rs.getString("email"));
	//				mb.setHp1(rs.getString("hp1"));
	//				mb.setHp2(rs.getString("hp2"));
	//				mb.setHp3(rs.getString("hp3"));
	//				mb.setAddress(rs.getString("address"));
	//			}
	//		} catch (SQLException e) {
	//			e.printStackTrace();
	//		} finally {
	//			try {
	//				if(ps!=null)
	//					ps.close();
	//				if(rs!=null)
	//					rs.close();
	//			} catch (SQLException e) {
	//				e.printStackTrace();
	//			}
	//		}
	//		return mb;
	//	}//getMemberInfo

	public boolean searchId(String userId) { //아이디 중복체크
		boolean result = false;
		String sql = "select * from members where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userId);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
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
		return result;
	}//searchId

	public int insertMember(MemberBean mb) {
		int cnt = -1;

		String sql = "insert into members values(memseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getName());
			ps.setString(2, mb.getId());
			ps.setString(3, mb.getPassword());
			ps.setString(4, mb.getBirth());
			ps.setString(5, mb.getEmail());
			ps.setString(6, mb.getHp1());
			ps.setString(7, mb.getHp2());
			ps.setString(8, mb.getHp3());
			ps.setString(9, mb.getAddress());

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
	}//insertMember

	public String findId(String name, String birth) {
		String userId = null;
		String sql = "select id from members where name=? and birth=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2,	birth);

			rs = ps.executeQuery();
			if(rs.next()) {
				userId = rs.getString("id");
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
		return userId;
	}//findId

	public MemberBean findPw(MemberBean mb) {
		MemberBean mb2 = null;
		String sql = "select * from members where id=? and name=? and birth=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getId());
			ps.setString(2, mb.getName());
			ps.setString(3, mb.getBirth());


			rs = ps.executeQuery();
			if(rs.next()) {
				mb2 = new MemberBean();

				mb2.setNo(rs.getInt("no"));
				mb2.setName(rs.getString("name"));
				mb2.setId(rs.getString("id"));
				mb2.setPassword(rs.getString("password"));
				mb2.setBirth(rs.getString("birth"));
				mb2.setEmail(rs.getString("email"));
				mb2.setHp1(rs.getString("hp1"));
				mb2.setHp2(rs.getString("hp2"));
				mb2.setHp3(rs.getString("hp3"));
				mb2.setAddress(rs.getString("address"));
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
		return mb2;
	}//findPw

	public MemberBean getMemberInfo2(String sid) { //결제내역에서 주문자정보
		MemberBean mb = null;

		String sql = "select * from members where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sid);

			rs = ps.executeQuery();
			if(rs.next()) {
				mb = new MemberBean();
				mb.setNo(rs.getInt("no"));
				mb.setName(rs.getString("name"));
				mb.setId(rs.getString("id"));
				mb.setPassword(rs.getString("password"));
				mb.setBirth(rs.getString("birth"));
				mb.setEmail(rs.getString("email"));
				mb.setHp1(rs.getString("hp1"));
				mb.setHp2(rs.getString("hp2"));
				mb.setHp3(rs.getString("hp3"));
				mb.setAddress(rs.getString("address"));
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
		return mb;
	}//getMemberInfo2

	public ArrayList<MemberBean> getAllMembers(){
		ArrayList<MemberBean> memberlist = new ArrayList<MemberBean>();
		MemberBean mb = null;
		String sql = "select * from members order by no";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				mb = new MemberBean();
				mb.setNo(rs.getInt("no"));
				mb.setName(rs.getString("name"));
				mb.setId(rs.getString("id"));
				mb.setPassword(rs.getString("password"));
				mb.setBirth(rs.getString("birth"));
				mb.setEmail(rs.getString("email"));
				mb.setHp1(rs.getString("hp1"));
				mb.setHp2(rs.getString("hp2"));
				mb.setHp3(rs.getString("hp3"));
				mb.setAddress(rs.getString("address"));

				memberlist.add(mb);
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
		return memberlist;
	}//getAllMembers
}
