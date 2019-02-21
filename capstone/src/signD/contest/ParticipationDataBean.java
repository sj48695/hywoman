package signD.contest;
import java.sql.Timestamp;

public class ParticipationDataBean {
	private int ppcode;
	private String id;
	private String title;
	private String contents;
	private String file;
	private int viewcount;
	private int clause;
	private int requestcode;
	private int prize_money;
	private Timestamp reg_date;
	
	public int getPpcode() {
		return ppcode;
	}
	public void setPpcode(int ppcode) {
		this.ppcode = ppcode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getViewcount() {
		return viewcount;
	}
	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}
	public int getClause() {
		return clause;
	}
	public void setClause(int clause) {
		this.clause = clause;
	}
	public int getRequestcode() {
		return requestcode;
	}
	public void setRequestcode(int requestcode) {
		this.requestcode = requestcode;
	}
	public int getPrize_money() {
		return prize_money;
	}
	public void setPrize_money(int prize_money) {
		this.prize_money = prize_money;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
}