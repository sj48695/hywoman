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

public class FAQDBBean {
	
    private static FAQDBBean instance = new FAQDBBean();
    
    public static FAQDBBean getInstance() {
        return instance;
    }
    
    private FAQDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}

	public int insertFAQ(FAQDataBean FAQ) 
	            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
			        
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement( "insert into FAQ(id,title,contents,reg_date) values (?,?,?,?)");

			pstmt.setString(1, FAQ.getId());
			pstmt.setString(2, FAQ.getTitle());
			pstmt.setString(3, FAQ.getContents());
			pstmt.setTimestamp(4, FAQ.getReg_date());
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
	public int getFAQCount(String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql = "";

		try {

			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from FAQ");
			rs = pstmt.executeQuery();

			sql = "select count(*) from FAQ ";
			if (!keyword.equals("")) {// 검색이 될 경우
				sql += "where title like ? or contents like ? order by reg_date desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
			} else {// 검색을 안하는 경우
				sql += "order by reg_date desc";
				pstmt = conn.prepareStatement(sql);

			}
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
	      
    //공지사항 정보를 표시
	public List<FAQDataBean> getFAQ(int start,int end,String keyword) 
			throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<FAQDataBean> FAQs=null;
        String sql ="";

		try {
			conn = getConnection();

			/*pstmt = conn.prepareStatement("select * from FAQ order by reg_date desc limit ?,?");
			pstmt.setInt(1, start - 1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
*/
			sql = "select * from FAQ ";
			if (!keyword.equals("")) {// 검색이 될 경우
				sql += "where title like ? or contents like ? order by reg_date desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
				pstmt.setInt(3, start - 1);
				pstmt.setInt(4, end);
			} else {// 검색을 안하는 경우
				sql += "order by reg_date desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				FAQs = new ArrayList<FAQDataBean>();
				do {
					FAQDataBean FAQ = new FAQDataBean();
					FAQ.setFAQcode(rs.getInt("FAQcode"));
					FAQ.setId(rs.getString("id"));
					FAQ.setTitle(rs.getString("title"));
					FAQ.setContents(rs.getString("contents"));
					FAQ.setReg_date(rs.getTimestamp("reg_date"));
					FAQs.add(FAQ);

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
       return FAQs;
    }
	    //공지사항 정보를 표시
	public FAQDataBean getFAQ(int faqcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FAQDataBean FAQ = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from FAQ where faqcode=? order by reg_date desc");
			pstmt.setInt(1, faqcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				FAQ = new FAQDataBean();
				FAQ.setFAQcode(rs.getInt("FAQcode"));
				FAQ.setId(rs.getString("id"));
				FAQ.setTitle(rs.getString("title"));
				FAQ.setContents(rs.getString("contents"));
				FAQ.setReg_date(rs.getTimestamp("reg_date"));
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
       return FAQ;
    }

	// 자주묻는 문의사항 수정
	public int updateFAQ(FAQDataBean FAQ) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update faq set title=?,contents=? where faqcode=?");
			pstmt.setString(1, FAQ.getTitle());
			pstmt.setString(2, FAQ.getContents());
			pstmt.setInt(3, FAQ.getFAQcode());
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
	// 자주묻는 문의사항 삭제
	public int deleteFAQ(int FAQcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from faq where faqcode=?");
			pstmt.setInt(1, FAQcode);
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