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

public class QnADBBean {
	
    private static QnADBBean instance = new QnADBBean();
    
    public static QnADBBean getInstance() {
        return instance;
    }
    
    private QnADBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	public int insertQnA(QnADataBean qna) 
	            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int r=0;
		int x=0;

		int ref = qna.getRef();
		int re_step = 0;
		int re_level = 0;
		String sql = "";
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select max(qnacode) from qna");
			rs = pstmt.executeQuery();

			if (rs.next()) {// qnacode에 값이 하나라도 있을 경우
				ref = rs.getInt(1) + 1;
				sql = "update qna set re_step=re_step+1 ";
				sql += "where re_step >= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, re_step);
				pstmt.executeUpdate();
			}
			else// qnacode의 값이 없을 경우qnacode=1
				ref = 1;
			
			pstmt = conn.prepareStatement(
					"insert into qna(id,title,contents,reg_date,re_step,re_level,ref) values (?,?,?,?,?,?,?)");

			pstmt.setString(1, qna.getId());
			pstmt.setString(2, qna.getTitle());
			pstmt.setString(3, qna.getContents());
			pstmt.setTimestamp(4, qna.getReg_date());
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, re_level);
			pstmt.setInt(7, ref);
			r=pstmt.executeUpdate();
			
			if(r>0) x=1;
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}

	//매니저가 문의사항에 답변달 때
	public int insertManagerQnA(QnADataBean qna) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int r=0;
		int x=0;
		
		int ref = qna.getRef();
		int re_step = qna.getRe_step();
		int re_level = 0;
		String sql = "";
		try {
			conn = getConnection();
			
			sql = "update qna set re_step = re_step+1 ";
			sql += "where re_step > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, re_step);//0
			pstmt.executeUpdate();
			re_step = re_step + 1;
			re_level = 1;
		
			pstmt = conn.prepareStatement(
					"insert into qna(id,title,contents,reg_date,re_step,re_level,ref) values (?,?,?,?,?,?,?)");
	
			pstmt.setString(1, qna.getId());
			pstmt.setString(2, qna.getTitle());
			pstmt.setString(3, qna.getContents());
			pstmt.setTimestamp(4, qna.getReg_date());
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, re_level);
			pstmt.setInt(7, ref);
			r=pstmt.executeUpdate();
			
			if(r>0) x=1;
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	//문의사항의 개수
	   public int getQnACount(String keyfield, String keyword) throws Exception {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      int count = 0;
	      String sql = "";

	      try {

	         conn = getConnection();
	         pstmt = conn.prepareStatement("select count(*) from qna");
	         rs = pstmt.executeQuery();
	         
	         sql = "select count(*) from qna ";
	         
	         if(!keyword.equals("")) {//검색이 될 경우
	               if(keyfield.equals("all")) {
	                  sql += "where title like ? or contents like ? or id like ? ";
	                  sql += "order by re_step asc,ref desc, reg_date desc";
	                  pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, "%"+keyword+"%");
	                pstmt.setString(2, "%"+keyword+"%");
	                pstmt.setString(3, "%"+keyword+"%");
	               }else if(keyfield.equals("title")){
	                  sql += "where title like ? ";
	                  sql += "order by re_step asc,ref desc, reg_date desc";
	                  pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, "%"+keyword+"%");
	               }else if(keyfield.equals("id")){
	                  sql += "where id like ? ";
	                  sql += "order by re_step asc,ref desc, reg_date desc";
	                  pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, "%"+keyword+"%");
	               }   
	            }else{//검색을 안하는 경우
	                  sql += "order by re_step asc,ref desc, reg_date desc";
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
	      
	    //문의사항 리스트를 표시
	    public List<QnADataBean> getQnAs(int start,int end,String keyfield,String keyword) throws Exception {
	          Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<QnADataBean> qnas=null;
	        String sql="";
	        
	      try {
	         conn = getConnection();

	         pstmt = conn.prepareStatement("select * from qna order by re_step asc,ref desc, reg_date desc limit ?,?");
	         pstmt.setInt(1, start-1);
	         pstmt.setInt(2, end);
	         rs = pstmt.executeQuery();
	         
	         sql = "select * from qna ";
	            
	            if(!keyword.equals("")) {//검색이 될 경우
	               if(keyfield.equals("all")) {
	                  sql += "where title like ? or contents like ? or id like ? ";
	                  sql += "order by re_step asc,ref desc, reg_date desc limit ?,?";
	                  pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, "%"+keyword+"%");
	                pstmt.setString(2, "%"+keyword+"%");
	                pstmt.setString(3, "%"+keyword+"%");
	                  pstmt.setInt(4, start-1);
	                 pstmt.setInt(5, end);
	               }else if(keyfield.equals("title")){
	                  sql += "where title like ? ";
	                  sql += "order by re_step asc,ref desc, reg_date desc limit ?,?";
	                  pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, "%"+keyword+"%");
	                pstmt.setInt(2, start-1);
	                 pstmt.setInt(3, end);
	               }else if(keyfield.equals("id")){
	                  sql += "where id like ? ";
	                  sql += "order by re_step asc,ref desc, reg_date desc limit ?,?";
	                  pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, "%"+keyword+"%");
	                pstmt.setInt(2, start-1);
	                 pstmt.setInt(3, end);
	               }   
	            }else{//검색을 안하는 경우
	                  sql += "order by re_step asc,ref desc, reg_date desc limit ?,?";
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setInt(1, start-1);
	                 pstmt.setInt(2, end);
	            }
	            
	            rs = pstmt.executeQuery();
	            
	         if (rs.next()) {
	            qnas = new ArrayList<QnADataBean>();
	            do {
	               QnADataBean qna = new QnADataBean();
	               qna.setQnAcode(rs.getInt("qnacode"));
	               qna.setId(rs.getString("id"));
	               qna.setTitle(rs.getString("title"));
	               qna.setContents(rs.getString("contents"));
	               qna.setReg_date(rs.getTimestamp("reg_date"));
	               qna.setRe_step(rs.getInt("re_step"));
	               qna.setRe_level(rs.getInt("re_level"));
	               qna.setRef(rs.getInt("ref"));
	               qnas.add(qna);
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
	       return qnas;
	    }
    
	// 문의사항 정보를 표시
	public QnADataBean getQnA(int qnacode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnADataBean qna = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from qna where qnacode=?");
			pstmt.setInt(1, qnacode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				qna = new QnADataBean();
				qna.setQnAcode(rs.getInt("qnacode"));
				qna.setId(rs.getString("id"));
				qna.setTitle(rs.getString("title"));
				qna.setContents(rs.getString("contents"));
				qna.setReg_date(rs.getTimestamp("reg_date"));
				qna.setRe_step(rs.getInt("re_step"));
				qna.setRe_level(rs.getInt("re_level"));
				qna.setRef(rs.getInt("ref"));
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
		 return qna;
    }
	
	 // 문의사항 수정
  	public int updateQnA(QnADataBean QnA) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		int rs = 0;
  		int x = 0;

  		try {
  			conn = getConnection();

  			pstmt = conn.prepareStatement("update qna set title=?,contents=? where qnacode=?");
  			pstmt.setString(1, QnA.getTitle());
  			pstmt.setString(2, QnA.getContents());
  			pstmt.setInt(3, QnA.getQnAcode());
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
	
	// 문의사항삭제
	public int deleteQnA(int qnacode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x=0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from qna where qnacode=?");
			pstmt.setInt(1, qnacode);
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
}