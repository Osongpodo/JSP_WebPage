<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>

<%! // 전역 변수
    private String dataArray[];
	// 데이터베이스에 저장
    String jdbcUrl = "jdbc:mysql://localhost:3306/jspbookdb";
    String dbUser = "root";
    String dbPassword = "0000";
    
    // 테이블 삭제 메소드
    void dropTable(Connection connection, String tableName) throws SQLException {
        String deleteTableQuery = "DROP TABLE IF EXISTS " + tableName;
        try (PreparedStatement deleteTableStatement = connection.prepareStatement(deleteTableQuery)) {
            deleteTableStatement.executeUpdate();
        }
    }
%>

<%
	try {
	    // JDBC 드라이버 로드
	    Class.forName("com.mysql.jdbc.Driver");
	    // 데이터베이스 연결
	    try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
	        // 각 테이블 삭제 쿼리
	        dropTable(connection, "case_table");
	        dropTable(connection, "cpu_table");
	        dropTable(connection, "graphic_card_table");
	        dropTable(connection, "motherboard_table");
	        dropTable(connection, "power_table");
	        dropTable(connection, "storage_table");
	        
	        out.println("모든 테이블 삭제 완료");
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        out.println("데이터 삭제 중 오류 발생: " + e.getMessage());
	    }
	} catch (ClassNotFoundException e) {
	    e.printStackTrace();
	    out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
	}
%>

<a href="main2.jsp"><br>메인화면으로</a>