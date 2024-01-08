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
%>

<%
	//CASE
	Path webappPath = Paths.get(application.getRealPath("/")).normalize();


String filePath = "/home/a2019126105/eclipse-workspace/project/WebContent/case.csv";



	List<String> lines = new ArrayList<>();
	int len = 0;
	
	out.println("---데이터 저장 페이지---<br>");
	try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
	    String line;
	    // 파일에서 한 줄씩 읽어와 리스트에 추가 
	    while ((line = reader.readLine()) != null) {
	        lines.add(line);
	    }
	} catch (Exception e) {
	    e.printStackTrace();
	}
	
	// 리스트를 배열로 변환
	String[] linesArray = lines.toArray(new String[0]);
	
	try {
	    // JDBC 드라이버 로드
	    Class.forName("com.mysql.jdbc.Driver");
	    // 데이터베이스 연결
	    try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
	        // 테이블이 없는 경우 테이블을 만들고 초기화 하는 쿼리
	        String createTableQuery = "CREATE TABLE IF NOT EXISTS case_table (" +
	        	    "id INT AUTO_INCREMENT PRIMARY KEY," +
	        	    "Classification VARCHAR(255)," +
	        	    "release_date VARCHAR(255)," +
	        	    "company VARCHAR(255)," +
	        	    "model VARCHAR(255)," +
	        	    "number_of_comments VARCHAR(255)," +
	        	    "compatibility VARCHAR(255)," +
	        	    "size VARCHAR(255)," +
	        	    "storage VARCHAR(255)," +
	        	    "cooling_fan VARCHAR(255)," +
	        	    "radiator VARCHAR(255)," +
	        	    "CPU_cooler VARCHAR(255)," +
	        	    "power_specification VARCHAR(255)," +
	        	    "graphic_card VARCHAR(255)," +
	        	    "chassis VARCHAR(255)," +
	        	    "CPU_temperature VARCHAR(255)," +
	        	    "graphic_card_temperature VARCHAR(255)," +
	        	    "environment VARCHAR(255)," +
	        	    "MSRP INT," +
	        		"stock INT," +
                    "count INT)";
	        		
	        try (PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery)) {
	            createTableStatement.executeUpdate();
	        }
	        // 첫 실행 시 테이블 초기화 쿼리 실행
	        String truncateQuery = "TRUNCATE TABLE case_table";
	        try (PreparedStatement truncateStatement = connection.prepareStatement(truncateQuery)) {
	            truncateStatement.executeUpdate();
	        }
	     	// 테이블에 데이터 저장
            len = linesArray.length;
            for (int i = 2; i < len; i++) {
                if (i < len) {
                    // 쉼표로 문자열 분할
                    dataArray = linesArray[i].split(",");
                    // 테이블 데이터 저장 실행
                    for (int count = 0; count < dataArray.length / 18; count++) {
                    	String insertQuery = "INSERT INTO case_table (Classification, release_date, company, model, number_of_comments, compatibility, size, storage, cooling_fan, radiator, CPU_cooler, power_specification, graphic_card, chassis, CPU_temperature, graphic_card_temperature, environment, MSRP, stock, count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                            int columnCount = Math.min(18, dataArray.length - count * 18);  // dataArray.length에서 벗어나지 않도록
                            for (int j = 1; j <= columnCount; j++) {
                                preparedStatement.setString(j, dataArray[j - 1 + (count * 18)]);
                            }
                            Random random = new Random();
	                        preparedStatement.setInt(19, random.nextInt(100) + 1);
                            preparedStatement.setInt(20, 0);
                            // SQL 쿼리 실행
                            preparedStatement.executeUpdate();
                        }
                    }
                }
            }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        out.println("데이터 저장 중 오류 발생: " + e.getMessage());
	    }
	    out.println("CASE Database 저장 완료 " + (len - 2) + "<br>");
	} catch (ClassNotFoundException e) {
	    e.printStackTrace();
	    out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
	}
	

	
	//CPU
filePath = webappPath.resolve("cpu.csv").toString();

    lines.clear();
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        // 파일에서 한 줄씩 읽어와 리스트에 추가 
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 리스트를 배열로 변환
    linesArray = lines.toArray(new String[0]);

    try {
        // JDBC 드라이버 로드
        Class.forName("com.mysql.jdbc.Driver");
        // 데이터베이스 연결
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            // 테이블이 없는 경우 테이블을 만들고 초기화 하는 쿼리
            String createTableQuery = "CREATE TABLE IF NOT EXISTS cpu_table (" +
            	    "id INT AUTO_INCREMENT PRIMARY KEY," +
            	    "manufacturer VARCHAR(255)," +
            	    "release_date VARCHAR(255)," +
            	    "process VARCHAR(255)," +
            	    "model VARCHAR(255)," +
            	    "number_of_comments VARCHAR(255)," +
            	    "socket VARCHAR(255)," +
            	    "core VARCHAR(255)," +
            	    "thread VARCHAR(255)," +
            	    "base_clock VARCHAR(255)," +
            	    "maximum_boost VARCHAR(255)," +
            	    "memory VARCHAR(255)," +
            	    "L3_cache VARCHAR(255)," +
            	    "built_in_graphics VARCHAR(255)," +
            	    "GPU_clock VARCHAR(255)," +
            	    "arithmetic_unit VARCHAR(255)," +
            	    "TDP VARCHAR(255)," +
            	    "MSRP INT," +
            	    "stock INT," +
                    "count INT)";

            try (PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery)) {
                createTableStatement.executeUpdate();
            }
            // 첫 실행 시 테이블 초기화 쿼리 실행
            String truncateQuery = "TRUNCATE TABLE cpu_table";
            try (PreparedStatement truncateStatement = connection.prepareStatement(truncateQuery)) {
                truncateStatement.executeUpdate();
            }
            // 테이블에 데이터 저장
            len = linesArray.length;
            for (int i = 2; i < len; i++) {
                if (i < len) {
                    // 쉼표로 문자열 분할
                    dataArray = linesArray[i].split(",");

                    for (int count = 0; count < dataArray.length / 17; count++) {
                        String insertQuery = "INSERT INTO cpu_table (manufacturer, release_date, process, model, number_of_comments, socket, core, thread, base_clock, maximum_boost, memory, L3_cache, built_in_graphics, GPU_clock, arithmetic_unit, TDP, MSRP, stock, count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                            int columnCount = Math.min(17, dataArray.length - count * 17);  // dataArray.length에서 벗어나지 않도록
                            for (int j = 1; j <= columnCount; j++) {
                                preparedStatement.setString(j, dataArray[j - 1 + (count * 17)]);
                            }
                            Random random = new Random();
	                        preparedStatement.setInt(18, random.nextInt(100) + 1);
                            preparedStatement.setInt(19, 0);
                            // SQL 쿼리 실행
                            preparedStatement.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("데이터 저장 중 오류 발생: " + e.getMessage());
        }
        out.println("CPU Database 저장 완료 " + (len - 2) + "<br>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
    }
    
    
    //Graphic Card

    filePath = webappPath.resolve("graphic_card.csv").toString();

    lines.clear();
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        // 파일에서 한 줄씩 읽어와 리스트에 추가 
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 리스트를 배열로 변환
    linesArray = lines.toArray(new String[0]);

    try {
        // JDBC 드라이버 로드
        Class.forName("com.mysql.jdbc.Driver");
        // 데이터베이스 연결
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            // 테이블이 없는 경우 테이블을 만들고 초기화 하는 쿼리
            String createTableQuery = "CREATE TABLE IF NOT EXISTS graphic_card_table (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "manufacturer VARCHAR(255)," +
                    "release_date VARCHAR(255)," +
                    "company VARCHAR(255)," +
                    "GPU VARCHAR(255)," +
                    "model VARCHAR(255)," +
                    "number_of_comments VARCHAR(255)," +
                    "boost_clock VARCHAR(255)," +
                    "memory VARCHAR(255)," +
                    "length VARCHAR(255)," +
                    "base_power VARCHAR(255)," +
                    "maximum_power VARCHAR(255)," +
                    "power_supply VARCHAR(255)," +
                    "core_temperature VARCHAR(255)," +
                    "noise VARCHAR(255)," +
                    "3DMark_TS VARCHAR(255)," +
                    "driver_version VARCHAR(255)," +
                    "environment VARCHAR(255)," +
                    "MSRP INT," +
                    "stock INT," +
                    "count INT)";
            try (PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery)) {
                createTableStatement.executeUpdate();
            }
            // 첫 실행 시 테이블 초기화 쿼리 실행
            String truncateQuery = "TRUNCATE TABLE graphic_card_table";
            try (PreparedStatement truncateStatement = connection.prepareStatement(truncateQuery)) {
                truncateStatement.executeUpdate();
            }
            // 테이블에 데이터 저장
            len = linesArray.length;
            for (int i = 2; i < len; i++) {
                if (i < len) {
                    // 쉼표로 문자열 분할
                    dataArray = linesArray[i].split(",");
                    // 테이블 데이터 저장 실행
                    for (int count = 0; count < dataArray.length / 18; count++) {
                        String insertQuery = "INSERT INTO graphic_card_table (manufacturer, release_date, company, GPU, model, number_of_comments, boost_clock, memory, length, base_power, maximum_power, power_supply, core_temperature, noise, 3DMark_TS, driver_version, environment, MSRP, stock, count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                            int columnCount = Math.min(18, dataArray.length - count * 18);  // dataArray.length에서 벗어나지 않도록
                            for (int j = 1; j <= columnCount; j++) {
                                preparedStatement.setString(j, dataArray[j - 1 + (count * 18)]);
                            }
                            Random random = new Random();
	                        preparedStatement.setInt(19, random.nextInt(100) + 1);
                            preparedStatement.setInt(20, 0);
                            // SQL 쿼리 실행
                            preparedStatement.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("데이터 저장 중 오류 발생: " + e.getMessage());
        }
        out.println("Graphic Card Database 저장 완료 " + (len - 2) + "<br>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
    }
    
    
    //MotherBoard

    filePath = webappPath.resolve("motherboard.csv").toString();

    lines.clear();
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        // 파일에서 한 줄씩 읽어와 리스트에 추가 
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 리스트를 배열로 변환
    linesArray = lines.toArray(new String[0]);

    try {
        // JDBC 드라이버 로드
        Class.forName("com.mysql.jdbc.Driver");
        // 데이터베이스 연결
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            // 테이블이 없는 경우 테이블을 만들고 초기화 하는 쿼리
            String createTableQuery = "CREATE TABLE IF NOT EXISTS motherboard_table (" +
            	    "id INT AUTO_INCREMENT PRIMARY KEY," +
            	    "Manufacturer VARCHAR(255)," +
            	    "release_date VARCHAR(255)," +
            	    "company VARCHAR(255)," +
            	    "model VARCHAR(255)," +
            	    "number_of_comments VARCHAR(255)," +
            	    "socket VARCHAR(255)," +
            	    "chipset VARCHAR(255)," +
            	    "form_factor VARCHAR(255)," +
            	    "memory VARCHAR(255)," +
            	    "DIMM VARCHAR(255)," +
            	    "M_2 VARCHAR(255)," +
            	    "SATA VARCHAR(255)," +
            	    "power_supply VARCHAR(255)," +
            	    "power_limit VARCHAR(255)," +
            	    "power_supply_temperature VARCHAR(255)," +
            	    "environment VARCHAR(255)," +
            	    "MSRP INT," +
            	    "stock INT," +
                    "count INT)";
            try (PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery)) {
                createTableStatement.executeUpdate();
            }
            // 첫 실행 시 테이블 초기화 쿼리 실행
            String truncateQuery = "TRUNCATE TABLE motherboard_table";
            try (PreparedStatement truncateStatement = connection.prepareStatement(truncateQuery)) {
                truncateStatement.executeUpdate();
            }
            // 테이블에 데이터 저장
            len = linesArray.length;
            for (int i = 2; i < len; i++) {
                if (i < len) {
                    // 쉼표로 문자열 분할
                    dataArray = linesArray[i].split(",");
                    // 테이블 데이터 저장 실행
                    for (int count = 0; count < dataArray.length / 17; count++) {
                        String insertQuery = "INSERT INTO motherboard_table (Manufacturer, release_date, company, model, number_of_comments, socket, chipset, form_factor, memory, DIMM, M_2, SATA, power_supply, power_limit, power_supply_temperature, environment, MSRP, stock, count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                            int columnCount = Math.min(17, dataArray.length - count * 17);  // dataArray.length에서 벗어나지 않도록
                            for (int j = 1; j <= columnCount; j++) {
                                preparedStatement.setString(j, dataArray[j - 1 + (count * 17)]);
                            }
                            Random random = new Random();
	                        preparedStatement.setInt(18, random.nextInt(100) + 1);
                            preparedStatement.setInt(19, 0);
                            // SQL 쿼리 실행
                            preparedStatement.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("데이터 저장 중 오류 발생: " + e.getMessage());
        }
        out.println("MotherBoard Database 저장 완료 " + (len - 2) + "<br>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
    }
    
    
    //Power

    filePath = webappPath.resolve("power.csv").toString();
    lines.clear();
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        // 파일에서 한 줄씩 읽어와 리스트에 추가 
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 리스트를 배열로 변환
    linesArray = lines.toArray(new String[0]);

    try {
        // JDBC 드라이버 로드
        Class.forName("com.mysql.jdbc.Driver");
        // 데이터베이스 연결
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            // 테이블이 없는 경우 테이블을 만들고 초기화 하는 쿼리
            String createTableQuery = "CREATE TABLE IF NOT EXISTS power_table (" +
            	    "id INT AUTO_INCREMENT PRIMARY KEY," +
            	    "Release_date VARCHAR(255)," +
            	    "company VARCHAR(255)," +
            	    "model VARCHAR(255)," +
            	    "number_of_comments VARCHAR(255)," +
            	    "maximum_output VARCHAR(255)," +
            	    "80PLUS VARCHAR(255)," +
            	    "modulator VARCHAR(255)," +
            	    "form_factor VARCHAR(255)," +
            	    "cooling_fan VARCHAR(255)," +
            	    "bearing VARCHAR(255)," +
            	    "guarantee VARCHAR(255)," +
            	    "efficiency_20_percent VARCHAR(255)," +
            	    "efficiency_50_percent VARCHAR(255)," +
            	    "efficiency_100_percent VARCHAR(255)," +
            	    "voltage_drop VARCHAR(255)," +
            	    "maximum_RPM VARCHAR(255)," +
            	    "environment VARCHAR(255)," +
            	    "MSRP INT," +
            	    "stock INT," +
                    "count INT)";
            try (PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery)) {
                createTableStatement.executeUpdate();
            }
            // 첫 실행 시 테이블 초기화 쿼리 실행
            String truncateQuery = "TRUNCATE TABLE power_table";
            try (PreparedStatement truncateStatement = connection.prepareStatement(truncateQuery)) {
                truncateStatement.executeUpdate();
            }
            // 테이블에 데이터 저장
            len = linesArray.length;
            for (int i = 2; i < len; i++) {
                if (i < len) {
                    // 쉼표로 문자열 분할
                    dataArray = linesArray[i].split(",");
                    // 테이블 데이터 저장 실행
                    for (int count = 0; count < dataArray.length / 18; count++) {
                        String insertQuery = "INSERT INTO power_table (Release_date, company, model, number_of_comments, maximum_output, 80PLUS, modulator, form_factor, cooling_fan, bearing, guarantee, efficiency_20_percent, efficiency_50_percent, efficiency_100_percent, voltage_drop, maximum_RPM, environment, MSRP, stock, count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                            int columnCount = Math.min(18, dataArray.length - count * 18);  // dataArray.length에서 벗어나지 않도록
                            for (int j = 1; j <= columnCount; j++) {
                                preparedStatement.setString(j, dataArray[j - 1 + (count * 18)]);
                            }
                            Random random = new Random();
	                        preparedStatement.setInt(19, random.nextInt(100) + 1);
                            preparedStatement.setInt(20, 0);
                            // SQL 쿼리 실행
                            preparedStatement.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("데이터 저장 중 오류 발생: " + e.getMessage());
        }
        out.println("Power Database 저장 완료 " + (len - 2) + "<br>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
    }
    
    
    //Storage
    
    filePath = webappPath.resolve("storage.csv").toString();

    lines.clear();
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        // 파일에서 한 줄씩 읽어와 리스트에 추가 
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 리스트를 배열로 변환
    linesArray = lines.toArray(new String[0]);

    try {
        // JDBC 드라이버 로드
        Class.forName("com.mysql.jdbc.Driver");
        // 데이터베이스 연결
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            // 테이블이 없는 경우 테이블을 만들고 초기화 하는 쿼리
            String createTableQuery = "CREATE TABLE IF NOT EXISTS storage_table (" +
            	    "id INT AUTO_INCREMENT PRIMARY KEY," +
            	    "release_date VARCHAR(255)," +
            	    "company VARCHAR(255)," +
            	    "model VARCHAR(255)," +
            	    "number_of_comments VARCHAR(255)," +
            	    "capacity VARCHAR(255)," +
            	    "NAND VARCHAR(255)," +
            	    "interface VARCHAR(255)," +
            	    "form_factor VARCHAR(255)," +
            	    "DRAM VARCHAR(255)," +
            	    "read_performance VARCHAR(255)," +
            	    "write_performance VARCHAR(255)," +
            	    "4K_read VARCHAR(255)," +
            	    "4K_write VARCHAR(255)," +
            	    "persistent_write VARCHAR(255)," +
            	    "maximum_temperature VARCHAR(255)," +
            	    "environment VARCHAR(255)," +
            	    "MSRP INT," +
            	    "stock INT," +
                    "count INT)";
            try (PreparedStatement createTableStatement = connection.prepareStatement(createTableQuery)) {
                createTableStatement.executeUpdate();
            }
            // 첫 실행 시 테이블 초기화 쿼리 실행
            String truncateQuery = "TRUNCATE TABLE storage_table";
            try (PreparedStatement truncateStatement = connection.prepareStatement(truncateQuery)) {
                truncateStatement.executeUpdate();
            }
            // 테이블에 데이터 저장
            len = linesArray.length;
            for (int i = 2; i < len; i++) {
                if (i < len) {
                    // 쉼표로 문자열 분할
                    dataArray = linesArray[i].split(",");
                    // 테이블 데이터 저장 실행
                    for (int count = 0; count < dataArray.length / 17; count++) {
                        String insertQuery = "INSERT INTO storage_table (release_date, company, model, number_of_comments, capacity, NAND, interface, form_factor, DRAM, read_performance, write_performance, 4K_read, 4K_write, persistent_write, maximum_temperature, environment, MSRP, stock, count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                            int columnCount = Math.min(17, dataArray.length - count * 17);  // dataArray.length에서 벗어나지 않도록
                            for (int j = 1; j <= columnCount; j++) {
                                preparedStatement.setString(j, dataArray[j - 1 + (count * 17)]);
                            }
                            Random random = new Random();
	                        preparedStatement.setInt(18, random.nextInt(100) + 1);
                            preparedStatement.setInt(19, 0);
                            // SQL 쿼리 실행
                            preparedStatement.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("데이터 저장 중 오류 발생: " + e.getMessage());
        }
        out.println("Storage Database 저장 완료 " + (len - 2) + "<br>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC 드라이버 로드 중 오류 발생: " + e.getMessage());
    }
%>
<a href="main2.jsp"><br>메인화면으로</a>
<a href="deletedata.jsp"><br>오류 시 클릭(테이블 삭제)</a>
</body>
</html>
