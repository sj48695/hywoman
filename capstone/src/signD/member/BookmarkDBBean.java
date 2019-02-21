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

import signD.contest.RequestDataBean;

public class BookmarkDBBean {
	
    private static BookmarkDBBean instance = new BookmarkDBBean();
    
    public static BookmarkDBBean getInstance() {
        return instance;
    }
    
    BookmarkDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	public int insertBookmark(BookmarkDataBean bm) 
	            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=-1;
			        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into bookmark(id,designer_id,requestcode,reg_date) values (?,?,?,?)");
			pstmt.setString(1, bm.getId());
			pstmt.setString(2, bm.getDesigner_id());
			pstmt.setInt(3, bm.getRequestcode());
			pstmt.setTimestamp(4, bm.getReg_date());
			rs=pstmt.executeUpdate();
			
			if(rs>0) {
				x=1;
			}else {
				x=0;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	
	
	
	//콘테스트 즐겨찾기의 개수
	public int getRequestBmCount(String id) 
	    throws Exception {
	   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from Bookmark "
					+ "where id = ? and designer_id =''");

			pstmt.setString(1, id);
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
		
	//디자이너 즐겨찾기의 개수
	public int getDesignerBmCount(String id) 
	    throws Exception {
	   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from Bookmark "
					+ "where id = ? and requestcode=0");

			pstmt.setString(1, id);
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
	
	// 콘테스트 즐겨찾기 정보를 표시
	public List<RequestDataBean> getRequestBm(String id) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RequestDataBean rq=null;
	    List<RequestDataBean> rqs=null;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("SELECT request.*,bookmark.reg_date "
					+ "FROM request ,bookmark "
					+ "WHERE bookmark.id = ? and request.requestcode=bookmark.requestcode "
					+ "ORDER BY bookmark.reg_date DESC");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				rqs = new ArrayList<RequestDataBean>();
				do {
					rq = new RequestDataBean();
					rq.setRequestcode(rs.getInt("requestcode"));
					rq.setId(rs.getString("id"));
					rq.setTitle(rs.getString("title"));
					rq.setCompany_name(rs.getString("company_name"));
					rq.setService(rs.getString("service"));
					rq.setCategory(rs.getString("category"));
					rq.setRequest(rs.getString("request"));
					rq.setFile(rs.getString("file"));
					rq.setViewcount(rs.getInt("viewcount"));
					rq.setCost(rs.getInt("cost"));
					rq.setReg_date(rs.getTimestamp("reg_date"));
					rq.setEnd_date(rs.getTimestamp("end_date"));
					rq.setPpcode(rs.getInt("ppcode"));
					rq.setColor(rs.getString("color"));
					rq.setJob_kind(rs.getString("job_kind"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rqs.add(rq);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {rs.close(); } catch (SQLException ex) { }
			if (pstmt != null)
				try {pstmt.close(); } catch (SQLException ex) { }
			if (conn != null)
				try { conn.close(); } catch (SQLException ex) { }
		}
		return rqs;
	}
	
	// 콘테스트 즐겨찾기 정보를 표시
	public List<LogonDataBean> getDesignerBm(String id) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogonDataBean member=null;
	    List<LogonDataBean> members=null;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("SELECT member.*,bookmark.reg_date "
					+ "FROM member,bookmark "
					+ "WHERE bookmark.id = ? and member.id=bookmark.designer_id "
					+ "ORDER BY bookmark.reg_date DESC");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				members = new ArrayList<LogonDataBean>();
				do {
					member = new LogonDataBean();

					member.setId(rs.getString("id"));
					member.setPasswd(rs.getString("passwd"));
					member.setName(rs.getString("name"));
					member.setReg_date(rs.getTimestamp("reg_date"));
					member.setTel(rs.getString("tel"));
					member.setEmail(rs.getString("email"));
					member.setType(rs.getString("type"));
					member.setProfileimg(rs.getString("profileimg"));
					member.setIntroduction(rs.getString("introduction"));
					member.setMoney(rs.getInt("money"));
					member.setChoosecount(rs.getInt("choosecount"));
					members.add(member);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {rs.close(); } catch (SQLException ex) { }
			if (pstmt != null)
				try {pstmt.close(); } catch (SQLException ex) { }
			if (conn != null)
				try { conn.close(); } catch (SQLException ex) { }
		}
		return members;
	}
	
	
	//즐겨찾기 삭제
    public int deleteBookmark(BookmarkDataBean bm) 
    		throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        int rs = 0;
        int x=-1;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from bookmark "
					+ "where requestcode=? and id=? and designer_id=?");
			pstmt.setInt(1, bm.getRequestcode());
			pstmt.setString(2, bm.getId());
			pstmt.setString(3, bm.getDesigner_id());
			rs = pstmt.executeUpdate();

			if (rs>0) {
				x=1;
			}else {
				x=0;
			}
		}catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (pstmt != null) 
           	 try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
           	 try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }
    
    //콘테스트 즐겨찾기확인
    public int getBookmarkCheck(String id,Integer rqcode,String designerid) 
    		throws Exception {
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int x=-1;
    	
    	try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from bookmark "
					+ "where requestcode="+rqcode+" and id=? "
					+ "or designer_id=? and id=?");
			pstmt.setString(1, id);
			pstmt.setString(2, designerid);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				x = 1;//즐겨찾기 되어있음
			} else {
				x = 0;//즐겨찾기 안되어있음
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
    	return x;
    }
}