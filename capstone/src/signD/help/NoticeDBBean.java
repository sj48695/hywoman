package signD.help;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDBBean {
	
    private static NoticeDBBean instance = new NoticeDBBean();
    
    public static NoticeDBBean getInstance() {
        return instance;
    }
    
    private NoticeDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}

	public int insertNotice(NoticeDataBean notice) 
	            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement( "insert into notice(id,title,contents,reg_date) values (?,?,?,?)");

			pstmt.setString(1, notice.getId());
			pstmt.setString(2, notice.getTitle());
			pstmt.setString(3, notice.getContents());
			pstmt.setTimestamp(4, notice.getReg_date());
			rs=pstmt.executeUpdate();
			if(rs>0)x=1;
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	//공지사항의 개수
	public int getNoticeCount() throws Exception {
	   	 Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int count=0;
	        
	        try {
	        	
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from notice");
			rs = pstmt.executeQuery();

			if (rs.next()) { count = rs.getInt(1); }   
	            
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
		
	 //공지사항 정보를 표시
    public List<NoticeDataBean> getNotice(int start,int end) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<NoticeDataBean> Notices=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from notice order by reg_date desc limit ?,?");
			pstmt.setInt(1, start - 1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Notices = new ArrayList<NoticeDataBean>();
				do {
					NoticeDataBean notice = new NoticeDataBean();
					notice.setNoticecode(rs.getInt("noticecode"));
					notice.setId(rs.getString("id"));
					notice.setTitle(rs.getString("title"));
					notice.setContents(rs.getString("contents"));
					notice.setReg_date(rs.getTimestamp("reg_date"));
					Notices.add(notice);

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
		 return Notices;
    } 
    
    //공지사항 정보를 표시
    public NoticeDataBean getNotice(int noticecode) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        NoticeDataBean notice=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from notice where noticecode=? order by reg_date desc");
			pstmt.setInt(1, noticecode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				notice = new NoticeDataBean();
				notice.setNoticecode(rs.getInt("noticecode"));
				notice.setId(rs.getString("id"));
				notice.setTitle(rs.getString("title"));
				notice.setContents(rs.getString("contents"));
				notice.setReg_date(rs.getTimestamp("reg_date"));
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
		 return notice;
    }
    // 공지사항 수정
  	public int updateNotice(NoticeDataBean notice) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		int rs = 0;
  		int x = 0;

  		try {
  			conn = getConnection();

  			pstmt = conn.prepareStatement("update notice set title=?,contents=? where noticecode=?");
  			pstmt.setString(1, notice.getTitle());
  			pstmt.setString(2, notice.getContents());
  			pstmt.setInt(3, notice.getNoticecode());
  			rs = pstmt.executeUpdate();

  			if (rs > 0) {
  				x = 1;
  			} 
  		} catch (Exception ex) {
  			ex.printStackTrace();
          }finally {
              if (pstmt != null) 
             	 try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) 
             	 try { conn.close(); } catch(SQLException ex) {}
          }
  		 return x;
      }
	
	// 공지사항 삭제
	public int deleteNotice(int noticecode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from notice where noticecode=?");
			pstmt.setInt(1, noticecode);
			rs = pstmt.executeUpdate();

			if (rs > 0) {
				x = 1;
			} 
		} catch (Exception ex) {
			ex.printStackTrace();
        }finally {
            if (pstmt != null) 
           	 try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
           	 try { conn.close(); } catch(SQLException ex) {}
        }
		 return x;
    }
}