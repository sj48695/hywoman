package signD.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReplyDBBean {
	
    private static ReplyDBBean instance = new ReplyDBBean();
    
    public static ReplyDBBean getInstance() {
        return instance;
    }
    
    private ReplyDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	// reply테이블에 댓글을 추가(inset문)
	public void insertReply(ReplyDataBean reply) 
            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReplyDBBean db=null;
		db=ReplyDBBean.getInstance();

		int recount =db.getReplyCount("requestcode",reply.getRequestcode());
		int ref = reply.getRef();
		int re_step = reply.getRe_step();
		int re_level = reply.getRe_level();
		String sql = "";
		try {
			conn = getConnection();
			
			if (recount != 0) {//리뷰가 있다면
				sql = "update reply set re_step=re_step+1 ";
				sql += "where ref= ? and re_step> ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			} else {
				ref =reply.getRef();
				re_step = 0;
				re_level = 0;
			}
			// 쿼리를 작성
			sql = "insert into reply(id,division,reply,re_step,re_level,ref,reg_date,"
					+ "requestcode,portfoliocode) values(?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, reply.getId());
			pstmt.setString(2, reply.getDivision());
			pstmt.setString(3, reply.getReply());
			pstmt.setInt(4, re_step);
			pstmt.setInt(5, re_level);
			pstmt.setInt(6, ref);
			pstmt.setTimestamp(7, reply.getReg_date());
			pstmt.setInt(8, reply.getRequestcode());
			pstmt.setInt(9,reply.getPortfoliocode());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)
				try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)
				try {conn.close();} catch (SQLException ex) {}
		}
	}
	
	//댓글의 개수
	public int getReplyCount(String type,int code) 
	    throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        
        try {
        	
		conn = getConnection();
		pstmt = conn.prepareStatement("select count(*) from reply where "+type+"=?");
		pstmt.setInt(1, code);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			count = rs.getInt(1);
		}   
            
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (rs != null) 
           	 try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
           	 try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
           	 try { conn.close(); } catch(SQLException ex) {}
        }
		 return count;
    }
	
	 //댓글 정보를 표시
	public List<ReplyDataBean> getReplys(String type, int code) 
			throws Exception {
		 	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<ReplyDataBean> replys=null;
	    
		try {
			conn = getConnection();
	
			pstmt = conn.prepareStatement("select * from reply where "+type+"= ? order by ref desc, re_step asc");
	
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				replys = new ArrayList<ReplyDataBean>();
				do {
					ReplyDataBean reply = new ReplyDataBean();
					reply.setReplycode(rs.getInt("replycode"));
					reply.setId(rs.getString("id"));
					reply.setDivision(rs.getString("division"));
					reply.setReply(rs.getString("reply"));
					reply.setReg_date(rs.getTimestamp("reg_date"));
					reply.setRe_step(rs.getInt("re_step"));
					reply.setRe_level(rs.getInt("re_level"));
					reply.setRef(rs.getInt("ref"));
					reply.setRequestcode(rs.getInt("requestcode"));
					reply.setPortfoliocode(rs.getInt("portfoliocode"));
					replys.add(reply);
					
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
	    }finally {
	        if (rs != null) 
	       	 try { rs.close(); } catch(SQLException ex) {}
	        if (pstmt != null) 
	       	 try { pstmt.close(); } catch(SQLException ex) {}
	        if (conn != null) 
	       	 try { conn.close(); } catch(SQLException ex) {}
	    }
		 return replys;
	}
	
	//댓글지우기replydeletePro.jsp
	public int deleteReply(int replycode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
	
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from reply where replycode=?");// 댓글지우기
			pstmt.setInt(1, replycode);
			pstmt.executeUpdate();
			x = 1; // 글삭제 성공
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)
				try {conn.close();} catch (SQLException ex) {}
		}
		return x;
	}
}