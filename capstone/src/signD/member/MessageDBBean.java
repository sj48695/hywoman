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

public class MessageDBBean {
	
    private static MessageDBBean instance = new MessageDBBean();
    
    public static MessageDBBean getInstance() {
        return instance;
    }
    
    private MessageDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	public void insertMessage(MessageDataBean message) 
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int ref=0;
		ResultSet rs=null;
		String sql=null;
		try{
			conn = getConnection();
			
			sql="select max(ref) from message";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {// ref에 값이 하나라도 있을 경우
				ref = rs.getInt(1)+1;//
			}
			else// 쪽지가 없을때 
				ref = 1;
			
			sql="insert into message(to_id,from_id,contents,ref,msg_type,reg_date) values (?,?,?,?,?,?)";
			
			// 2row 넣기
			for (int i = 0; i < 2; i++) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, message.getTo_id());
				pstmt.setString(2, message.getFrom_id());
				pstmt.setString(3, message.getContents());
				pstmt.setInt(4, ref);
				pstmt.setInt(5, i);
				pstmt.setTimestamp(6, message.getReg_date());
				pstmt.executeUpdate();
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
	}
	
	//읽지않은 받은쪽지의 개수
	public int getUnreadMessageCount(String id) 
			throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        
        try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from message where to_id = ? and msg_type=1 and read_check=0");
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
	
	//쪽지의 개수
	public int getMessageCount(String id, String type) 
			throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        int msg_type=0;
        
        try {
        	if(type.equals("to")) {//보낸 쪽지
        		msg_type=1;
        	}else if(type.equals("from")) {//받은 쪽지
        		msg_type=0;
        	}
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from message where " + type + "_id = ? and msg_type=?");
			pstmt.setString(1, id);
			pstmt.setInt(2, msg_type);
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
	
	//쪽지의 개수
   public int getMessageCount(String id, String type,String keyfield, String keyword) 
         throws Exception {
      Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        int msg_type=0;
        String sql ="";
        
        try {
           conn = getConnection();
           
           /*if(type.equals("to")) {//보낸 쪽지
              msg_type=1;
           }else if(type.equals("from")) {//받은 쪽지
              msg_type=0;
           }
         pstmt = conn.prepareStatement("select count(*) from message where " + type + "_id = ? and msg_type=?");
         pstmt.setString(1, id);
         pstmt.setInt(2, msg_type);
         rs = pstmt.executeQuery();*/
           if(type.equals("to")) {//보낸 쪽지
              msg_type=1;
           }else if(type.equals("from")) {//받은 쪽지
              msg_type=0;
           }
           
           sql = "select count(*) from message where "+ type +"_id = ? and msg_type=? ";
           
         if (type.equals("to")) {
            type = "from";
         } else if (type.equals("from")) {
            type = "to";
         }
              if(!keyword.equals("")) {// 검색이 되는 경우
                 if(keyfield.equals("all")) {
                   sql += "and (contents like ? or "+ type +"_id like ?) order by reg_date desc";
                   pstmt = conn.prepareStatement(sql);
                   pstmt.setString(1, id);
                      pstmt.setInt(2, msg_type);
                  pstmt.setString(3, "%" + keyword + "%");
                  pstmt.setString(4, "%" + keyword + "%");
                 }else if(keyfield.equals("contents")) {
                    sql += "and contents like ? order by reg_date desc";
                   pstmt = conn.prepareStatement(sql);
                   pstmt.setString(1, id);
                      pstmt.setInt(2, msg_type);
                  pstmt.setString(3, "%" + keyword + "%");
                 }else if(keyfield.equals("id")) {
                    sql += "and "+type+"_id like ? order by reg_date desc";
                   pstmt = conn.prepareStatement(sql);
                   pstmt.setString(1, id);
                      pstmt.setInt(2, msg_type);
                  pstmt.setString(3, "%" + keyword + "%");
                 }   
             }else {// 검색을 안하는 경우
               sql += "order by reg_date desc";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, id);
                   pstmt.setInt(2, msg_type);
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
   
	   //쪽지 정보를 표시
    public List<MessageDataBean> getMessages(String id, String type,int start,int end,String keyfield,String keyword) 
    throws Exception {
       Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<MessageDataBean> messages=null;
        int msg_type=0;
        String sql = "";
        
        try {
           conn = getConnection();

           sql = "select * from message where "+type+"_id = ? and msg_type=? ";
         if (type.equals("to")) {//받은 쪽지
            type = "from";
              msg_type=1;
         } else if (type.equals("from")) {//보낸 쪽지
            type = "to";
              msg_type=0;
         }
              if(!keyword.equals("")) {// 검색이 되는 경우
                 if(keyfield.equals("all")) {
                   sql += "and (contents like ? or "+type+"_id like ?) order by reg_date desc limit ?,?";
                   pstmt = conn.prepareStatement(sql);
                   pstmt.setString(1, id);
                      pstmt.setInt(2, msg_type);
                  pstmt.setString(3, "%" + keyword + "%");
                  pstmt.setString(4, "%" + keyword + "%");
                  pstmt.setInt(5, start-1);
                  pstmt.setInt(6, end);
                 }else if(keyfield.equals("contents")) {
                    sql += "and contents like ? order by reg_date desc limit ?,?";
                   pstmt = conn.prepareStatement(sql);
                   pstmt.setString(1, id);
                      pstmt.setInt(2, msg_type);
                  pstmt.setString(3, "%" + keyword + "%");
                  pstmt.setInt(4, start-1);
                  pstmt.setInt(5, end);
                 }else if(keyfield.equals("id")) {
                    sql += "and "+type+"_id like ? order by reg_date desc limit ?,?";
                   pstmt = conn.prepareStatement(sql);
                   pstmt.setString(1, id);
                      pstmt.setInt(2, msg_type);
                  pstmt.setString(3, "%" + keyword + "%");
                  pstmt.setInt(4, start-1);
                  pstmt.setInt(5, end);
                 }   
             }else {// 검색을 안하는 경우
               sql += "order by reg_date desc limit ?,?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, id);
                   pstmt.setInt(2, msg_type);
               pstmt.setInt(3, start-1);
               pstmt.setInt(4, end);
            }
            rs = pstmt.executeQuery();

         if (rs.next()) {
            messages = new ArrayList<MessageDataBean>();
            do {
               MessageDataBean msg = new MessageDataBean();
               msg.setMsgcode(rs.getInt("msgcode"));
               msg.setTo_id(rs.getString("to_id"));
               msg.setFrom_id(rs.getString("from_id"));
               msg.setContents(rs.getString("contents"));
               msg.setRef(rs.getInt("ref"));
               msg.setReg_date(rs.getTimestamp("reg_date"));
               msg.setRead_check(rs.getInt("read_check"));
               messages.add(msg);
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
       return messages;
    }
	 //쪽지 정보를 표시
    public List<MessageDataBean> getMessages(String id, String type,int start,int end) 
    throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<MessageDataBean> messages=null;
        int msg_type=0;
        
        try {
        	if(type.equals("to")) {//보낸 쪽지
        		msg_type=1;
        	}else if(type.equals("from")) {//받은 쪽지
        		msg_type=0;
        	}
        	conn = getConnection();
        	pstmt = conn.prepareStatement("select * from message where "+type+"_id = ? and msg_type=? "
        	  		+ "order by reg_date desc limit ?,?");
         
            pstmt.setString(1, id);
            pstmt.setInt(2, msg_type);
            pstmt.setInt(3, start-1);
            pstmt.setInt(4, end);
            rs = pstmt.executeQuery();

			if (rs.next()) {
				messages = new ArrayList<MessageDataBean>();
				do {
					MessageDataBean msg = new MessageDataBean();
					msg.setMsgcode(rs.getInt("msgcode"));
					msg.setTo_id(rs.getString("to_id"));
					msg.setFrom_id(rs.getString("from_id"));
					msg.setContents(rs.getString("contents"));
					msg.setRef(rs.getInt("ref"));
					msg.setReg_date(rs.getTimestamp("reg_date"));
					msg.setRead_check(rs.getInt("read_check"));
					messages.add(msg);
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
		 return messages;
    }
    
	 //쪽지 삭제
    public int deleteMessage(int msgcode) 
    throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        int rs = 0;
        int x=-1;
        
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from message where msgcode=?");
			pstmt.setInt(1, msgcode);
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
    
  //알림을 읽었으면 1로 업데이트
  	public int updateRead_check(int msgcode) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		int rs = 0;
  		int x=0;
  		
  		try {
  			conn = getConnection();
  			pstmt = conn.prepareStatement("update message set read_check=1 where msgcode=?");
  			pstmt.setInt(1, msgcode);
  			rs = pstmt.executeUpdate();

  			if (rs>0) {
  				x=1;
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
}