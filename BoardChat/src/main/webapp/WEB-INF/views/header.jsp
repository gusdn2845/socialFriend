<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet"  href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>	
<script src="js/bootstrap.js"></script>
<script src="js/custom.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
<c:if test="${not empty user}">
	var unread = '';
	function getUnread(){
		$.ajax({
			type:"POST",
			url: "./unread",
			dataType: "JSON",
			data:{
				name: '${user.userid}',
			},
			success: function(result){
				unread = result;
				if(result >= 1){
					showUnread(unread);
				}else{
					showUnread('');
				}
			}
		});
	}

	function getFriendReq(){
		$.ajax({
			type:"POST",
			url: "./friendReqNum",
			dataType: "JSON",
			data:{
				name: '${user.userid}',
			},
			success: function(result){
				request = result;
				console.log(request);
				if(result >= 1){
					showRequest(request);
				}else{
					showRequest('');
				}
			}
		});
	}
	function showUnread(unread){
		$('#unread').html(unread);
	}

	function showRequest(request){
		$('#request').html(request);
	}
	
	function unreadContinue(){
		setInterval(function(){
			getUnread();
			getFriendReq();
		},2000);
	}
	
	$(document).ready(function(){
		getUnread();	
		unreadContinue();
		getFriendReq();
	})
</c:if>
</script>
</head>
<body>
	<nav class="navbar navbar-default" style="z-index: 9999;">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#menu">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a href="/" class="navbar-brand">JSP 게시판</a>
		</div>
		<div class="collapse navbar-collapse" id="menu">
			<ul class="nav navbar-nav">
				<li><a href="/">메인</a></li>
				<li><a href="msgBox">메세지함<span id="unread" class="label label-info"></span></a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">친구 관리<span class="caret"></span>
						<span id="request" class="label label-info"></span></a>
					<ul class="dropdown-menu" style="z-index: 9999;">
						<li><a href="friendList">친구 목록</a></li>
						<li><a href="friendRequest">친구 요청<span id="request" class="label label-info"></span></a></li>
					</ul>
				</li>
				<li><a href="find">친구 찾기</a></li>
			</ul>
			<c:if test="${sessionScope.user == null }">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"> 접속하기<span class="caret"></span></a> <!-- 로그인과 회원가입 -->
						<ul class="dropdown-menu">
							<li><a href="login">로그인</a></li>
							<li><a href="join">회원가입</a></li>
						</ul>
					</li>
				</ul>
			</c:if>
			<c:if test="${sessionScope.user != null }">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"> 회원정보관리<span class="caret"></span></a> <!-- 로그인과 회원가입 -->
						<ul class="dropdown-menu">
							<li><a href="update">회원정보수정</a></li>
							<li><a href="updateprofile">프로필수정</a></li>
							<li><a href="logout">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			</c:if>
		</div>
	</nav>
</body>
</html>