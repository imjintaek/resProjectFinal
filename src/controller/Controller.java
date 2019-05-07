package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import exception.NotExistException;
import model.ResListDAO;
import model.domain.ClientDTO;
import model.domain.CommentDTO;
import model.domain.ResListDTO;
import service.BbsService;
import service.ChartService;
import service.JoinService;

@WebServlet("/con")
public class Controller extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String command = request.getParameter("command");
		try {
			if (command.equals("signup")) {
				signUp(request, response);
			}else if(command.equals("login")) {
				login(request, response);
			}else if(command.equals("logOut")){
				logOut(request,response);
			}else if(command.equals("mapPage")) {
				mapPage(request, response);
			}else if(command.equals("idCheck")) {
				idCheck(request,response);
			}else if(command.equals("write")) {
				bbswrite(request,response);
			}else if(command.equals("bbs")) {
				bbsList(request,response);
			}else if(command.equals("view")) {
				bbsView(request,response);
			}else if(command.equals("delete")) {
				bbsDelete(request,response);
			}else if(command.equals("update")) {
				bbsUpdate(request,response);
			}else if(command.equals("commant")) {
				bbsCommant(request,response);
			}else if(command.equals("getComment")) {
				bbsGetComment(request,response);
			}else if(command.equals("ctdelete")) {
				clientdelete(request, response);
			}else if(command.equals("ctupdate")) {
				informupdate(request, response);
			}else if(command.equals("inform")) {
				clientview(request,response);
			}else if(command.equals("chart")) {
				chartview(request,response);
			}
		}catch(Exception e) {
			request.setAttribute("errorMsg", e.getMessage());
			request.getRequestDispatcher("showError.jsp").forward(request, response);
			e.printStackTrace();
		}
	}
	
	private void chartview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "mainPage.jsp";
		try {
			request.setAttribute("chartData", ChartService.getChartData());
			url ="chartPage.jsp";
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void bbsGetComment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		try {
			ArrayList<CommentDTO> alldata = BbsService.getBBSComment(Integer.parseInt(request.getParameter("page")));
			ArrayList<JSONObject> jsondata = new ArrayList<>();
			for(CommentDTO data : alldata) {
				JSONObject obj = new JSONObject();
				obj.put("content", data.getContent());
				obj.put("userID", data.getUserID());
				jsondata.add(obj);
			}
			request.setAttribute("jsonFile", jsondata);
			url = "bbsCommentData.jsp";
		} catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void bbsCommant(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		try {
			BbsService.setBBSComment(Integer.parseInt(request.getParameter("page")), request.getParameter("content"), request.getParameter("userID"));
			url = "con?command=view&page=" + request.getParameter("page");
		} catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void bbsUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		try {
			BbsService.updatePage(Integer.parseInt(request.getParameter("updatepage")), request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
			url = "con?command=view&page=" + request.getParameter("updatepage");
		}	catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void bbsDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		try {
			BbsService.deletePage(Integer.parseInt(request.getParameter("deletepage")));
			url = "con?command=bbs";
		} catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void bbsView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		try {
			request.setAttribute("pageData", BbsService.getPage(Integer.parseInt(request.getParameter("page"))));
			url = "bbsView.jsp";
		} catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void bbsList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		HttpSession session = request.getSession();
		try {
			if(request.getParameter("page") == null) {
				int totalPage= BbsService.getPageCount();
				session.setAttribute("PageCount", totalPage);
				session.setAttribute("bbsContents", BbsService.getList(totalPage));
			}else {
				session.setAttribute("bbsContents", BbsService.getList(Integer.parseInt(request.getParameter("page"))));
			}
			url ="bbs.jsp";
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void bbswrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		HttpSession session = request.getSession();
		
		try {
			String bbsTitle = request.getParameter("bbsTitle");
			String bbsContent = request.getParameter("bbsContent");
			ClientDTO user = (ClientDTO) session.getAttribute("client");
			BbsService.insertBBS(bbsTitle, bbsContent, user.getUserId());
			url = "con?command=bbs";
		} catch (SQLException e) {
			request.setAttribute("error", "blank");
			url = "bbswrite.jsp";
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void logOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		try {
			HttpSession session = request.getSession();
			session.removeAttribute("client");
			session.invalidate();
			url = "mainPage.jsp";
		} catch (Exception e) {
			request.setAttribute("errorMsg", "다시시도하세요.");
		}
		request.getRequestDispatcher(url).forward(request, response);
	}
	
	private void idCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		String userId = request.getParameter("userId");
		try {
			request.setAttribute("idCheck", JoinService.checkID(userId));
			url = "idCheck.jsp";
		} catch (Exception e) {
			request.setAttribute("errorMsg", "다시시도하세요.");
		}
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "";
		try {
			HttpSession session = request.getSession();
			session.setAttribute("client", JoinService.notExistClient(request.getParameter("userId"), request.getParameter("userPass")));
			url = "mainPage.jsp";
		}catch(Exception e) {
			request.setAttribute("error", "loginfail");
			url = "login.jsp";
		}
		request.getRequestDispatcher(url).forward(request, response);
	}
	private void clientview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
	      String url = "showError.jsp";
	      try { 
	    	  url = "inform.jsp";
	      } catch (NumberFormatException e) {
	         e.printStackTrace();
	      }
	      request.getRequestDispatcher(url).forward(request, response);
	}
	public void clientdelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      String url = "showError.jsp";
	      try {
	    	JoinService.deleteClient(request.getParameter("userId"));
	    	
	    	HttpSession session = request.getSession();
			session.removeAttribute("client");
			session.invalidate();
	         url = "mainPage.jsp";
	      }catch(Exception s){
	         request.setAttribute("errorMsg", s.getMessage());
	      }
	      request.getRequestDispatcher(url).forward(request, response);
	}
	private void informupdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";
		try {
			HttpSession session = request.getSession();
			System.out.println(request.getParameter("userPass"));
			request.setAttribute("userId", JoinService.updatePage(request.getParameter("userID"),request.getParameter("changeEmail")));
			session.setAttribute("client", JoinService.notshaClient(request.getParameter("userID"), request.getParameter("userPass")));
			url = "mainPage.jsp";
		}	catch (NotExistException | SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher(url).forward(request, response);
	}
	private void signUp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "showError.jsp";

		String userId = request.getParameter("userId");
		String userPass = request.getParameter("userPass");
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		ClientDTO client = new ClientDTO(userId, userPass, userName, userEmail );
		try {
			boolean result = JoinService.insertClient(client);
			if(result) {
				url = "login.jsp";
			}else {
				request.setAttribute("errorMsg", "다시시도하세요.");
			}
		} catch (Exception e) {
			request.setAttribute("errorMsg", e.getMessage());
		}
		request.getRequestDispatcher(url).forward(request, response);
	}		
	

	private void mapPage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		try {
			ArrayList<ResListDTO> alldata = ResListDAO.getAll();
			ArrayList<JSONObject> jsondata = new ArrayList<>();
			for(ResListDTO data : alldata) {
				JSONObject obj = new JSONObject();
				obj.put("name", data.getResName());
				obj.put("lat", data.getResLat());
				obj.put("lng", data.getResLng());
				obj.put("address", data.getResAddress());
				jsondata.add(obj);
			}
			request.setAttribute("jsonFile", jsondata);
			request.getRequestDispatcher("mapData.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
