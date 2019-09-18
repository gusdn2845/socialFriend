<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<html>
<head>
<title>Home</title>
</head>
<style>
	
</style>
<body>
	<div class="container">
		<div class="jumbotron">
			<h1>JSP 게시판 예제</h1>
			<p>부트스트랩과 JSP를 활용한 웹 페이지 예제입니다.</p>
		</div>
		<div class="row">
			<div class="col-md-4">
				<h4>C언어 게시판</h4>
				<p>C언어 프로그래밍의 지식을 나눌수 있는 게시판입니다.</p>
				<a href="#" class="btn btn-default">게시판 가기</a>
			</div>
			<div class="col-md-4">
				<h4>JAVA 게시판</h4>
				<p>JAVA 프로그래밍의 지식을 나눌수 있는 게시판입니다.</p>
				<a href="#" class="btn btn-default">게시판 가기</a>
			</div>
			<div class="col-md-4">
				<h4>Android 게시판</h4>
				<p>Android 프로그래밍의 지식을 나눌수 있는 게시판입니다.</p>
				<a href="#" class="btn btn-default">게시판 가기</a>
			</div>
		</div>
		<hr>
		<div class="panel panel-primary">
		<div class="panel-heading">
			<h5 class="panel-title"><span class="glyphicon glyphicon-pencil"></span>&nbsp; 게시판 목록</h5>
		</div>
		<div class="panel-body">
			<div class="media">
					<div class="media-left">
						<a href="#"><img class="media-object" src="images/C.jpg"></a>
					</div>
					<div class="media-body">
						<h4 class="media-heading"><a href="#">C언어 게시판</a>&nbsp;<span class="badge">New</span></h4>
						C언어를 배우는 분들을 위한 게시판입니다.
					</div>
				</div>
				<hr>
				<div class="media">
					<div class="media-left">
						<a href="#"><img class="media-object" src="images/java.jpg"></a>
					</div>
					<div class="media-body">
						<h4 class="media-heading"><a href="#">Java 게시판</a>&nbsp;<span class="badge">New</span></h4>
					</div>
				</div>
		</div>
	</div>
	</div>
</body>
</html>
