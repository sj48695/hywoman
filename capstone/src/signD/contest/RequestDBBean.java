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

import signD.member.LogonDBBean;
import signD.member.LogonDataBean;

public class RequestDBBean {
	
    private static RequestDBBean instance = new RequestDBBean();
    
    public static RequestDBBean getInstance() {
        return instance;
    }
    
    private RequestDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	public int insertRequest(RequestDataBean request) 
            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement( "insert into request(id,title,company_name,service,category,request,file,"
					+ "viewcount,cost,reg_date,end_date,ppcode,color,job_kind,pages,website,plan,slogan,total,self_tax,op_main,op_bgcolor,op_week) "
					+ "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	
			pstmt.setString(1, request.getId());
			pstmt.setString(2, request.getTitle());
			pstmt.setString(3, request.getCompany_name());
			pstmt.setString(4, request.getService());
			pstmt.setString(5, request.getCategory());
			pstmt.setString(6, request.getRequest());
			pstmt.setString(7, request.getFile());
			pstmt.setInt(8, request.getViewcount());
			pstmt.setInt(9, request.getCost());
			pstmt.setTimestamp(10, request.getReg_date());
			pstmt.setTimestamp(11, request.getEnd_date());
			pstmt.setInt(12, request.getPpcode());
			pstmt.setString(13, request.getColor());
			pstmt.setString(14, request.getJob_kind());
			pstmt.setString(15, request.getPages());
			pstmt.setString(16, request.getWebsite());
			pstmt.setString(17, request.getPlan());
			pstmt.setString(18, request.getSlogan());
			pstmt.setInt(19, request.getTotal());
			pstmt.setInt(20, request.getSelf_tax());
			pstmt.setInt(21, request.getOp_main());
			pstmt.setInt(22, request.getOp_bgcolor());
			pstmt.setInt(23, request.getOp_week());
			rs=pstmt.executeUpdate();
			
			if(rs>0) {
				x=1;
			}
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
	
	//마이페이지에서 사용하는 콘테스트의 개수
	public int getMyRequestCount(String id,String current) throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        LogonDBBean logon=LogonDBBean.getInstance();
        LogonDataBean member=null;
        int count=0;
        String sql=null;
        
		try {
			conn = getConnection();
			if(id==null) {
				id="";
			}
			member=logon.getMember(id);
			if(member.getType().equals("의뢰인")) {
				sql="select count(*) from request where id = ? and TO_DAYS(end_date)-TO_DAYS(now()) ";
				
			}else if(member.getType().equals("디자이너")) {
				sql="select count(*) from request "
					+ "where requestcode in(select requestcode "
					+ "from participation where id=?) and TO_DAYS(end_date)-TO_DAYS(now()) ";
			}
		
			if (current.equals("ing")) {// 진행중
				sql += ">=0";
			} else if (current.equals("end")) {// 종료된
				sql += "<0";
			}
			
			pstmt = conn.prepareStatement(sql);
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
	
	//전체 의뢰글의 개수
	   public int getRequestCount(String current, String keyword,String category) throws Exception {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      int count = 0;
	      String sql="";
	      String sql1="";
	      
	      try {
	         conn = getConnection();
	         sql = "select count(*) from request where TO_DAYS(end_date)-TO_DAYS(now()) ";
	         sql1 = "select count(*) from request where TO_DAYS(end_date)-TO_DAYS(now()) ";
	         
	         if (current.equals("ing")) {// 진행중
	            sql += ">=0 ";
	            sql1 += ">=0 and category = ? order by reg_date desc";
	            
	            if (!keyword.equals("")) {// 검색이 될 경우
	               sql += "and (title like ? or company_name like ? or id like ?) order by reg_date desc";
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setString(1, "%" + keyword + "%");
	               pstmt.setString(2, "%" + keyword + "%");
	               pstmt.setString(3, "%" + keyword + "%");
	            } else {// 검색을 안하는 경우
	               sql += "order by reg_date desc";
	               if(category.equals("")){
	                      pstmt = conn.prepareStatement(sql);
	                  }else{
	                      pstmt = conn.prepareStatement(sql1);
	                      pstmt.setString(1, category);
	                  }
	            }
	         } else if (current.equals("end")) {// 종료된
	            sql += "<0 ";
	            sql1 += "<0 and category = ? order by reg_date desc";
	            
	            if (!keyword.equals("")) {// 검색이 될 경우
	               sql += "and (title like ? or company_name like ? or id like ?) order by reg_date desc";
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setString(1, "%" + keyword + "%");
	               pstmt.setString(2, "%" + keyword + "%");
	               pstmt.setString(3, "%" + keyword + "%");
	            } else {// 검색을 안하는 경우
	               sql += "order by reg_date desc";
	               if(category.equals("")){
	                      pstmt = conn.prepareStatement(sql);
	                  }else{
	                      pstmt = conn.prepareStatement(sql1);
	                      pstmt.setString(1, category);
	                  }
	            }
	         }
	         rs = pstmt.executeQuery();

	         if (rs.next()) {
	            count = rs.getInt(1);
	         }
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally {
	         if (rs != null)
	            try { rs.close(); } catch (SQLException ex) {}
	         if (pstmt != null)
	            try {pstmt.close();} catch (SQLException ex) {}
	         if (conn != null)
	            try {conn.close();} catch (SQLException ex) {}
	      }
	      return count;
	   }
	
	//전체 의뢰글의 개수
	public int getRequestCount(String current, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql="";

		try {
			conn = getConnection();
			sql = "select count(*) from request where TO_DAYS(end_date)-TO_DAYS(now()) ";
			if (current.equals("ing")) {// 진행중
				sql += ">=0 ";
				if (!keyword.equals("")) {// 검색이 될 경우
					sql += "and title like ? or company_name like ? or id like ? order by reg_date desc";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%");
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
				} else {// 검색을 안하는 경우
					sql += "order by reg_date desc";
					pstmt = conn.prepareStatement(sql);
				}	
			} else if (current.equals("end")) {// 종료된
				sql += "<0 ";
				if (!keyword.equals("")) {// 검색이 될 경우
					sql += "and title like ? or company_name like ? or id like ? order by reg_date desc";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%");
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
				} else {// 검색을 안하는 경우
					sql += "order by reg_date desc";
					pstmt = conn.prepareStatement(sql);
				}
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null)
				try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)
				try {conn.close();} catch (SQLException ex) {}
		}
		return count;
	}

	//전체 의뢰글의 개수
	public int getRequestCount(String current) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql=null;

		try {
			conn = getConnection();
			sql = "select count(*) from request where TO_DAYS(end_date)-TO_DAYS(now()) ";
			if (current.equals("ing")) {// 진행중
				sql += ">=0 ";
			} else if (current.equals("end")) {// 종료된
				sql += "<0 ";
			} else if (current.equals("deadline imminent")) {// 마감임박한
				sql += ">=0 and TO_DAYS(end_date)-TO_DAYS(now())<=3";// 3일이내
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				count = rs.getInt(1);

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null)
				try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)
				try {conn.close();} catch (SQLException ex) {}
		}
		return count;
	}
		
	//콘테스트별 참여자의 수
	public int getPPRequestCount(int rqcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(participation.requestcode) from "
					+ "request left outer join participation "
					+ "on request.requestcode=participation.requestcode "
					+ "where request.requestcode=? "
					+ "group by request.requestcode");
			pstmt.setInt(1, rqcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count=rs.getInt(1);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null)
				try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)
				try {conn.close();} catch (SQLException ex) {}
		}
		return count;
	}
	
	//main.jsp (op_main) 메인상단노출
	public int contestMain4Count() throws Exception {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<RequestDataBean> rqs=null;
	    int count=0;
	    String sql="";
	    
		try {
			conn = getConnection();

			sql="select count(*) from request "
					+ "where TO_DAYS(end_date)-TO_DAYS(now())>=0 and op_main=1 "
					+ "order by viewcount desc,reg_date desc limit 0,4";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				count=rs.getInt(1);
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
	
	//콘테스트별 D-day
	public String getDday(int rqcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String days = "";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select TO_DAYS(end_date)-TO_DAYS(now()) from request where requestcode=?");
			pstmt.setInt(1, rqcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				days=Integer.toString(rs.getInt(1));
				if(rs.getInt(1)==0) {
					days="day";
				}else if(rs.getInt(1)<0) {
					days="0";
				}
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null)
				try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)
				try {conn.close();} catch (SQLException ex) {}
		}
		return days;
	}
	
	 //콘테스트 정보를 표시
	public List<RequestDataBean> getMyRequests(String id,int start,int end,String current) 
			throws Exception {
		 	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    LogonDBBean logon=LogonDBBean.getInstance();
        LogonDataBean member=logon.getMember(id);
	    List<RequestDataBean> rqs=null;
	    String sql=null;
	    
		try {
			conn = getConnection();
			if (member.getType().equals("의뢰인")) {
				sql = "select * from request where id = ? and TO_DAYS(end_date)-TO_DAYS(now()) ";
			} else if (member.getType().equals("디자이너")) {
				sql = "select * from request where requestcode in(select requestcode "
						+ "from participation where id=?) and TO_DAYS(end_date)-TO_DAYS(now()) ";
			}
			
			if (current.equals("ing")) {// 진행중
				sql += ">=0";
			} else if (current.equals("end")) {// 종료된
				sql += "<0";
			}
			sql+= " order by reg_date desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
	
			pstmt.setString(1, id);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				rqs = new ArrayList<RequestDataBean>();
				do {
					RequestDataBean rq = new RequestDataBean();
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
					rq.setPages(rs.getString("pages"));
					rq.setWebsite(rs.getString("website"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setOp_main(rs.getInt("op_main"));
					rq.setOp_bgcolor(rs.getInt("op_bgcolor"));
					rq.setOp_week(rs.getInt("op_week"));
					rqs.add(rq);
	
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
		 return rqs;
	} 
	
	 //의뢰글 정보를 표시
	public List<RequestDataBean> getRequests(int start,int end,String current) 
			throws Exception {
		 	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<RequestDataBean> rqs=null;
	    String sql="";
	    
		try {
			conn = getConnection();

			sql="select * from request where TO_DAYS(end_date)-TO_DAYS(now()) ";
			if(current.equals("ing")) {//진행중
						sql+= ">=0";
			}else if(current.equals("end")){//종료된
						sql+= "<0";		
			}else if(current.equals("deadline imminent")){//마감임박한
						sql+= ">=0 and TO_DAYS(end_date)-TO_DAYS(now())<=3";//3일이내
			}
			sql+= " order by reg_date desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
	
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				rqs = new ArrayList<RequestDataBean>();
				do {
					RequestDataBean rq = new RequestDataBean();
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
					rq.setPages(rs.getString("pages"));
					rq.setWebsite(rs.getString("website"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setOp_main(rs.getInt("op_main"));
					rq.setOp_bgcolor(rs.getInt("op_bgcolor"));
					rq.setOp_week(rs.getInt("op_week"));
					rqs.add(rq);
	
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
		 return rqs;
	}
	
	/*//콘테스트 검색
	public List<RequestDataBean> getSearchRequests(int start,int end,String current,String keyword) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<RequestDataBean> rqs=null;
		String sql="";
       
		try {
			conn = getConnection();

			sql = "select * from request where TO_DAYS(end_date)-TO_DAYS(now()) ";
			if (current.equals("ing")) {// 진행중
				sql += ">=0 ";
				if (!keyword.equals("")) {// 검색이 될 경우
					sql += "and title like ? or company_name like ? or id like ? order by reg_date desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%");
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
					pstmt.setInt(4, start - 1);
					pstmt.setInt(5, end);
				} else {// 검색을 안하는 경우
					sql += "order by reg_date desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, start - 1);
					pstmt.setInt(2, end);
				}
			} else if (current.equals("end")) {// 종료된
				sql += "<0 ";
				if (!keyword.equals("")) {// 검색이 될 경우
					sql += "and title like ? or company_name like ? or id like ? order by reg_date desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%");
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
					pstmt.setInt(4, start - 1);
					pstmt.setInt(5, end);
				} else {// 검색을 안하는 경우
					sql += "order by reg_date desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, start - 1);
					pstmt.setInt(2, end);
				}
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				rqs = new ArrayList<RequestDataBean>();
				do {
					RequestDataBean rq = new RequestDataBean();
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
					rq.setPages(rs.getString("pages"));
					rq.setWebsite(rs.getString("website"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setOp_main(rs.getInt("op_main"));
					rq.setOp_bgcolor(rs.getInt("op_bgcolor"));
					rq.setOp_week(rs.getInt("op_week"));
					rqs.add(rq);

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
		return rqs;
	}*/
	
	//콘테스트 검색
	public List<RequestDataBean> getSearchRequests(int start,int end,String current,String keyword,String category) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<RequestDataBean> rqs = null;
		String sql = "";

		try {
			conn = getConnection();

			sql = "select * from request where TO_DAYS(end_date)-TO_DAYS(now()) ";

			if (current.equals("ing")) {// 진행중
				sql += ">=0 ";
				if (!keyword.equals("")) {// 검색이 될 경우
					sql += "and (title like ? or company_name like ? or id like ?) order by reg_date desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%");
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
					pstmt.setInt(4, start - 1);
					pstmt.setInt(5, end);
				} else {// 검색을 안하는 경우
					if (category.equals("")) {
						sql += "order by op_main desc, reg_date desc limit ?,?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, start - 1);
						pstmt.setInt(2, end);
					} else {
						sql += "and category = ? order by op_main desc, reg_date desc limit ?,?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, category);
						pstmt.setInt(2, start - 1);
						pstmt.setInt(3, end);
					}
				}
			} else if (current.equals("end")) {// 종료된
				sql += "<0 ";
				if (!keyword.equals("")) {// 검색이 될 경우
					sql += "and (title like ? or company_name like ? or id like ?) order by reg_date desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%");
					pstmt.setString(2, "%" + keyword + "%");
					pstmt.setString(3, "%" + keyword + "%");
					pstmt.setInt(4, start - 1);
					pstmt.setInt(5, end);
				} else {// 검색을 안하는 경우
					if (category.equals("")) {
						sql += "order by op_main desc, reg_date desc limit ?,?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, start - 1);
						pstmt.setInt(2, end);
					} else {
						sql += "and category = ? order by op_main desc, reg_date desc limit ?,?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, category);
						pstmt.setInt(2, start - 1);
						pstmt.setInt(3, end);
					}
				}
			}
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				rqs = new ArrayList<RequestDataBean>();
				do {
					RequestDataBean rq = new RequestDataBean();
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
					rq.setPages(rs.getString("pages"));
					rq.setWebsite(rs.getString("website"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setOp_main(rs.getInt("op_main"));
					rq.setOp_bgcolor(rs.getInt("op_bgcolor"));
					rq.setOp_week(rs.getInt("op_week"));
					rqs.add(rq);
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
		return rqs;
	}
	
	//contestIngList.jsp/contestEndList.jsp 조회순top3
	public List<RequestDataBean> contestListTop3(String current) 
			throws Exception {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<RequestDataBean> rqs=null;
	    String sql="";
	    
		try {
			conn = getConnection();

			sql="select * from request where TO_DAYS(end_date)-TO_DAYS(now()) ";
			if(current.equals("ing")) {//진행중
						sql+= ">=0";
			}else if(current.equals("end")){//종료된
						sql+= "<0";		
			}
			sql+= " order by viewcount desc,reg_date desc limit 0,3";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				rqs = new ArrayList<RequestDataBean>();
				do {
					RequestDataBean rq = new RequestDataBean();
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
					rq.setPages(rs.getString("pages"));
					rq.setWebsite(rs.getString("website"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setOp_main(rs.getInt("op_main"));
					rq.setOp_bgcolor(rs.getInt("op_bgcolor"));
					rq.setOp_week(rs.getInt("op_week"));
					rqs.add(rq);
	
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
		 return rqs;
	}
	//main.jsp 
	public List<RequestDataBean> contestMain4() throws Exception {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<RequestDataBean> rqs=null;
	    int ppcount=0;
	    String sql="";
	    
		try {
			conn = getConnection();
			sql="select rq.*,count(pp.requestcode) from request rq left outer join participation pp "
					+ "on rq.requestcode=pp.requestcode "
					+ "where TO_DAYS(rq.end_date)-TO_DAYS(now())>=0 "
					+ "group by rq.requestcode "
					+ "order by rq.cost desc,rq.viewcount desc,count(pp.requestcode) DESC,rq.reg_date desc limit 0,4";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				rqs = new ArrayList<RequestDataBean>();
				do {
					RequestDataBean rq = new RequestDataBean();
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
					rq.setPages(rs.getString("pages"));
					rq.setWebsite(rs.getString("website"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setOp_main(rs.getInt("op_main"));
					rq.setOp_bgcolor(rs.getInt("op_bgcolor"));
					rq.setOp_week(rs.getInt("op_week"));
					rqs.add(rq);
	
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
		 return rqs;
	}

	 //의뢰글 정보를 표시-->contest/detail.jsp
	public RequestDataBean getRequest(int rqcode) 
			throws Exception {
		 	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    RequestDataBean rq=null;
	    
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from request where requestcode=? order by reg_date desc ");
			pstmt.setInt(1, rqcode);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				
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
				rq.setPages(rs.getString("pages"));
				rq.setWebsite(rs.getString("website"));
				rq.setPlan(rs.getString("plan"));
				rq.setSlogan(rs.getString("slogan"));
				rq.setTotal(rs.getInt("total"));
				rq.setSelf_tax(rs.getInt("self_tax"));
				rq.setOp_main(rs.getInt("op_main"));
				rq.setOp_bgcolor(rs.getInt("op_bgcolor"));
				rq.setOp_week(rs.getInt("op_week"));
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
		 return rq;
	}
	
	 //의뢰글 조회수 늘리기-->contest/detail.jsp
	public void updateViewcount(int rqcode,String id) 
			throws Exception {
		 	Connection conn = null;
	    PreparedStatement pstmt = null;
	    
		try {
			conn = getConnection();

			if (id == null)
				id = "";

			pstmt = conn.prepareStatement("update request set viewcount=viewcount+1 where requestcode = ? and id <> ?");
			// 조회수, 게시글 작성자가 아니면 조회수가 늘어난다.
			pstmt.setInt(1, rqcode);
			pstmt.setString(2, id);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
	    }finally {
	        if (pstmt != null) 
	       	 try { pstmt.close(); } catch(SQLException ex) {}
	        if (conn != null) 
	       	 try { conn.close(); } catch(SQLException ex) {}
	    }
	}
	
	//의뢰자가 채택하기 
	public int updatePpcode(int rqcode, int ppcode,int prize_money) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		int check=0;
		String sql="";
			        
		try{
			conn = getConnection();
			sql="select ppcode from request where requestcode=?";//해당콘테스트의 채택된 참여작코드
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rqcode);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				sql="update member set choosecount = choosecount";//참여한 디자이너의 우승 수
				if(rs.getInt(1)==0) {//채택이 안되어있는 상태(채택하기)
					sql += " + 1 where id=(select id from participation where ppcode=?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ppcode);
				}else {//채택이 되어있는 상태(채택취소)
					sql += " - 1 where id=(select id from participation where ppcode=?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, rs.getInt(1));
					ppcode = 0;
				}
				pstmt.executeUpdate();
				
				sql="update request set ppcode=? where requestcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ppcode);
				pstmt.setInt(2, rqcode);
			
				if(pstmt.executeUpdate()>0) check=1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (rs != null) 
	       	 	try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return check;
	}
	
	//개최한 글 삭제
	public int deleteRequest(int rqcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int x=0;
		int rs=0;
		String sql="";
			        
		try {
			conn = getConnection();
			sql = "delete from request where requestcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rqcode);
			rs = pstmt.executeUpdate();

			if (rs > 0) {
				x = 1;
			}
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