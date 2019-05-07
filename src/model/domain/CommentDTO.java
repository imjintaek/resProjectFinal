package model.domain;

public class CommentDTO {
	private String content;
	private String userID;
	public CommentDTO() {
		super();
	}
	public CommentDTO(String content, String userID) {
		super();
		this.content = content;
		this.userID = userID;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
}
