package signD.contest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ParticipationDBBean {
	
    private static ParticipationDBBean instance = new ParticipationDBBean();
    
    public static ParticipationDBBean getInstance() {
        return instance;
    }
    
    private ParticipationDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}


	public int insertParticipation(ParticipationDataBean pp) 
	            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement( "insert into participation(id,title,contents,file,"
					+ "reg_date,requestcode) values (?,?,?,?,?,?)");

			pstmt.setString(1, pp.getId());
			pstmt.setString(2, pp.getTitle());
			pstmt.setString(3, pp.getContents());
			pstmt.setString(4, pp.getFile());
			pstmt.setTimestamp(5, pp.getReg_date());
			pstmt.setInt(6, pp.getRequestcode());
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
	
	//참여작의 개수
    public int getParticipationsCount(String category, String keyword) 
        throws Exception {
    Connection conn = null;
     PreparedStatement pstmt = null;
     ResultSet rs = null;
     int count=0;
     String sql = "";
     String sql1 = "";
     
		try {

			conn = getConnection();

			sql = "select count(*) from participation where ppcode in(select ppcode from request) ";
			sql1 = "select count(*) from participation where ppcode in(select ppcode from request where category = ?) ";

			if (!keyword.equals("")) {// 검색이 될 경우
				sql += "and (title like ? or contents like ? or id like ?) order by reg_date desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
				pstmt.setString(3, "%" + keyword + "%");
			} else {// 검색을 안하는 경우
				sql += "order by reg_date desc";
				sql1 += "order by reg_date desc";

				if (category.equals("")) {
					pstmt = conn.prepareStatement(sql);
				} else {
					pstmt = conn.prepareStatement(sql1);
					pstmt.setString(1, category);
				}
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
	
	//내참여작의 개수
	public int getParticipationCount(String id) 
	    throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        
        try {
        	
		conn = getConnection();
		pstmt = conn.prepareStatement("select count(*) from participation where id = ?");
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
		
	//콘테스트별 참여작의 개수
	public int getParticipationCount(int rqcode) 
	    throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        
        try {
        	
		conn = getConnection();
		pstmt = conn.prepareStatement("select count(*) from participation where requestcode = ?");
		pstmt.setInt(1, rqcode);
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
	
	//참여작의 개수
	public int getParticipationsCount(String category, String keyword, String job_kind, String order) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql = "";

		try {

			conn = getConnection();

			sql = "select count(*) from participation where ppcode in(select ppcode from request";

			if (!keyword.equals("")) {// 검색이 될 경우
				if (category.equals("") && job_kind.equals("")) {
					sql += ") and (title like ? or contents like ? or id like ?) ";
					if (order.equals("prize_money")) {
						sql += "order by prize_money desc";
					} else if (order.equals("viewcount")) {
						sql += "order by viewcount desc";
					} else {
						sql += "order by reg_date desc";
					}
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%");
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
				} else if (!category.equals("") && !job_kind.equals("")) {
					sql += " where category = ? and job_kind = ?) and (title like ? or contents like ? or id like ?) ";
					if (order.equals("prize_money")) {
						sql += "order by prize_money desc";
					} else if (order.equals("viewcount")) {
						sql += "order by viewcount desc";
					} else {
						sql += "order by reg_date desc";
					}
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, category);
					pstmt.setString(2, job_kind);
					pstmt.setString(3, "%" + keyword + "%");
					pstmt.setString(4, "%" + keyword + "%");
					pstmt.setString(5, "%" + keyword + "%");
				} else if (!category.equals("") && job_kind.equals("")) {
					sql += " where category = ?) and (title like ? or contents like ? or id like ?) ";
					if (order.equals("prize_money")) {
						sql += "order by prize_money desc";
					} else if (order.equals("viewcount")) {
						sql += "order by viewcount desc";
					} else {
						sql += "order by reg_date desc";
					}
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, category);
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
					pstmt.setString(4, "%" + keyword + "%");
				} else if (!job_kind.equals("") && category.equals("")) {
					sql += " where job_kind = ?) and (title like ? or contents like ? or id like ?) ";
					if (order.equals("prize_money")) {
						sql += "order by prize_money desc";
					} else if (order.equals("viewcount")) {
						sql += "order by viewcount desc";
					} else {
						sql += "order by reg_date desc";
					}
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, job_kind);
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
					pstmt.setString(4, "%" + keyword + "%");
				}
			} else {// 검색을 안하는 경우
				if (category.equals("") && job_kind.equals("")) {
					sql += ") order by ";
					if (order.equals("prize_money")) {
						sql += "prize_money desc";
					} else if (order.equals("viewcount")) {
						sql += "viewcount desc";
					} else {
						sql += "reg_date desc";
					}
					pstmt = conn.prepareStatement(sql);
				} else if (!category.equals("") && !job_kind.equals("")) {
					sql += " where category = ? and job_kind = ?) ";
					if (order.equals("prize_money")) {
						sql += "order by prize_money desc";
					} else if (order.equals("viewcount")) {
						sql += "order by viewcount desc";
					} else {
						sql += "order by reg_date desc";
					}
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, category);
					pstmt.setString(2, job_kind);
				} else if (!category.equals("") && job_kind.equals("")) {
					sql += " where category = ?) ";
					if (order.equals("prize_money")) {
						sql += "order by prize_money desc";
					} else if (order.equals("viewcount")) {
						sql += "order by viewcount desc";
					} else {
						sql += "order by reg_date desc";
					}
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, category);
				} else if (!job_kind.equals("") && category.equals("")) {
					sql += " where job_kind = ?) ";
					if (order.equals("prize_money")) {
						sql += "order by prize_money desc";
					} else if (order.equals("viewcount")) {
						sql += "order by viewcount desc";
					} else {
						sql += "order by reg_date desc";
					}
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, job_kind);
				}
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
    
  //모든 참여작 정보 (winningwork.jsp에서 사용)
    public List<ParticipationDataBean> getParticipation(int start,int end,String category, String keyword, String job_kind, String order) 
          throws Exception {
          Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ParticipationDataBean> pps=null;
        String sql = "";
        
      try {
         conn = getConnection();

         sql = "select * from participation where ppcode in(select ppcode from request";
         
         if (!keyword.equals("")) {// 검색이 될 경우
            if(category.equals("") && job_kind.equals("")){
               sql += ") and (title like ? or contents like ? or id like ?) ";
               if(order.equals("prize_money")) {
                    sql += "order by prize_money desc limit ?,?";
                 }else if(order.equals("viewcount")) {
                    sql += "order by viewcount desc limit ?,?";
                 }else {
                    sql += "order by reg_date desc limit ?,?";
                 }
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, "%" + keyword + "%");
               pstmt.setString(2, "%" + keyword + "%");
               pstmt.setString(3, "%" + keyword + "%");
               pstmt.setInt(4, start-1);
                 pstmt.setInt(5, end);
            }else if(!category.equals("") && !job_kind.equals("")) {
                sql += " where category = ? and job_kind = ?) and (title like ? or contents like ? or id like ?) ";
                 if(order.equals("prize_money")) {
                    sql += "order by prize_money desc limit ?,?";
                 }else if(order.equals("viewcount")) {
                    sql += "order by viewcount desc limit ?,?";
                 }else {
                    sql += "order by reg_date desc limit ?,?";
                 }
                 pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, category);
               pstmt.setString(2, job_kind);
               pstmt.setString(3, "%" + keyword + "%");
               pstmt.setString(4, "%" + keyword + "%");
               pstmt.setString(5, "%" + keyword + "%");
               pstmt.setInt(6, start-1);
                 pstmt.setInt(7, end);
            }else if(!category.equals("") && job_kind.equals("")){
               sql += " where category = ?) and (title like ? or contents like ? or id like ?) ";
               if(order.equals("prize_money")) {
                    sql += "order by prize_money desc limit ?,?";
                 }else if(order.equals("viewcount")) {
                    sql += "order by viewcount desc limit ?,?";
                 }else {
                    sql += "order by reg_date desc limit ?,?";
                 }
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, category);
               pstmt.setString(2, "%" + keyword + "%");
               pstmt.setString(3, "%" + keyword + "%");
               pstmt.setString(4, "%" + keyword + "%");
               pstmt.setInt(5, start-1);
                 pstmt.setInt(6, end);
            }else if(!job_kind.equals("") && category.equals("")) {
               sql += " where job_kind = ?) and (title like ? or contents like ? or id like ?) ";
               if(order.equals("prize_money")) {
                    sql += "order by prize_money desc limit ?,?";
                 }else if(order.equals("viewcount")) {
                    sql += "order by viewcount desc limit ?,?";
                 }else {
                    sql += "order by reg_date desc limit ?,?";
                 }
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, job_kind);
               pstmt.setString(2, "%" + keyword + "%");
               pstmt.setString(3, "%" + keyword + "%");
               pstmt.setString(4, "%" + keyword + "%");
               pstmt.setInt(5, start-1);
                 pstmt.setInt(6, end);
            }
         } else {// 검색을 안하는 경우
            if(category.equals("") && job_kind.equals("")){
               sql += ") order by ";
               if(order.equals("prize_money")) {
                    sql += "prize_money desc limit ?,?";
                 }else if(order.equals("viewcount")) {
                    sql += "viewcount desc limit ?,?";
                 }else {
                    sql += "reg_date desc limit ?,?";
                 }
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, start-1);
                 pstmt.setInt(2, end);
            }else if(!category.equals("") && !job_kind.equals("")) {
                sql += " where category = ? and job_kind = ?) ";
                 if(order.equals("prize_money")) {
                    sql += "order by prize_money desc limit ?,?";
                 }else if(order.equals("viewcount")) {
                    sql += "order by viewcount desc limit ?,?";
                 }else {
                    sql += "order by reg_date desc limit ?,?";
                 }
                 pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, category);
               pstmt.setString(2, job_kind);
               pstmt.setInt(3, start-1);
                 pstmt.setInt(4, end);
            }else if(!category.equals("") && job_kind.equals("")){
               sql += " where category = ?) ";
               if(order.equals("prize_money")) {
                    sql += "order by prize_money desc limit ?,?";
                 }else if(order.equals("viewcount")) {
                    sql += "order by viewcount desc limit ?,?";
                 }else {
                    sql += "order by reg_date desc limit ?,?";
                 }
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, category);
               pstmt.setInt(2, start-1);
                 pstmt.setInt(3, end);
            }else if(!job_kind.equals("") && category.equals("")) {
               sql += " where job_kind = ?) ";
               if(order.equals("prize_money")) {
                    sql += "order by prize_money desc limit ?,?";
                 }else if(order.equals("viewcount")) {
                    sql += "order by viewcount desc limit ?,?";
                 }else {
                    sql += "order by reg_date desc limit ?,?";
                 }
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, job_kind);
               pstmt.setInt(2, start-1);
                 pstmt.setInt(3, end);
            }            
         }
         rs = pstmt.executeQuery();

         if (rs.next()) {
            pps = new ArrayList<ParticipationDataBean>();
            do {
               ParticipationDataBean pp = new ParticipationDataBean();
               pp.setPpcode(rs.getInt("ppcode"));
               pp.setId(rs.getString("id"));
               pp.setTitle(rs.getString("title"));
               pp.setContents(rs.getString("contents"));
               pp.setFile(rs.getString("file"));
               pp.setViewcount(rs.getInt("viewcount"));
               pp.setReg_date(rs.getTimestamp("reg_date"));
               pp.setClause(rs.getInt("clause"));
               pp.setRequestcode(rs.getInt("requestcode"));
               pp.setPrize_money(rs.getInt("prize_money"));
               pps.add(pp);
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
       return pps;
    } 
		
	 //나의 참여작 정보를 표시
    public List<ParticipationDataBean> getParticipations(String id) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ParticipationDataBean> pps=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from participation where id = ? "
					+ "order by reg_date desc");

			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pps = new ArrayList<ParticipationDataBean>();
				do {
					ParticipationDataBean pp = new ParticipationDataBean();
					pp.setPpcode(rs.getInt("ppcode"));
					pp.setId(rs.getString("id"));
					pp.setTitle(rs.getString("title"));
					pp.setContents(rs.getString("contents"));
					pp.setFile(rs.getString("file"));
					pp.setViewcount(rs.getInt("viewcount"));
					pp.setReg_date(rs.getTimestamp("reg_date"));
					pp.setClause(rs.getInt("clause"));
					pp.setRequestcode(rs.getInt("requestcode"));
					pp.setPrize_money(rs.getInt("prize_money"));
					pps.add(pp);
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
		 return pps;
    }
    
    //콘테스트별 참여작 정보
    public List<ParticipationDataBean> getParticipations(int rqcode,int start,int end) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ParticipationDataBean> pps=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from participation where requestcode = ? "
					+ "order by reg_date desc limit ?,?");

			pstmt.setInt(1, rqcode);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pps = new ArrayList<ParticipationDataBean>();
				do {
					ParticipationDataBean pp = new ParticipationDataBean();
					pp.setId(rs.getString("id"));
					pps.add(pp);
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
		 return pps;
    }
    
    //콘테스트별 참여작 정보
    public List<ParticipationDataBean> getParticipations(int rqcode) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ParticipationDataBean> pps=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from participation where requestcode = ? "
					+ "order by reg_date desc");

			pstmt.setInt(1, rqcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pps = new ArrayList<ParticipationDataBean>();
				do {
					ParticipationDataBean pp = new ParticipationDataBean();
					pp.setPpcode(rs.getInt("ppcode"));
					pp.setId(rs.getString("id"));
					pp.setTitle(rs.getString("title"));
					pp.setContents(rs.getString("contents"));
					pp.setFile(rs.getString("file"));
					pp.setViewcount(rs.getInt("viewcount"));
					pp.setReg_date(rs.getTimestamp("reg_date"));
					pp.setClause(rs.getInt("clause"));
					pp.setRequestcode(rs.getInt("requestcode"));
					pp.setPrize_money(rs.getInt("prize_money"));
					pps.add(pp);
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
		 return pps;
    }
 
    //모든 참여작 정보
    public List<ParticipationDataBean> getParticipations(int start,int end) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ParticipationDataBean> pps=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from participation "
					+ "where ppcode in(select ppcode from request) order by reg_date desc limit ?,?");
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pps = new ArrayList<ParticipationDataBean>();
				do {
					ParticipationDataBean pp = new ParticipationDataBean();
					pp.setPpcode(rs.getInt("ppcode"));
					pp.setId(rs.getString("id"));
					pp.setTitle(rs.getString("title"));
					pp.setContents(rs.getString("contents"));
					pp.setFile(rs.getString("file"));
					pp.setViewcount(rs.getInt("viewcount"));
					pp.setReg_date(rs.getTimestamp("reg_date"));
					pp.setClause(rs.getInt("clause"));
					pp.setRequestcode(rs.getInt("requestcode"));
					pp.setPrize_money(rs.getInt("prize_money"));
					pps.add(pp);
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
		 return pps;
    } 
    
    //하나의 참여작 정보(participation/modal.jsp)
    public ParticipationDataBean getParticipation(int ppcode) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ParticipationDataBean pp=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from participation where ppcode = ? "
					+ "order by reg_date desc");
			pstmt.setInt(1, ppcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pp = new ParticipationDataBean();
				pp.setPpcode(rs.getInt("ppcode"));
				pp.setId(rs.getString("id"));
				pp.setTitle(rs.getString("title"));
				pp.setContents(rs.getString("contents"));
				pp.setFile(rs.getString("file"));
				pp.setViewcount(rs.getInt("viewcount"));
				pp.setReg_date(rs.getTimestamp("reg_date"));
				pp.setClause(rs.getInt("clause"));
				pp.setRequestcode(rs.getInt("requestcode"));
				pp.setPrize_money(rs.getInt("prize_money"));
		
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
		 return pp;
    }
    
 /* //디자이너의 참여작 정보(contest/detail.jsp--> requestParticipation.jsp)
    public ParticipationDataBean getParticipation(String id,int rqcode) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ParticipationDataBean pp=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from participation where id = ? and requestcode=? "
					+ "order by reg_date desc");
			pstmt.setString(1, id);
			pstmt.setInt(2, rqcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pp = new ParticipationDataBean();
				pp.setPpcode(rs.getInt("ppcode"));
				pp.setId(rs.getString("id"));
				pp.setTitle(rs.getString("title"));
				pp.setContents(rs.getString("contents"));
				pp.setFile(rs.getString("file"));
				pp.setReg_date(rs.getTimestamp("reg_date"));
				pp.setClause(rs.getInt("clause"));
				pp.setRequestcode(rs.getInt("requestcode"));
				pp.setPrize_money(rs.getInt("prize_money"));
		
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
		 return pp;
    }*/
    //참여작 조회수 늘리기-->participation/modal.jsp
	public int updateViewcount(int ppcode, String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x = 0;
   	    
		try {
			conn = getConnection();

			if (id == null)
				id = "";

			pstmt = conn.prepareStatement("update participation set viewcount=viewcount+1"
					+ " where ppcode = ? and id <> ?");
			// 조회수, 게시글 작성자가 아니면 조회수가 늘어난다.
			pstmt.setInt(1, ppcode);
			pstmt.setString(2, id);
			rs = pstmt.executeUpdate();
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
	public int updateParticipation(ParticipationDataBean pp) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x = 0;
    
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update participation set title=?,contents=?,file=?"
					+ " where ppcode=?");
			pstmt.setString(1, pp.getTitle());
			pstmt.setString(2, pp.getContents());
			pstmt.setString(3, pp.getFile());
			pstmt.setInt(4, pp.getPpcode());
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
    public int deleteParticipation(int ppcode) 
            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
			        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from participation where ppcode=?");
			pstmt.setInt(1, ppcode);
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