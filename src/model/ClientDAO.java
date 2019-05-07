package model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.domain.ClientDTO;
import util.DBUtil;

public class ClientDAO {
	public static boolean insert(ClientDTO client) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("insert into client values(?,?,?,?)");
			pstmt.setString(1, client.getUserId());
			pstmt.setString(2, encryptSHA256(client.getUserPass()));
			pstmt.setString(3, client.getUserName());
			pstmt.setString(4, client.getUserEmail());
			int result = pstmt.executeUpdate();

			if (result == 1) {
				return true;
			}
		} finally {
			DBUtil.close(con, pstmt);
		}
		return false;
	}
	// 아이디 삭제
	public static boolean clientdelete(String userId) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("delete from client where user_id=?");
			pstmt.setString(1, userId);
			int result = pstmt.executeUpdate();
			if (result == 1) {	
				return true;
			}
		} finally {
			DBUtil.close(con, pstmt);
		}
		return false;
	}

	// 회원정보 수정
	public static boolean informupdate(String user_id, String userEmail) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("update client set  user_Email = ? where user_id = ?");
			pstmt.setString(1, userEmail);
			pstmt.setString(2, user_id);
			int result = pstmt.executeUpdate();
			if (result == 1) {
				return true;
			}
		} finally {
			DBUtil.close(con, pstmt);
		}
		return false;
	}
	public static boolean checkID(String userId) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select * from client where user_id=?");
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			if (rset.next()) {
				return false;
			}
		} finally {
			DBUtil.close(con, pstmt, rset);
		}
		return true;
	}

	public static ClientDTO select(String userId, String userPass) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ClientDTO one = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select * from client where user_id=? and user_pass=?");
			pstmt.setString(1, userId);
			pstmt.setString(2, encryptSHA256(userPass));
			rset = pstmt.executeQuery();
			if (rset.next()) {
				one = new ClientDTO(rset.getString(1), rset.getString(2), rset.getString(3), rset.getString(4));
			} else {
				return null;
			}
		} finally {
			DBUtil.close(con, pstmt, rset);
		}
		return one;
	}
	
	public static ClientDTO selectnosha(String userId, String userPass) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ClientDTO one = null;
		System.out.println("유저아이디" + userId);
		System.out.println("유저비밀번호" + userPass);
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select * from client where user_id=? and user_pass=?");
			pstmt.setString(1, userId);
			pstmt.setString(2, userPass);
			rset = pstmt.executeQuery();
			if (rset.next()) {
				one = new ClientDTO(rset.getString(1), rset.getString(2), rset.getString(3), rset.getString(4));
			} else {
				return null;
			}
		} finally {
			DBUtil.close(con, pstmt, rset);
		}
		return one;
	}

	// 비밀번호 암호화 메소드, 비밀번호가 같으면 암호화 값도 같아서 비교 가능
	protected static String encryptSHA256(String str) {
		String sha = "";
		MessageDigest sh;
		try {
			sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			sha = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			sha = null;
		}
		return sha;
	}

}
