package shop.mall.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class BoardDAO {
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;

	private static BoardDAO bdao;

	public static BoardDAO getInstance() {
		if(bdao==null) {
			bdao = new BoardDAO();
		}
		return bdao;
	}//getInstance

	private BoardDAO() {
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

	public int getArticleCount() {
		int count = 0;
		String sql = "select count(*) as count from board";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
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
		return count;
	}//getArticleCount()

	public ArrayList<BoardBean> getAllBoard(int startRow, int endRow){
		ArrayList<BoardBean> lists = new ArrayList<BoardBean>();
		String sql = "select num, writer, title, passwd, reg_date, readcount, ref, re_step, re_level, content " ;		        
		sql += "from (select rownum as rank, num, writer, title, passwd, reg_date, readcount, ref, re_step, re_level, content ";
		sql += "from (select num, writer, title, passwd, reg_date, readcount, ref, re_step, re_level, content ";
		sql += "from board  ";
		sql += "order by ref desc, re_step asc )) ";
		sql += "where rank between ? and ? ";

		BoardBean bb = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,startRow);
			ps.setInt(2,endRow);

			rs = ps.executeQuery();
			while(rs.next()) {
				bb = new BoardBean();

				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setTitle(rs.getString("title"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));


				lists.add(bb);
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
	}//getAllboard

	public int insertArticle(BoardBean bb) {
		int cnt =-1;
		String sql = "insert into board (num, writer, title, passwd, reg_date, ref, re_step, re_level, content, today) ";
		sql += "values(board_seq.nextval, ?, ?, ?, ?, board_seq.currval, ?, ?, ?, ?)";

		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bb.getWriter());
			ps.setString(2, bb.getTitle());
			ps.setString(3, bb.getPasswd());
			ps.setTimestamp(4, bb.getReg_date());
			ps.setInt(5, 0); //re_step
			ps.setInt(6, 0); //re_level
			ps.setString(7, bb.getContent());
			ps.setString(8, sdf.format(d));

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
	}//insertArticle

	public BoardBean getArticleByNum(String num) {
		BoardBean bb = null;
		int cnt = -1;

		String sql = "select * from board where num = ?";
		String sql2 = "update board set readcount = readcount+1 where num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();

			while(rs.next()) {
				bb = new BoardBean();

				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setTitle(rs.getString("title"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));
			}

			ps = conn.prepareStatement(sql2);
			ps.setString(1, num);
			cnt = ps.executeUpdate();
			if(cnt>0) {
				System.out.println("조회수 증가성공");
			}else {
				System.out.println("조회수 증가실패");
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
		return bb;
	}//getArticleByNum

	public boolean confirmPasswd(String num, String passwd) { // 수정시 비밀번호 확인
		boolean result = false;
		String sql = "select passwd from board where num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			if(rs.next()) {
				if(passwd.equals(rs.getString("passwd"))){
					result = true;
				}
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
	}//confirmPasswd

	public int updateArticle(BoardBean bb) {
		int cnt =-1;
		String sql = "update board set title=?, writer=?, content=?, passwd=? where num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bb.getTitle());
			ps.setString(2, bb.getWriter());
			ps.setString(3, bb.getContent());
			ps.setString(4, bb.getPasswd());
			ps.setInt(5, bb.getNum());

			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
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
	}//updateArticle

	public int deleteArticle(String num) {
		int cnt =-1;
		String sql = "delete board where num="+num;
		try {
			ps = conn.prepareStatement(sql);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
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
	}//deleteArticle

	public int replyArticle(BoardBean bb) {
		int re_step, re_level, cnt =-1;
		String sql = "update board set re_step=re_step+1 where ref=? and re_step>?";
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bb.getRef());
			ps.setInt(2, bb.getRe_step());

			ps.executeUpdate();

			re_step = bb.getRe_step()+1;
			re_level = bb.getRe_level()+1;


			String sql2 = "insert into board (num, writer, title, passwd, reg_date, ref, re_step, re_level, content, today) ";
			sql2 += "values(board_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql2);
			ps.setString(1, bb.getWriter());
			ps.setString(2, bb.getTitle());
			ps.setString(3, bb.getPasswd());
			ps.setTimestamp(4, bb.getReg_date());
			ps.setInt(5, bb.getRef());
			ps.setInt(6, re_step);
			ps.setInt(7, re_level);
			ps.setString(8, bb.getContent());
			ps.setString(9, sdf.format(d));

			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(ps!=null)
					ps.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}//replyArticle
	
	public int todayArticleCount() {
		int articlecount = -1 ;
		
		Timestamp reg_date = new Timestamp(System.currentTimeMillis());
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
		
		
		String sql = "select count(*) as articlecount from board where today = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sdf.format(d));
			
			rs = ps.executeQuery();
			if(rs.next()) {
				articlecount = rs.getInt("articlecount");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(ps!=null)
					ps.close();

				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return articlecount;
	}
}
