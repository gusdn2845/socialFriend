<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<link rel="stylesheet" href="css/message.css">
<script src="js/custom.js"></script>
<html>
<head>
<title>Home</title>
</head>
<body>
	<script type="text/javascript">
		var profile = '';
		var lastID = 0;
		var fromID = '<c:out value="${user.userid}"/>';
		var toID = '<c:out value="${toID.userid}"/>';

		function chatListFunction(Type) {
			$.ajax({
				type : "POST",
				url : "./chatList",
				dataType : "JSON",
				data : {
					fromID : fromID,
					toID : toID,
					type : Type,
				},
				success : function(data) {
					console.log(data);
					if (data == "")
						return;
					for (var i = 0; i < data.length; i++) {
						if (data[i].fromName == '${user.userid}') {
							data[i].fromName = '나';
							profile = '${user.userprofile}';
						} else {
							data[i].fromName = '${toID.username}';
							profile = '${toID.userprofile}';
						}
						if (profile == '') {
							profile = 'image.jpg';
						}

						console.log(profile);
						addChat(data[i].fromName, data[i].chatContent,
								data[i].chatTime, profile);
					}
					lastID = data[data.length - 1].chatID;
				}
			});
		}

		function msgContinue() {
			setInterval(function() {
				chatListFunction(lastID);
			}, 2000);
		}

		$(document).ready(function() {
			chatListFunction(0);
			msgContinue();
		})
	</script>


	<div class="container" style="z-index: 1;">
		<div id="message_container">
			<div style="width: 520px">
				<!-- 메세지 목록 부분 -->
				<div class="card mr-2 float-left" style="width: 125px;">
					<div class="card-header bg-custom text-white"
						id="message_listtitle">
						<span>목록</span>
					</div>
					<div class="card-body" id="message_list">
						<div class="ml-2 mb-3 message_profile">
							<img class="media-object img-circle message_listimage"
								src="/resources/upload/image.jpg" draggable="true"
								ondragstart="drag(this, event)">
							<div class="background_green" id="message_state"></div>
							<div id="message_readcount">
								<span id="message_readtext">1</span>
							</div>
							<div class="message_nickname">
								<span>김현우</span>
							</div>
						</div>
					</div>

					<div class="card-footer" id="memberList_footer"
						ondragover="return false;" ondragenter="return false;"
						ondrop="drop(this, event);">
						<div class="message_waste"></div>
					</div>
				</div>
				<!-- 메세지함 부분 -->
				<div class="card">
					<div class="card-header bg-custom text-white" id="message_title">
						<div class="message_userInfo">
							<!-- <img class="rounded-circle message_userimage" src="/images/profile/kakao/kakao-5.png"> -->
							<span id="message_title_text">채팅창</span>
						</div>
						<div class="message_functionbtn">
							<img src="images/find-my-friend.png" class="modal_open"
								data="searchModal"> <img src="images/friendship.png"
								class="modal_open" data="friendModal">
						</div>
					</div>

					<div class="alert alert-success" id="successMessage"
						style="display: none; width: 100%;">
						<strong>메세지 전송에 성공했습니다.</strong>
					</div>
					<div class="alert alert-danger" id="dangerMessage"
						style="display: none; right: 0;">
						<strong>내용을 입력해주세요.</strong>
					</div>
					<div class="alert alert-warning" id="warningMessage"
						style="display: none;">
						<strong>데이터베이스 오류가 발생했습니다.</strong>
					</div>
					<div class="card-body" id="message_body"></div>
					<div class="card-footer" id="message_footer">
						<div class="form-group col-xs-10">
							<input id="chatContent" class="form-control"
								placeholder="메세지를 입력하세요." maxlength="100">
						</div>
						<div class="form-group col-xs-2">
							<button type="button" class="btn btn-default pull-right"
								onclick="submitFunction();">전송</button>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
