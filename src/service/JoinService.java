package service;

import java.sql.SQLException;

import exception.NotExistException;
import model.ClientDAO;
import model.domain.ClientDTO;

public class JoinService {
	public static ClientDTO notExistClient(String userId, String userPass) throws NotExistException, SQLException{
		ClientDTO client = ClientDAO.select(userId, userPass);
		if(client == null) {
			throw new NotExistException("회원정보가 없습니다.");
		}
		return client;
	}
	//고객 암호 암호화 안함
	public static ClientDTO notshaClient(String userId, String userPass) throws NotExistException, SQLException{
		ClientDTO client = ClientDAO.selectnosha(userId, userPass);
		if(client == null) {
			throw new NotExistException("회원정보가 없습니다.");
		}
		return client;
	}

	public static boolean insertClient (ClientDTO client) throws SQLException, NotExistException {
		return ClientDAO.insert(client);
	}
	
	public static boolean deleteClient(String userId) throws SQLException, NotExistException {
		return ClientDAO.clientdelete(userId);
	}
	
	public static boolean updatePage(String user_id, String userEmail) throws SQLException, NotExistException {
		return ClientDAO.informupdate(user_id, userEmail);
	}
	
	public static String checkID(String userId) throws SQLException, NotExistException{
		if(ClientDAO.checkID(userId)) {
			return "false";
		}else {
			return "true";
		}
	}
}