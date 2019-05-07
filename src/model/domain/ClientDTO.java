package model.domain;

public class ClientDTO {
	private String userId;
	private String userPass;
	private String userName;
	private String userEmail;
	
	public ClientDTO() {}

	public ClientDTO(String userId, String userPass, String userName, String userEmail) {
		super();
		this.userId = userId;
		this.userPass = userPass;
		this.userName = userName;
		this.userEmail = userEmail;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPass() {
		return userPass;
	}

	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ClientDTO [userId=");
		builder.append(userId);
		builder.append(", userPass=");
		builder.append(userPass);
		builder.append(", userName=");
		builder.append(userName);
		builder.append(", userEmail=");
		builder.append(userEmail);
		builder.append("]");
		return builder.toString();
	}
}
