package signD.help;
import java.sql.Timestamp;

public class FAQDataBean {
	private Integer FAQcode;
	private String id;
	private String title;
	private String contents;
	private Timestamp reg_date;
	private String keyword;
	
	public Integer getFAQcode() {
		return FAQcode;
	}
	public void setFAQcode(Integer FAQcode) {
		this.FAQcode = FAQcode;
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
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
}