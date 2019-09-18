<%@page import="java.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
		InitialContext initCtx = new InitialContext();
		Context envContext = (Context) initCtx.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/UserChat");
		Connection conn = ds.getConnection();
		PreparedStatement pstmt = conn.prepareStatement("SELECT VERSION();");
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			out.println("MySQL Version : "+rs.getString("version()"));
		}
		rs.close();
		pstmt.close();
		conn.close();
	%>
</body>
</html>