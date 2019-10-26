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

import signD.member.LogonDBBean;
import signD.member.LogonDataBean;

public class OneToOneRequestDBBean {
	
    private static OneToOneRequestDBBean instance = new OneToOneRequestDBBean();
    
    public static OneToOneRequestDBBean getInstance() {
        return instance;
    }
    
    private OneToOneRequestDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	public int insertOneToOneRequest(OneToOneRequestDataBean request) 
            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
			        
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement( "insert into onetoonerequest(requester_id,designer_id,title,company_name,service,category,request,file,"
					+ "cost,color,job_kind,plan,slogan,total,self_tax,reg_date,start_date,end_date,accept) "
					+ "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	
			pstmt.setString(1, request.getRequester_id());
			pstmt.setString(2, request.getDesigner_id());
			pstmt.setString(3, request.getTitle());
			pstmt.setString(4, request.getCompany_name());
			pstmt.setString(5, request.getService());
			pstmt.setString(6, request.getCategory());
			pstmt.setString(7, request.getRequest());
			pstmt.setString(8, request.getFile());
			pstmt.setInt(9, request.getCost());
			pstmt.setString(10, request.getColor());
			pstmt.setString(11, request.getJob_kind());
			pstmt.setString(12, request.getPlan());
			pstmt.setString(13, request.getSlogan());
			pstmt.setInt(14, request.getTotal());
			pstmt.setInt(15, request.getSelf_tax());
			pstmt.setTimestamp(16, request.getReg_date());
			pstmt.setTimestamp(17, request.getStart_date());
			pstmt.setTimestamp(18, request.getEnd_date());
			pstmt.setInt(19, request.getAccept());
			rs=pstmt.executeUpdate();
			if(rs>0) {x=1;}
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
	public int getOneToOneRequestCount(String id,String current) throws Exception {
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
			sql="select count(*) from onetoonerequest where ";
			if(member.getType().equals("의뢰인")) {//내가 작성한 1:1의뢰글의 갯수
				sql+="requester_id = ? ";
				if (current.equals("ing")) {// 진행중
					sql += "and TO_DAYS(end_date)-TO_DAYS(now()) >=0 ";
				} else if (current.equals("end")) {// 종료된
					sql += "and TO_DAYS(end_date)-TO_DAYS(now()) <0 ";
				} else if(current.equals("still")){//미확인
					sql += "and (accept = 0 or accept=2)";
				}
			}else if(member.getType().equals("디자이너")) {//의뢰받은 1:1의뢰글의 갯수
				sql+="designer_id = ? ";
				if (current.equals("ing")) {// 진행중
					sql += "and TO_DAYS(end_date)-TO_DAYS(now()) >=0 ";
				} else if (current.equals("end")) {// 종료된
					sql += "and TO_DAYS(end_date)-TO_DAYS(now()) <0 ";
				} else if(current.equals("still")){//미확인
					sql += "and accept = 0";
				}
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

	//전체 1:1의뢰글의 개수
	public int getOneToOneRequestCount(String current) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql=null;

		try {
			conn = getConnection();
			sql = "select count(*) from onetoonerequest where TO_DAYS(end_date)-TO_DAYS(now()) ";
			if (current.equals("ing")) {// 진행중
				sql += ">=0 ";
			} else if (current.equals("end")) {// 종료된
				sql += "<0 ";
			} else if(current.equals("still")){
				sql += "and (accept = 0 or accept=2) ";
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
	
	//콘테스트별 D-day
	public String getDday(int rqcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String days = "";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select TO_DAYS(end_date)-TO_DAYS(now()) from onetoonerequest where requestcode=?");
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
	public List<OneToOneRequestDataBean> getOneToOneRequests(String id,int start,int end,String current) 
			throws Exception {
		 	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    LogonDBBean logon=LogonDBBean.getInstance();
        LogonDataBean member=logon.getMember(id);
	    List<OneToOneRequestDataBean> rqs=null;
	    String sql=null;
	    
		try {
			conn = getConnection();
			sql="select * from onetoonerequest where ";
			if(member.getType().equals("의뢰인")) {
				sql+="requester_id = ? ";
				if (current.equals("ing")) {// 진행중
					sql += "and TO_DAYS(end_date)-TO_DAYS(now()) >=0 and accept = 1";
				} else if (current.equals("end")) {// 종료된
					sql += "and TO_DAYS(end_date)-TO_DAYS(now()) <0 and accept = 1";
				} else if(current.equals("still")){
					sql += "and (accept = 0 or accept=2)";
				}
				
			}else if(member.getType().equals("디자이너")){
				sql+="designer_id = ? ";
				if (current.equals("ing")) {// 진행중
					sql += "and TO_DAYS(end_date)-TO_DAYS(now()) >=0 and accept = 1";
				} else if (current.equals("end")) {// 종료된
					sql += "and TO_DAYS(end_date)-TO_DAYS(now()) <0 and accept = 1";
				} else if(current.equals("still")){
					sql += "and accept = 0";
				}
			}
			
			sql+=" order by reg_date desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
	
			pstmt.setString(1, id);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				rqs = new ArrayList<OneToOneRequestDataBean>();
				do {
					OneToOneRequestDataBean rq = new OneToOneRequestDataBean();
					rq.setRequestcode(rs.getInt("requestcode"));
					rq.setRequester_id(rs.getString("requester_id"));
					rq.setDesigner_id(rs.getString("designer_id"));
					rq.setTitle(rs.getString("title"));
					rq.setCompany_name(rs.getString("company_name"));
					rq.setService(rs.getString("service"));
					rq.setCategory(rs.getString("category"));
					rq.setRequest(rs.getString("request"));
					rq.setFile(rs.getString("file"));
					rq.setCost(rs.getInt("cost"));
					rq.setColor(rs.getString("color"));
					rq.setJob_kind(rs.getString("job_kind"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setReg_date(rs.getTimestamp("reg_date"));
					rq.setStart_date(rs.getTimestamp("start_date"));
					rq.setEnd_date(rs.getTimestamp("end_date"));
					rq.setAccept(rs.getInt("accept"));
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
	public List<OneToOneRequestDataBean> getOneToOneRequests(int start,int end,String current) 
			throws Exception {
		 	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<OneToOneRequestDataBean> rqs=null;
	    String sql="";
	    
		try {
			conn = getConnection();

			sql="select * from onetoonerequest where TO_DAYS(end_date)-TO_DAYS(now()) ";
			if(current.equals("ing")) {//진행중
						sql+= ">=0";
			}else if(current.equals("end")){//종료된
						sql+= "<0";		
			}else if(current.equals("still")){
				sql += "and (accept = 0 or accept=2)";
			}
			sql+= " order by reg_date desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
	
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				rqs = new ArrayList<OneToOneRequestDataBean>();
				do {
					OneToOneRequestDataBean rq = new OneToOneRequestDataBean();
					rq.setRequestcode(rs.getInt("requestcode"));
					rq.setRequester_id(rs.getString("requester_id"));
					rq.setDesigner_id(rs.getString("designer_id"));
					rq.setTitle(rs.getString("title"));
					rq.setCompany_name(rs.getString("company_name"));
					rq.setService(rs.getString("service"));
					rq.setCategory(rs.getString("category"));
					rq.setRequest(rs.getString("request"));
					rq.setFile(rs.getString("file"));
					rq.setCost(rs.getInt("cost"));
					rq.setColor(rs.getString("color"));
					rq.setJob_kind(rs.getString("job_kind"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setReg_date(rs.getTimestamp("reg_date"));
					rq.setStart_date(rs.getTimestamp("start_date"));
					rq.setEnd_date(rs.getTimestamp("end_date"));
					rq.setAccept(rs.getInt("accept"));
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
	//콘테스트 검색
	public List<OneToOneRequestDataBean> getSearchOneToOneRequests(int start,int end,String current,String keyword) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OneToOneRequestDataBean> rqs=null;
		String sql="";
       
		try {
			conn = getConnection();

			sql = "select * from onetoonerequest where TO_DAYS(end_date)-TO_DAYS(now()) ";
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
				rqs = new ArrayList<OneToOneRequestDataBean>();
				do {
					OneToOneRequestDataBean rq = new OneToOneRequestDataBean();
					rq.setRequestcode(rs.getInt("requestcode"));
					rq.setRequester_id(rs.getString("requester_id"));
					rq.setDesigner_id(rs.getString("designer_id"));
					rq.setTitle(rs.getString("title"));
					rq.setCompany_name(rs.getString("company_name"));
					rq.setService(rs.getString("service"));
					rq.setCategory(rs.getString("category"));
					rq.setRequest(rs.getString("request"));
					rq.setFile(rs.getString("file"));
					rq.setCost(rs.getInt("cost"));
					rq.setColor(rs.getString("color"));
					rq.setJob_kind(rs.getString("job_kind"));
					rq.setPlan(rs.getString("plan"));
					rq.setSlogan(rs.getString("slogan"));
					rq.setTotal(rs.getInt("total"));
					rq.setSelf_tax(rs.getInt("self_tax"));
					rq.setReg_date(rs.getTimestamp("reg_date"));
					rq.setStart_date(rs.getTimestamp("start_date"));
					rq.setEnd_date(rs.getTimestamp("end_date"));
					rq.setAccept(rs.getInt("accept"));
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

	 //의뢰글 정보를 표시-->requestDetail.jsp
	public OneToOneRequestDataBean getOneToOneRequest(int rqcode) 
			throws Exception {
		 	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    OneToOneRequestDataBean rq=null;
	    
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from onetoonerequest where requestcode=? order by reg_date desc ");
			pstmt.setInt(1, rqcode);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				
				rq = new OneToOneRequestDataBean();
				rq.setRequestcode(rs.getInt("requestcode"));
				rq.setRequester_id(rs.getString("requester_id"));
				rq.setDesigner_id(rs.getString("designer_id"));
				rq.setTitle(rs.getString("title"));
				rq.setCompany_name(rs.getString("company_name"));
				rq.setService(rs.getString("service"));
				rq.setCategory(rs.getString("category"));
				rq.setRequest(rs.getString("request"));
				rq.setFile(rs.getString("file"));
				rq.setCost(rs.getInt("cost"));
				rq.setColor(rs.getString("color"));
				rq.setJob_kind(rs.getString("job_kind"));
				rq.setPlan(rs.getString("plan"));
				rq.setSlogan(rs.getString("slogan"));
				rq.setTotal(rs.getInt("total"));
				rq.setSelf_tax(rs.getInt("self_tax"));
				rq.setReg_date(rs.getTimestamp("reg_date"));
				rq.setStart_date(rs.getTimestamp("start_date"));
				rq.setEnd_date(rs.getTimestamp("end_date"));
				rq.setAccept(rs.getInt("accept"));
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
	
	/*//의뢰자가 채택하기 
	public int updatePpcode(int rqcode, int ppcode,int prize_money) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int x=0;
		int rs=0;
		String sql="";
			        
		try{
			conn = getConnection();
			sql="update onetoonerequest set ppcode=? where requestcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ppcode);
			pstmt.setInt(2, rqcode);
			rs=pstmt.executeUpdate();
			
			if(rs>0) {
				sql="update member set choosecount = choosecount";
				
				if (ppcode != 0) {// 채택이 되었다면
					sql += " + 1 where id=(select id from participation where ppcode=?)";
				} else {// 채택이 취소되면
					sql += " - 1 where id=(select id from participation where ppcode=?)";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ppcode);
				pstmt.executeUpdate();
				
				
				sql="update participation set prize_money = prize_money";
				
				if (ppcode != 0) {// 채택이 되었다면
					sql += " + ? where ppcode=?";
				} else {// 채택이 취소되면
					sql += " - ? where ppcode=?";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, prize_money);
				pstmt.setInt(2, ppcode);
				pstmt.executeUpdate();
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
	}*/
	
	//디자이너 수락/거절
	public int updateAccept(OneToOneRequestDataBean otorq) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int x=0;
		int rs=0;
		String sql="";
			        
		try{
			conn = getConnection();
			sql="update onetoonerequest set ";
			if(otorq.getAccept()==1) {//수락
				sql+="start_date=?,end_date=?,accept=? where requestcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setTimestamp(1, otorq.getStart_date());
				pstmt.setTimestamp(2, otorq.getEnd_date());
				pstmt.setInt(3, otorq.getAccept());
				pstmt.setInt(4, otorq.getRequestcode());
			}else if(otorq.getAccept()==2) {
				sql+="accept=? where requestcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, otorq.getAccept());
				pstmt.setInt(2, otorq.getRequestcode());
			}
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
	
	//1:1의뢰 지우기
	public int deleteOneToOneRequest(int rqcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int x=0;
		int rs=0;
		String sql="";
			        
		try{
			conn = getConnection();
			sql="delete from onetoonerequest where requestcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rqcode);
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
}