package service;

import java.sql.SQLException;
import java.util.ArrayList;

import model.BbsDAO;
import model.domain.BbsDTO;
import model.domain.CommentDTO;

public class BbsService {
	public static boolean insertBBS(String bbsTitle,String bbsContent,String userID ) throws SQLException {
		return BbsDAO.insert(bbsTitle, bbsContent, userID);
	}
	
	public static int getPageCount() throws SQLException {
		int totalCount = BbsDAO.getListCount();
		int countList = 10;
		int totalPage = totalCount / countList;
		if(totalCount % countList > 0) {
			totalPage++;
		}
		return totalPage;
	}
	
	public static void updatePage(int bbsID, String bbsTitle,String bbsContent) throws SQLException {
		BbsDAO.updatePage(bbsID, bbsTitle, bbsContent);
	}
	
	public static void deletePage(int bbsID) throws SQLException {
		BbsDAO.deletPage(bbsID);
	}
	
	public static ArrayList<BbsDTO> getList(int choicePage) throws SQLException{
		return BbsDAO.getList(choicePage);
	}
	
	public static BbsDTO getPage(int bbsID) throws SQLException {
		return BbsDAO.getPage(bbsID);
	}
	
	public static void setBBSComment(int bbsID,String bbsContent,String userID) throws SQLException {
		BbsDAO.setBbsComment(bbsID, bbsContent, userID);
	}
	
	public static ArrayList<CommentDTO> getBBSComment(int bbsID) throws SQLException{
		return BbsDAO.getBbsComment(bbsID);
	}
}
