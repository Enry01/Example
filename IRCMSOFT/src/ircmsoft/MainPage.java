package ircmsoft;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/index")
public class MainPage extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MainPage(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MainPage(request, response);
	}
	
	private void MainPage (HttpServletRequest request, HttpServletResponse response) throws IOException{
		String btn = null;
		
		try {
			btn = new String(request.getParameter("btn").getBytes("ISO-8859-1"), "UTF-8");
			
			HttpSession session = request.getSession();
			
			if (btn.equalsIgnoreCase("Вход")) {		
				String login = request.getParameter("login");
				String pass = request.getParameter("pass");
				session.removeValue("errlogin");
		
				ConnectDB connectDB = new ConnectDB();
				connectDB.getConnection();
				ResultSet rs = connectDB.userData();
				
				while (rs.next()) {
					if (login.equals(rs.getString(1)) && pass.equals(rs.getString(2))) {
						ResultSet rs1 = connectDB.outPutData();
						session.setAttribute("rs", rs1);
						
						RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("index.jsp");
						Dispatcher.forward(request, response);
					}
					else {
						session.setAttribute("errlogin", "" +
								"<div class='ui-widget' style='margin-top:15px; margin-left: 33%; margin-right: 33%;'>" +
								"<div class='ui-state-error ui-corner-all' style='padding: 0.7em; text-align: center;'><p>" +
								"<span class='ui-icon ui-icon-alert' style='float: left; margin-left: 1.3em;'>" +
								"</span>Неверное имя пользователя или пароль</p></div></div>");
						response.sendRedirect("login.jsp");
					}
				}
				rs.close();
			}
			
			if (btn.equalsIgnoreCase("Выход")) {
				response.sendRedirect("login.jsp");
			}
			
			if (btn.equalsIgnoreCase("Все проекты")) {
				ConnectDB connectDB = new ConnectDB();
				connectDB.getConnection();
				ResultSet rs = connectDB.outPutData();
					
				session = request.getSession();
				session.setAttribute("rs", rs);
					
				RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("index.jsp");
				Dispatcher.forward(request, response);
			}
		
			if (btn.equalsIgnoreCase("Удалить")) {
				String id="";
				id = request.getParameter("sel");
				ConnectDB connectDB = new ConnectDB();
				connectDB.getConnection();
				connectDB.deleteData(id);
				ResultSet rs = connectDB.outPutData();
				
			    session = request.getSession();
				session.setAttribute("rs", rs);
				
				RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("index.jsp");
				Dispatcher.forward(request, response);
			}
			
			if (btn.equalsIgnoreCase("Сохранить")) {
				String id = request.getParameter("rowId");
				ArrayList<String> updateList = new ArrayList<String>();
				
				updateList.add(new String(request.getParameter("nameD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("descD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("envD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("pathD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("autD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("devD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("usedD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("servD").getBytes("ISO-8859-1"), "UTF-8"));
				
				updateList.add(new String(request.getParameter("statusD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("techD").getBytes("ISO-8859-1"), "UTF-8"));
				updateList.add(new String(request.getParameter("subD").getBytes("ISO-8859-1"), "UTF-8"));
				
				ConnectDB connectDB = new ConnectDB();
				connectDB.getConnection();
				connectDB.updateData(id, updateList);
				ResultSet rs = connectDB.outPutData();
				
				session = request.getSession();
				session.setAttribute("rs", rs);
				
				RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("index.jsp");
				Dispatcher.forward(request, response);
			}
			
			if (btn.equalsIgnoreCase("Добавить")) {
				ArrayList<String> insertList = new ArrayList<String>();

				insertList.add(new String(request.getParameter("name").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("desc").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("env").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("path").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("aut").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("dev").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("used").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("serv").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("status").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("tech").getBytes("ISO-8859-1"), "UTF-8"));
				insertList.add(new String(request.getParameter("sub").getBytes("ISO-8859-1"), "UTF-8"));
				
				ConnectDB connectDB = new ConnectDB();
				connectDB.getConnection();
			    connectDB.insertData(insertList);
			    ResultSet rs = connectDB.outPutData();
			   
			    session = request.getSession();
				session.setAttribute("rs", rs);
				
				RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("index.jsp");
				Dispatcher.forward(request, response);
			}
		} catch (UnsupportedEncodingException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
}
