package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.domain.ResListDTO;
import util.DBUtil;

public class ResListDAO {
	
	public static ArrayList<ResListDTO> getAll() throws Exception{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ResListDTO> all = null;
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select * from res_list");
			rs = pstmt.executeQuery();
			all = new ArrayList<>();
			while(rs.next()) {
				all.add(new ResListDTO(rs.getString(1),rs.getDouble(2),rs.getDouble(3),rs.getString(4)));
			}
		}finally {
			DBUtil.close(con, pstmt,rs);
		}
		return all;
	}
}
