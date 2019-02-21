package signD.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import signD.contest.ParticipationDBBean;
import signD.contest.ParticipationDataBean;
import signD.member.LogonDataBean;

public class ManagerDBBean {
	
    private static ManagerDBBean instance = new ManagerDBBean();
    
    public static ManagerDBBean getInstance() {
        return instance;
    }
    
    private ManagerDBBean() { }
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/signd");
	    return ds.getConnection();
	}
	
	//회원들의 수를 표시-->memberManagementForm.jsp에서 사용
	public int getMemberCount(String type) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from member where type=?");
			pstmt.setString(1, type);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count=rs.getInt(1);
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
	
    //회원들의 정보를 표시-->memberManagementForm.jsp에서 사용
	public List<LogonDataBean> getMember(String type,int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<LogonDataBean> members = null;
		LogonDataBean member = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from member where type=? limit ?,?");
			pstmt.setString(1, type);
			pstmt.setInt(2, start - 1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				members = new ArrayList<LogonDataBean>();
				do {
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
					members.add(member);

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
		 return members;
    }
	
	//채택후 관리자가 상금 지급
	public int updatePrizeMoney(int ppcode, int prize_money) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
		ParticipationDataBean pp = null;
		if (ppcode != 0) {
			pp = ppdb.getParticipation(ppcode);
		}
		int x = 0;
		int check=0;
		int rs = 0;
		String sql = "";
			        
		try {
			conn = getConnection();

			sql = "update participation set prize_money = ";

			if (ppcode != 0 && pp.getPrize_money()==0) {// 채택이 되어있고, 관리자가 지급하기 버튼을 누르면
				sql += "prize_money + ? where ppcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, prize_money);
				pstmt.setInt(2, ppcode);
				
			}else if (ppcode != 0 && pp.getPrize_money()>0) {// 채택이 되어있고, 관리자가 지급취소 버튼을 누르면
				sql += "0 where ppcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ppcode);
				
			}else if(ppcode==0) {// 채택이 취소되면
				sql += "0 where ppcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ppcode);
				
			}
			pstmt.executeUpdate();
			
			sql = "update member set money = ";

			if (ppcode != 0 && pp.getPrize_money()==0) {// 채택이 되어있고, 관리자가 지급하기 버튼을 누르면
				sql += "money + ? where id=?";
				check=1;
			}else if (ppcode != 0 && pp.getPrize_money()>0) {// 채택이 되어있고, 관리자가 지급취소 버튼을 누르면
				sql += "money - ? where id=?";
				check=0;
			}/*else if(ppcode==0) {// 채택이 취소되면
				sql += "money - ? where id=?";
			}*/
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, prize_money);
			pstmt.setString(2, pp.getId());
			rs=pstmt.executeUpdate();
			
			if (rs > 0) x = check;
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