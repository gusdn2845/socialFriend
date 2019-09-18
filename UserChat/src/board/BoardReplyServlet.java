package board;

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
@WebServlet("/BoardReplyServlet")
public class BoardReplyServlet extends HttpServlet {
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
		
		String savePath = request.getRealPath("/upload").replaceAll("\\\\", "/");
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8",new DefaultFileRenamePolicy());
		}catch(Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "���� ũ��� 10MB�� ���� �� �����ϴ�.");
			response.sendRedirect("index.jsp");
			return;
		}
		String userID = multi.getParameter("userID");
		HttpSession session = request.getSession();
		if(!userID.equals((String) session.getAttribute("userID"))) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "������ �� �����ϴ�.");
			response.sendRedirect("index.jsp");
			return;
		}
		String boardID = multi.getParameter("boardID");
		
		if(boardID == null|| boardID.equals("")) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "������ �� �����ϴ�.");
			response.sendRedirect("boardView.jsp");
			return;
		}
		String boardTitle = multi.getParameter("boardTitle");
		String boardContent = multi.getParameter("boardContent");
		if(boardTitle == null|| boardTitle.equals("")||boardContent == null|| boardContent.equals("")) {
			request.getSession().setAttribute("messageType", "���� �޼���");
			request.getSession().setAttribute("messageContent", "������ ��� ä���ּ���.");
			response.sendRedirect("boardWrite.jsp");
			return;
		}
		String boardFile = "";
		String boardRealFile = "";
		String fileName = "";
		File file = multi.getFile("boardFile");
		if(file != null) {
			boardFile = multi.getOriginalFileName("boardFile");
			boardRealFile = file.getName();
		}
		BoardDAO boardDAO = new BoardDAO();
		BoardDTO parent = boardDAO.getBoard(boardID);
		boardDAO.replyUpdate(parent);
		boardDAO.reply(userID, boardTitle, boardContent, boardFile, boardRealFile, parent);
		request.getSession().setAttribute("messageType", "���� �޼���");
		request.getSession().setAttribute("messageContent", "�亯�� �ۼ��Ǿ����ϴ�.");
		response.sendRedirect("boardView.jsp");
		return;
	}
}
