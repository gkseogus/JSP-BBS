package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	// ctrl + shift + o 로 외부 라이브러리를 한번에 불러올 수 있다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// mariadb 접속
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/userDB";
			String dbID = "root";
			String dbPassword = "gkseogus";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 하나의 계정에 대한 로그인 시도를 해주는 함수
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					System.out.println('1');
					// 로그인 성공
					return 1;
				} else {
					System.out.println('0');
					// 비밀번호 불일치
					return 0;
				}
			}
			// 아이디 없을 경우
			System.out.println("-1");
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 데이터베이스 오류
		System.out.println("-2");
		return -2;
	}

	private PreparedStatement setString(int i, String userID) {
		// TODO Auto-generated method stub
		return null;
	}
}
