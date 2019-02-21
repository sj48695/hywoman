package signD.member;
import java.sql.Timestamp;

public class BookmarkDataBean {
	private int bmcode;
	private String id;
	private String designer_id;
	private Integer requestcode;
	private Timestamp reg_date;
	
	public Integer getBmcode() {
		return bmcode;
	}
	public void setBmcode(Integer bmcode) {
		this.bmcode = bmcode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDesigner_id() {
		return designer_id;
	}
	public void setDesigner_id(String designer_id) {
		this.designer_id = designer_id;
	}
	public Integer getRequestcode() {
		return requestcode;
	}
	public void setRequestcode(Integer requestcode) {
		this.requestcode = requestcode;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}