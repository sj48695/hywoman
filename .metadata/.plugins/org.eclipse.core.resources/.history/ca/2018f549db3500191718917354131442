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

public class AlarmDBBean {
	
    private static AlarmDBBean instance = new AlarmDBBean();
    
    public static AlarmDBBean getInstance() {
        return instance;
    }
    
    private AlarmDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	public void insertAlarm(AlarmDataBean Alarm) 
	            throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into Alarm(to_id,from_id,noticedate,url,contents,type) values (?,?,?,?,?,?)");
			pstmt.setString(1, Alarm.getTo_id());
			pstmt.setString(2, Alarm.getFrom_id());
			pstmt.setTimestamp(3, Alarm.getNoticedate());
			pstmt.setString(4, Alarm.getUrl());
			pstmt.setString(5, Alarm.getContents());
			pstmt.setString(6, Alarm.getType());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (pstmt != null) 
				try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) 
				try { conn.close(); } catch(SQLException ex) {}
		}
	}
	
	//읽지않은 알람의 개수
	public int getUnReadAlarmCount(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
        
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from alarm where to_id = ? and read_check=0");

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
	
	//알림의 개수
	public int getAlarmCount(String id) 
	    throws Exception {
	   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from alarm where to_id = ?");

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
	
	 //읽지않은 받은알람 정보를 표시
    public List<AlarmDataBean> getUnAlarm(String id,  int start, int end) 
    throws Exception {
   		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<AlarmDataBean> alarms=null;
        
        try {
       	 	conn = getConnection();
         
        	pstmt = conn.prepareStatement("select * from alarm "
        			+ "where to_id = ? and read_check=0 "
        			+ "order by noticedate desc limit ?,?");
     
            pstmt.setString(1, id);
            pstmt.setInt(2, start-1);
            pstmt.setInt(3, end);
            rs = pstmt.executeQuery();

			if (rs.next()) {
				alarms = new ArrayList<AlarmDataBean>();
				do {
					AlarmDataBean alarm = new AlarmDataBean();
					alarm.setAlarmcode(rs.getInt("alarmcode"));
					alarm.setTo_id(rs.getString("to_id"));
					alarm.setFrom_id(rs.getString("from_id"));
					alarm.setContents(rs.getString("contents"));
					alarm.setNoticedate(rs.getTimestamp("Noticedate"));
					alarm.setType(rs.getString("type"));
					alarm.setUrl(rs.getString("url"));
					alarm.setRead_check(rs.getInt("read_check"));
					alarms.add(alarm);

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
		 return alarms;
    }
	
	 //받은알람 정보를 표시
    public List<AlarmDataBean> getAlarm(String id,  int start, int end) 
    throws Exception {
   		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<AlarmDataBean> alarms=null;
        
        try {
       	 	conn = getConnection();
         
        	pstmt = conn.prepareStatement("select * from alarm where to_id = ? "
        			+ "order by noticedate desc limit ?,?");
     
            pstmt.setString(1, id);
            pstmt.setInt(2, start-1);
            pstmt.setInt(3, end);
            rs = pstmt.executeQuery();

			if (rs.next()) {
				alarms = new ArrayList<AlarmDataBean>();
				do {
					AlarmDataBean alarm = new AlarmDataBean();
					alarm.setAlarmcode(rs.getInt("alarmcode"));
					alarm.setTo_id(rs.getString("to_id"));
					alarm.setFrom_id(rs.getString("from_id"));
					alarm.setContents(rs.getString("contents"));
					alarm.setNoticedate(rs.getTimestamp("Noticedate"));
					alarm.setType(rs.getString("type"));
					alarm.setUrl(rs.getString("url"));
					alarm.setRead_check(rs.getInt("read_check"));
					alarms.add(alarm);

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
		 return alarms;
    }
    
    //알림을 읽었으면 1로 업데이트
	public int updateRead_check(int alarmcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x=0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update alarm set read_check=1 where alarmcode=?");
			pstmt.setInt(1, alarmcode);
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
	
	 //알림삭제
	public int deleteAlarm(int alarmcode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs = 0;
		int x=0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("delete from alarm where alarmcode=?");
			pstmt.setInt(1, alarmcode);
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