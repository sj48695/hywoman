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


public class PortfolioDBBean {
	
    private static PortfolioDBBean instance = new PortfolioDBBean();
    
    public static PortfolioDBBean getInstance() {
        return instance;
    }
    
    private PortfolioDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	public int insertPortfolio(PortfolioDataBean portfolio) 
	            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
			        
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement( "insert into portfolio(file,title,contents,id,requestcode,reg_date) values (?,?,?,?,?,?)");
	
			pstmt.setString(1, portfolio.getFile());
			pstmt.setString(2, portfolio.getTitle());
			pstmt.setString(3, portfolio.getContents());
			pstmt.setString(4, portfolio.getId());
			pstmt.setInt(5, portfolio.getRequestcode());
			pstmt.setTimestamp(6, portfolio.getReg_date());
			rs=pstmt.executeUpdate();
			
			if(rs>0) x=1;
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
	//디자이너별 포트폴리오의 개수
    public int getPortfoliosCount(String keyword) 
          throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int count = 0;
       String sql="";

       try {

          conn = getConnection();
          pstmt = conn.prepareStatement("select count(*) from portfolio");
          rs = pstmt.executeQuery();
          
          sql = "select count(*) from portfolio ";
          
          if(!keyword.equals("")) {//검색이 될 경우
                sql += "where title like ? or contents like ? or id like ? order by reg_date desc";
                pstmt = conn.prepareStatement(sql);
              pstmt.setString(1, "%"+keyword+"%");
              pstmt.setString(2, "%"+keyword+"%");
              pstmt.setString(3, "%"+keyword+"%");
          }else{//검색을 안하는 경우
            sql+= "order by reg_date desc";
          pstmt = conn.prepareStatement(sql);
         }

          rs = pstmt.executeQuery();
          
          if (rs.next()) {
             count = rs.getInt(1);
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
        return count;
    }

	
	//디자이너별 포트폴리오의 개수
	public int getPortfolioCount(String id) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {

			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from Portfolio where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
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
		 return count;
	}
	
	// 디자이너별 포트폴리오의 개수
	public int getPortfoliosCount(String keyword, String order) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql = "";

		try {

			conn = getConnection();

			sql = "select count(*) from portfolio ";

			if (!keyword.equals("")) {// 검색이 될 경우
				sql += "where title like ? or contents like ? or id like ? order by reg_date desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
				pstmt.setString(3, "%" + keyword + "%");
			} else {// 검색을 안하는 경우
				if (order.equals("")) {
					sql += "order by reg_date desc";
				} else {
					sql += "order by viewcount desc";
				}
				pstmt = conn.prepareStatement(sql);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
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
		return count;
	}
//포트폴리오의 정보를 표시-->designerportfoilo.jsp
	public List<PortfolioDataBean> getPortfolios(int start, int end, String keyword, String order) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PortfolioDataBean> pfs = null;
		String sql = "";

		try {
			conn = getConnection();

			sql = "select * from portfolio ";

			if (!keyword.equals("")) {// 검색이 될 경우
				sql += "where title like ? or contents like ? or id like ? order by reg_date desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
				pstmt.setString(3, "%" + keyword + "%");
				pstmt.setInt(4, start - 1);
				pstmt.setInt(5, end);
			} else {// 검색을 안하는 경우
				if (order.equals("")) {
					sql += "order by reg_date desc limit ?,?";
				} else {
					sql += "order by viewcount desc limit ?,?";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pfs = new ArrayList<PortfolioDataBean>();
				do {
					PortfolioDataBean pf = new PortfolioDataBean();
					pf.setPortfoliocode(rs.getInt("Portfoliocode"));
					pf.setFile(rs.getString("file"));
					pf.setTitle(rs.getString("title"));
					pf.setContents(rs.getString("contents"));
					pf.setId(rs.getString("id"));
					pf.setViewcount(rs.getInt("viewcount"));
					pf.setReg_date(rs.getTimestamp("reg_date"));
					pfs.add(pf);
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
		return pfs;
	}
	
	//포트폴리오의 정보를 표시-->designerportfoilo.jsp
    public List<PortfolioDataBean> getPortfolios(int start,int end,String keyword) 
          throws Exception {
          Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<PortfolioDataBean> pfs=null;
        String sql="";
        
      try {
         conn = getConnection();

         pstmt = conn.prepareStatement("select * from portfolio order by reg_date desc limit ?,?");
         pstmt.setInt(1, start-1);
         pstmt.setInt(2, end);
         rs = pstmt.executeQuery();
         
         sql = "select * from portfolio ";

         if (!keyword.equals("")) {// 검색이 될 경우
            sql += "where title like ? or contents like ? or id like ? order by reg_date desc limit ?,?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            pstmt.setString(3, "%" + keyword + "%");
            pstmt.setInt(4, start-1);
            pstmt.setInt(5, end);
         } else {// 검색을 안하는 경우
            sql += "order by reg_date desc limit ?,?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start-1);
            pstmt.setInt(2, end);
         }
         rs = pstmt.executeQuery();

         if (rs.next()) {
            pfs = new ArrayList<PortfolioDataBean>();
            do {
               PortfolioDataBean pf = new PortfolioDataBean();
               pf.setPortfoliocode(rs.getInt("Portfoliocode"));
               pf.setFile(rs.getString("file"));
               pf.setTitle(rs.getString("title"));
               pf.setContents(rs.getString("contents"));
               pf.setId(rs.getString("id"));
               pf.setRequestcode(rs.getInt("requestcode"));
               pf.setViewcount(rs.getInt("viewcount"));
               pf.setReg_date(rs.getTimestamp("reg_date"));
               pfs.add(pf);
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
       return pfs;
    }
		
	 //디자이너별 포트폴리오의 정보를 표시-->profile.jsp
    public List<PortfolioDataBean> getPortfolio(String id,int start,int end) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<PortfolioDataBean> pfs=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from Portfolio where id = ? "
					+ "order by reg_date desc limit ?,?");

			pstmt.setString(1, id);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pfs = new ArrayList<PortfolioDataBean>();
				do {
					PortfolioDataBean pf = new PortfolioDataBean();
					pf.setPortfoliocode(rs.getInt("portfoliocode"));
					pf.setFile(rs.getString("file"));
					pf.setTitle(rs.getString("title"));
					pf.setContents(rs.getString("contents"));
					pf.setId(rs.getString("id"));
					pf.setRequestcode(rs.getInt("requestcode"));
					pf.setViewcount(rs.getInt("viewcount"));
					pf.setReg_date(rs.getTimestamp("reg_date"));
					pfs.add(pf);
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
		 return pfs;
    }
    
    //하나의 참여작 정보(portfolioModal.jsp)
    public PortfolioDataBean getPortfolio(int pfcode) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PortfolioDataBean pf=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from portfolio where portfoliocode = ? "
					+ "order by reg_date desc");
			pstmt.setInt(1, pfcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pf = new PortfolioDataBean();
				pf.setPortfoliocode(rs.getInt("portfoliocode"));
				pf.setId(rs.getString("id"));
				pf.setTitle(rs.getString("title"));
				pf.setContents(rs.getString("contents"));
				pf.setFile(rs.getString("file"));
				pf.setViewcount(rs.getInt("viewcount"));
				pf.setReg_date(rs.getTimestamp("reg_date"));
				pf.setRequestcode(rs.getInt("requestcode"));
				pf.setPrize_money(rs.getInt("prize_money"));
		
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
		 return pf;
    }
    
    //포트폴리오 조회수 늘리기-->portfolioModal.jsp
	public int updateViewcount(int pfcode, String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
		
		try {
			conn = getConnection();

			if (id == null)
				id = "";

			pstmt = conn.prepareStatement("update portfolio set viewcount=viewcount+1"
					+ " where portfoliocode = ? and id <> ?");
			// 조회수, 게시글 작성자가 아니면 조회수가 늘어난다.
			pstmt.setInt(1, pfcode);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			if (rs > 0)
				x = 1;

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
   	
    //참여작 수정
    public int updatePortfolio(PortfolioDataBean pf) 
            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
			        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update portfolio set title=?,contents=?,file=? where portfoliocode=?");
			pstmt.setString(1, pf.getTitle());
			pstmt.setString(2, pf.getContents());
			pstmt.setString(3, pf.getFile());
			pstmt.setInt(4, pf.getPortfoliocode());
			rs = pstmt.executeUpdate();

			if (rs > 0)
				x = 1;
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
    
    //참여작 삭제
    public int deletePortfolio(int pfcode) 
            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
			        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from portfolio where portfoliocode=?");
			pstmt.setInt(1, pfcode);
			rs = pstmt.executeUpdate();

			if (rs > 0)
				x = 1;
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
}