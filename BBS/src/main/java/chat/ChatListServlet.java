package chat;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html);charset=UTF-8");
		String listType = request.getParameter("listType");
		if (listType == null || listType.equals("")) {
			response.getWriter().write("");
		} else if (listType.equals("today")) {
			response.getWriter().write(getToday());
		}
	}

	// 오늘에 대한 _db 결과 출력 함수
	public String getToday() {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<Chat> chatList = chatDAO.getChatList(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		for (int i = 0; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getChatName() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");

			// i 가 마지막 원소가 아니라면 다른 메세지가 있는 것을 의미
			if (i != chatList.size() - 1)
				result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
}