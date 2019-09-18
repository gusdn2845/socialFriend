package user;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
/*
 * 
 * 		String directory = application.getRealPath("/upload/");
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request,directory,maxSize, encoding,new DefaultFileRenamePolicy());
 */
		MultipartRequest multi = null;
		int fileMaxSize = 10 * 1024 * 1024;
		
		String savePath = "C:/Dev/Other/upload";
		try {                                                                        //DefaultFileRenamePolicy - ���ε� �������� �ߺ��� �̸��� �����Ұ�� �����̸��ڿ� ���ڸ� �ڵ����� �����ش�
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8",new DefaultFileRenamePolicy()); 
		}catch(Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "���� ũ��� 10MB�� ���� �� �����ϴ�.");
			response.sendRedirect("profileUpdate.jsp");
			return;
		}
		String userID = multi.getParameter("userID");
		System.out.println(userID);
		HttpSession session = request.getSession();
		if(!userID.equals((String) session.getAttribute("userID"))) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "������ �� �����ϴ�.");
			response.sendRedirect("index.jsp");
			return;
		}
		String fileName = "";
		File file = multi.getFile("userProfile");
		if(file != null) {
			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1);
			if(ext.equals("jpg")||ext.equals("png")||ext.equals("gif")) {
				String prev = new UserDAO().getUser(userID).getUserProfile();
				File prevFile = new File(savePath + "/"+prev);
				if(prevFile.exists()) {
					prevFile.delete();
				}
				fileName = file.getName();
			}else {
				if(file.exists()) {
					file.delete();
				}
				request.getSession().setAttribute("messageType", "���� �޼���");
				request.getSession().setAttribute("messageContent", "�̹����� ���ε� �����մϴ�.");
				response.sendRedirect("profileUpdate.jsp");
				return;
			}
		}
		new UserDAO().profile(userID,fileName);
		request.getSession().setAttribute("messageType", "���� �޼���");
		request.getSession().setAttribute("messageContent", "�������� ����Ǿ����ϴ�.");
		response.sendRedirect("index.jsp");
		return;
	}
}
