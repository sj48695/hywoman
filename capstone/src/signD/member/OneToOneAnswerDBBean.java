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

public class OneToOneAnswerDBBean {
	
    private static OneToOneAnswerDBBean instance = new OneToOneAnswerDBBean();
    
    public static OneToOneAnswerDBBean getInstance() {
        return instance;
    }
    
    private OneToOneAnswerDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}


	public int insertOneToOneAnswer(OneToOneAnswerDataBean answer) 
	            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
			        
		try{
			conn = getConnection();
			            
			pstmt = conn.prepareStatement( "insert into OneToOneAnswer(id,contents,file,requestcode,reg_date) values (?,?,?,?,?)");

			pstmt.setString(1, answer.getId());
			pstmt.setString(2, answer.getContents());
			pstmt.setString(3, answer.getFile());
			pstmt.setInt(4, answer.getRequestcode());
			pstmt.setTimestamp(5, answer.getReg_date());
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
	
	/*//참여작의 개수
    public int getOneToOneAnswersCount(String category, String keyword) 
        throws Exception {
    Connection conn = null;
     PreparedStatement pstmt = null;
     ResultSet rs = null;
     int count=0;
     String sql = "";
     String sql1 = "";
     
     try {
        
            conn = getConnection();
         
            sql = "select count(*) from OneToOneAnswer where answercode in(select answercode from request) ";
            sql1 = "select count(*) from OneToOneAnswer where answercode in(select answercode from request where category = ?) ";
            
            if (!keyword.equals("")) {// 검색이 될 경우
               sql += "and (title like ? or contents like ? or id like ?) order by reg_date desc";
               pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, "%" + keyword + "%");
           pstmt.setString(2, "%" + keyword + "%");
           pstmt.setString(3, "%" + keyword + "%");
            } else {// 검색을 안하는 경우
               sql += "order by reg_date desc";
               sql1 += "order by reg_date desc";
               
               if(category.equals("")){
              pstmt = conn.prepareStatement(sql);
           }else {
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
	*/
	//내 1:1답변의 개수
	public int getOneToOneAnswerCount(String id) 
	    throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        
        try {
        	
		conn = getConnection();
		pstmt = conn.prepareStatement("select count(*) from OneToOneAnswer where id = ?");
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
		
	 //나의 1:1답변 정보를 표시
    public List<OneToOneAnswerDataBean> getOneToOneAnswers(String id) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<OneToOneAnswerDataBean> answers=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from OneToOneAnswer where id = ? "
					+ "order by reg_date desc");

			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				answers = new ArrayList<OneToOneAnswerDataBean>();
				do {
					OneToOneAnswerDataBean answer = new OneToOneAnswerDataBean();
					answer.setAnswercode(rs.getInt("answercode"));
					answer.setId(rs.getString("id"));
					answer.setContents(rs.getString("contents"));
					answer.setFile(rs.getString("file"));
					answer.setReg_date(rs.getTimestamp("reg_date"));
					answer.setRequestcode(rs.getInt("requestcode"));
					answer.setPrize_money(rs.getInt("prize_money"));
					answers.add(answer);
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
		 return answers;
    }
    
    //1:1답변 정보
    public List<OneToOneAnswerDataBean> getOneToOneAnswers(int answercode,int start,int end) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<OneToOneAnswerDataBean> answers=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from OneToOneAnswer where answercode = ? "
					+ "order by reg_date desc limit ?,?");

			pstmt.setInt(1, answercode);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				answers = new ArrayList<OneToOneAnswerDataBean>();
				do {
					OneToOneAnswerDataBean answer = new OneToOneAnswerDataBean();
					answer.setId(rs.getString("id"));
					answers.add(answer);
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
		 return answers;
    }
  /*  
    //콘테스트별 참여작 정보
    public List<OneToOneAnswerDataBean> getOneToOneAnswers(int rqcode) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<OneToOneAnswerDataBean> answers=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from OneToOneAnswer where requestcode = ? "
					+ "order by reg_date desc");

			pstmt.setInt(1, rqcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				answers = new ArrayList<OneToOneAnswerDataBean>();
				do {
					OneToOneAnswerDataBean answer = new OneToOneAnswerDataBean();
					answer.setAnswercode(rs.getInt("answercode"));
					answer.setId(rs.getString("id"));
					answer.setContents(rs.getString("contents"));
					answer.setFile(rs.getString("file"));
					answer.setRequestcode(rs.getInt("requestcode"));
					answer.setPrize_money(rs.getInt("prize_money"));
					answer.setReg_date(rs.getTimestamp("reg_date"));
					answers.add(answer);
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
		 return answers;
    }
 */
   /* //모든 참여작 정보
    public List<OneToOneAnswerDataBean> getOneToOneAnswers(int start,int end) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<OneToOneAnswerDataBean> answers=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from OneToOneAnswer "
					+ "where designer_id in(select designer_id from onetoonerequest) order by reg_date desc limit ?,?");
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				answers = new ArrayList<OneToOneAnswerDataBean>();
				do {
					OneToOneAnswerDataBean answer = new OneToOneAnswerDataBean();
					answer.setAnswercode(rs.getInt("answercode"));
					answer.setId(rs.getString("id"));
					answer.setContents(rs.getString("contents"));
					answer.setFile(rs.getString("file"));
					answer.setRequestcode(rs.getInt("requestcode"));
					answer.setPrize_money(rs.getInt("prize_money"));
					answer.setReg_date(rs.getTimestamp("reg_date"));
					answers.add(answer);
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
		 return answers;
    } */
    
    //하나의 1:1답변 정보(OneToOneAnswerModal.jsp)
    public OneToOneAnswerDataBean getOneToOneAnswer(int answercode) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        OneToOneAnswerDataBean answer=null;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from OneToOneAnswer where answercode = ? order by reg_date desc");
			pstmt.setInt(1, answercode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				answer = new OneToOneAnswerDataBean();
				answer.setAnswercode(rs.getInt("answercode"));
				answer.setId(rs.getString("id"));
				answer.setContents(rs.getString("contents"));
				answer.setFile(rs.getString("file"));
				answer.setRequestcode(rs.getInt("requestcode"));
				answer.setPrize_money(rs.getInt("prize_money"));
				answer.setReg_date(rs.getTimestamp("reg_date"));
		
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
		 return answer;
    }
    
    //하나의 1:1답변 정보(OTOAnswerModal.jsp)
    public OneToOneAnswerDataBean getOneToOneAnswer(int rqcode,String id) 
    		throws Exception {
   	 	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        OneToOneAnswerDataBean answer=null;
        LogonDBBean logon=LogonDBBean.getInstance();
        LogonDataBean member=logon.getMember(id);
        String sql=null;
        
		try {
			conn = getConnection();
			sql = "SELECT * FROM onetooneanswer "
				+ "WHERE requestcode=? and id in( "
				+ "SELECT designer_id "
				+ "from onetoonerequest ";
			if (member.getType().equals("의뢰인")) {
				sql += "WHERE requester_id=?)";
			} else {
				sql += "WHERE designer_id=?)";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rqcode);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				answer = new OneToOneAnswerDataBean();
				answer.setAnswercode(rs.getInt("answercode"));
				answer.setId(rs.getString("id"));
				answer.setContents(rs.getString("contents"));
				answer.setFile(rs.getString("file"));
				answer.setRequestcode(rs.getInt("requestcode"));
				answer.setPrize_money(rs.getInt("prize_money"));
				answer.setReg_date(rs.getTimestamp("reg_date"));
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
		 return answer;
    }
    
    
    //참여작 수정
	public int updateOneToOneAnswer(OneToOneAnswerDataBean answer) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x = 0;
    
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update OneToOneAnswer set contents=?,file=? where answercode=?");
			pstmt.setString(1, answer.getContents());
			pstmt.setString(2, answer.getFile());
			pstmt.setInt(3, answer.getAnswercode());
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
    public int deleteOneToOneAnswer(int answercode) 
            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs=0;
		int x=0;
			        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from OneToOneAnswer where answercode=?");
			pstmt.setInt(1, answercode);
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