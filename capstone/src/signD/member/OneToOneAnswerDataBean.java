package signD.member;
import java.sql.Timestamp;

public class OneToOneAnswerDataBean {
	private int answercode;
	private String id;
	private String contents;
	private String file;
	private int requestcode;
	private int prize_money;
	private Timestamp reg_date;
	
	
	public int getAnswercode() {
		return answercode;
	}
	public void setAnswercode(int answercode) {
		this.answercode = answercode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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