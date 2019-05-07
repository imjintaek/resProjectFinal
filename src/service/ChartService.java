package service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import model.BbsDAO;

public class ChartService {
	public static int[] getChartData() throws SQLException {
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
		Date time = new Date();
		String currentDay = format.format(time);
		String[] currentTime = new String[25]; 
		for(int i = 0; i <= 24; i++) {
			//9½Ã±îÁö
			if(i < 10) {
				currentTime[i] = currentDay + " 0" + i +":00:00"; 
			}else if(i == 24){
				currentTime[i] = currentDay + " " + (i - 1) +":59:59";
			}else {
				currentTime[i] = currentDay + " " + i +":00:00"; 
			}
		}
		return BbsDAO.getBbsCountData(currentTime);
	}
}
