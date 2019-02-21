package signD.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LogonDBBean {
	
    private static LogonDBBean instance = new LogonDBBean();
    
    public static LogonDBBean getInstance() {
        return instance;
    }
    
    private LogonDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	public int insertMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x = 0;
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement(
			    "insert into MEMBER(id,passwd,name,tel,email,type,reg_date) values (?,?,?,?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getType());
			pstmt.setTimestamp(7, member.getReg_date());
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
	
	public String selectName(String id) //id에 해당하는 name가져오기
	    throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		String name="";
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement("select name from member where id=?");
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()) name=rs.getString(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return name;
	}
	public String selectType(String id) //id에 해당하는 type가져오기
	    throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		String type="";
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement(
			    "select type from member where id=?");
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()) type=rs.getString(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return type;
	}
	
	public int userCheck(String id, String passwd) 
				throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement(
			    "select passwd from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();

			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(passwd))
					x = 1; //비밀번호 맞음
				else
					x = 0; //비밀번호 틀림
			}else
				x = -1;//아이디 없음
						
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally{
			if (rs != null) 
				try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	

	 public int confirmId(String id) //중복아이디 체크
	 throws Exception {
		 Connection conn = null;
         PreparedStatement pstmt = null;
		 ResultSet rs= null;
		 int x=-1;
       
		 try {
			 conn = getConnection();
           
             pstmt = conn.prepareStatement(
           	  "select id from member where id = ?");
             pstmt.setString(1, id);
             rs= pstmt.executeQuery();

			 if(rs.next())
				 x= 1; //해당 아이디 있음
			 else
				 x= -1;//해당 아이디 없음		
         }catch(Exception ex) {
             ex.printStackTrace();
         } finally {
			 if (rs != null) 
				 try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
		 return x;
	 }
	 
	 //회원정보를 수정하기 위해 기존의 정보를 표시
     public LogonDataBean getMember(String id) 
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         LogonDataBean member=null;
         
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
           	     "select * from member where id = ?");
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();

             if (rs.next()) {
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
                 member.setChoosecount(rs.getInt("choosecount"));
				 member.setMoney(rs.getInt("money"));
				 member.setOp_onetoone(rs.getInt("op_onetoone"));
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
		 return member;
     }
     
   //디자이너들의 수를 표시-->designerList.jsp에서 사용
     public int getDesignerCount(String keyword) throws Exception {
    	 Connection conn = null;
    	 PreparedStatement pstmt = null;
    	 ResultSet rs = null;
         int count=0;
         String sql = "";
         
		try {
			conn = getConnection();
			sql = "select count(*) from member where type='디자이너' ";
			if (!keyword.equals("")) {// 검색이 될 경우
				sql += "and id like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
			} else {// 검색을 안하는 경우
				pstmt = conn.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception ex) {
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

     
   //top디자이너-->designerList.jsp,main.jsp에서 사용
	public List<LogonDataBean> designerListTop(int start,int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<LogonDataBean> designers = null;
		LogonDataBean designer = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from "
										+ "member m left outer join participation p "
										+ "on m.id = p.id "
										+ "where m.type = '디자이너' group by m.id "
										+ "order by sum(p.prize_money) desc, m.choosecount desc limit ?,?");
			pstmt.setInt(1, start - 1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				designers = new ArrayList<LogonDataBean>();
				do {
					designer = new LogonDataBean();

					designer.setId(rs.getString("id"));
					designer.setPasswd(rs.getString("passwd"));
					designer.setName(rs.getString("name"));
					designer.setReg_date(rs.getTimestamp("reg_date"));
					designer.setTel(rs.getString("tel"));
					designer.setEmail(rs.getString("email"));
					designer.setType(rs.getString("type"));
					designer.setProfileimg(rs.getString("profileimg"));
					designer.setIntroduction(rs.getString("introduction"));
					designer.setChoosecount(rs.getInt("choosecount"));
					designer.setMoney(rs.getInt("money"));
					designer.setOp_onetoone(rs.getInt("op_onetoone"));
					designers.add(designer);

				} while (rs.next());
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
		return designers;
	}
   //디자이너들의 정보를 표시-->designerList.jsp에서 사용
     public List<LogonDataBean> getDesignerList(int start,int end,String keyword,String order) 
    		 throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<LogonDataBean> designers = null;
		LogonDataBean designer = null;
		String sql = "";
		try {
			conn = getConnection();

			sql = "select * from "
				+ "member m left outer join participation p "
				+ "on m.id = p.id "
				+ "where m.type = '디자이너'";

			if (!keyword.equals("")) {// 검색이 될 경우
				sql += " and m.id like ? group by m.id limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setInt(2, start - 1);
				pstmt.setInt(3, end);
			} else {// 검색을 안하는 경우
				if (order.equals("wincount")) {// 우승횟수순
					sql += " group by m.id order by m.choosecount desc limit ?,?";
				} else if (order.equals("prize")) {// 상금순
					sql += " group by m.id order by sum(p.prize_money) desc limit ?,?";
				} else {
					sql += " group by m.id limit ?,?";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				designers = new ArrayList<LogonDataBean>();
				do {
					designer = new LogonDataBean();
					designer.setId(rs.getString("id"));
					designer.setPasswd(rs.getString("passwd"));
					designer.setName(rs.getString("name"));
					designer.setReg_date(rs.getTimestamp("reg_date"));
					designer.setTel(rs.getString("tel"));
					designer.setEmail(rs.getString("email"));
					designer.setType(rs.getString("type"));
					designer.setProfileimg(rs.getString("profileimg"));
					designer.setIntroduction(rs.getString("introduction"));
					designer.setChoosecount(rs.getInt("choosecount"));
					designer.setMoney(rs.getInt("money"));
					designer.setOp_onetoone(rs.getInt("op_onetoone"));
					designers.add(designer);

				} while (rs.next());
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
		return designers;
     }
     
   //총 누적 상금액
  	public int getTotalPrize_money() throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;
  		int cost = 0;

  		try {

  			conn = getConnection();
  			pstmt = conn.prepareStatement("select sum(prize_money) from participation");
  			rs = pstmt.executeQuery();

  			if (rs.next()) {
  				cost = rs.getInt(1);
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
  		return cost;
  	}
     
   //디자이너별 상금액
 	public int getPrize_money(String id) throws Exception {
 		Connection conn = null;
 		PreparedStatement pstmt = null;
 		ResultSet rs = null;
 		int cost = 0;

 		try {

 			conn = getConnection();
 			pstmt = conn.prepareStatement("select sum(prize_money) from participation where id=?");
 			pstmt.setString(1, id);
 			rs = pstmt.executeQuery();

 			if (rs.next()) {
 				cost = rs.getInt(1);
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
 		return cost;
 	}
   
     public int updateMember(LogonDataBean member,String id) //회원의 정보수정
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
       int rs=0;
       int x=0;
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
               "update member set passwd=?,name=?,tel=?,email=?,introduction=? where id=?");
             pstmt.setString(1, member.getPasswd());
             pstmt.setString(2, member.getName());
             pstmt.setString(3, member.getTel());
             pstmt.setString(4, member.getEmail());
             pstmt.setString(5, member.getIntroduction());
             pstmt.setString(6, id);           
             rs=pstmt.executeUpdate();
             
             if(rs>0) x=1;
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
     
	// 디자이너 회원 1:1의뢰받기 설정
	public int updateOneToOne(int check,String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x = 0;
		//String sql=null;

		try {
			conn = getConnection();
			/*sql="update member set ";
			if(check==1) {
				sql+="op_onetoone=1";
			}else{
				sql+="op_onetoone=0";
			}*/

			pstmt = conn.prepareStatement("update member set op_onetoone="+check+" where id=? and type='디자이너'");
			pstmt.setString(1, id);
			rs = pstmt.executeUpdate();
			if (rs > 0)
				x = 1;
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
     
	// 프로필 이미지를 수정시 사용하는 메소드
	public void updateImg(LogonDataBean member, String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;

		try {
			conn = getConnection();

			sql = "update member set profileimg=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getProfileimg());
			pstmt.setString(2, id);

			pstmt.executeUpdate();

		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
	}
   
	/*public int deleteMember(String id, String passwd) //회원탈퇴
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String dbpasswd="";
		int x=-1;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select passwd from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("passwd");
				if (dbpasswd.equals(passwd)) {
					pstmt = conn.prepareStatement("delete from member where id=?");
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x = 1; // 회원탈퇴 성공
				} else
					x = 0; // 비밀번호 틀림
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
	}*/
	
	public int deleteMember(String id) //회원탈퇴
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=-1;
		
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from member where id=?");
			pstmt.setString(1, id);
			rs=pstmt.executeUpdate();
			if(rs>0)x = 1; // 회원탈퇴 성공
			
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
}