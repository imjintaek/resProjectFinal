package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import model.domain.BbsDTO;
import model.domain.CommentDTO;
import util.DBUtil;

public class BbsDAO {
	public static boolean insert(String bbsTitle,String bbsContent,String userID) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("insert into bbs values(bbs_ID.nextval,?,?,?,?,SYSDATE)");
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, userID);
			pstmt.setString(3, bbsContent);
			pstmt.setInt(4, 1);
			int result = pstmt.executeUpdate();

			if (result == 1) {
				return true;
			}
		} finally {
			DBUtil.close(con, pstmt);
		}
		return false;
	}
	public static void setBbsComment(int bbsID,String bbsContent,String userID) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("insert into bbsComment values(?,?,1,?)");
			pstmt.setString(1, bbsContent);
			pstmt.setString(2, userID);
			pstmt.setInt(3, bbsID);
			pstmt.executeUpdate();
		}finally {
			DBUtil.close(con, pstmt);
		}
	}
	
	public static int[] getBbsCountData(String[] time) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int[] count = new int[24];
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select count(*) from bbs where BBSDATE between to_date(?, 'YY/MM/DD HH24:MI:SS') and to_date(?, 'YY/MM/DD HH24:MI:SS')");
			for(int i = 0; i < 24; i++) {
				pstmt.setString(1, time[i]);
				pstmt.setString(2, time[i+1]);
				rset = pstmt.executeQuery();
				if(rset.next()) {
					count[i] = rset.getInt(1);
				}
			}
		}finally {
			DBUtil.close(con, pstmt, rset);
		}
		return count;
	}
	
	public static ArrayList<CommentDTO> getBbsComment(int bbsID) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<CommentDTO> commentdata = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select * from bbsComment where com_pageNum = ?");
			pstmt.setInt(1, bbsID);
			rset = pstmt.executeQuery();
			commentdata = new ArrayList<>();
			while(rset.next()) {
				commentdata.add(new CommentDTO(rset.getString(1), rset.getString(2)));
			}
		}finally {
			DBUtil.close(con, pstmt, rset);
		}
		
		return commentdata;
	}

	public static void updatePage(int bbsID, String bbsTitle,String bbsContent) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("update bbs set BBSTITLE = ?, BBSCONTENT = ? where bbsID = ?");
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			pstmt.executeUpdate();
		}finally {
			DBUtil.close(con, pstmt);
		}
	}
	
	public static void deletPage(int bbsID) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("update bbs set BBSEXISTENCE = 0 where bbsID = ?");
			pstmt.setInt(1, bbsID);
			pstmt.executeUpdate();
		}finally {
			DBUtil.close(con, pstmt);
		}
	}
	
	public static int getListCount() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalCount = 0;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select count(bbsID) from bbs where BBSEXISTENCE = 1 order by bbsID desc");
			rset = pstmt.executeQuery();
			if(rset.next()) {
				//1보다 작을시 글이 한개도없다는것
				totalCount = rset.getInt(1);
				if(totalCount < 1) {
					totalCount = 1;
				}
			}
			
		} finally {
			DBUtil.close(con, pstmt,rset);
		}
		return totalCount;
	}
	
	public static BbsDTO getPage(int bbsID) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		BbsDTO getPage = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select * from bbs where BBSEXISTENCE = 1 and bbsID = ?");
			pstmt.setInt(1, bbsID);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
				String date = sdf.format(rset.getTimestamp(6));
				getPage = new BbsDTO(rset.getInt(1), rset.getString(2), rset.getString(3), date, rset.getString(4), rset.getInt(5));
			}
			
		}finally {
			DBUtil.close(con, pstmt, rset);
		}
		
		return getPage;
	}
	
	//ex)4Page totalCount 31(31~40)	1Page totalCount 31(1~10)
	public static ArrayList<BbsDTO> getList(int choicePage) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<BbsDTO> getData = null;
		
		int firstpage = 0;
		int lastpage = 0;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select B.*\r\n" + 
					"from (\r\n" + 
					"select A.*, rownum no\r\n" + 
					"from (\r\n" + 
					"    select BBSID ,BBSTITLE ,USER_ID ,BBSCONTENT ,BBSEXISTENCE ,BBSDATE \r\n" + 
					"    from BBS \r\n" + 
					"    where BBSEXISTENCE = 1\r\n" + 
					"    order by bbsID) A\r\n" + 
					") B\r\n" + 
					"where B.no between ? and ? order by bbsID desc");
			firstpage = (choicePage * 10) - 9;
			lastpage = choicePage * 10;
			pstmt.setInt(1, firstpage);
			pstmt.setInt(2, lastpage);
			rset = pstmt.executeQuery();
			getData = new ArrayList<>();
			while(rset.next()) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
				String date = sdf.format(rset.getTimestamp(6));
				getData.add(new BbsDTO(rset.getInt(1), rset.getString(2), rset.getString(3), date, rset.getString(4), rset.getInt(5)));
			}
		} finally {
			DBUtil.close(con, pstmt,rset);
		}
		return getData;
	}
	
}
