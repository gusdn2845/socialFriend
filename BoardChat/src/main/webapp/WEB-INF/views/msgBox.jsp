<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="css/message.css">
<script src="js/custom.js"></script>
<html>
<head>
	<title>Home</title>
</head>
<script type="text/javascript">
function getBox(){
	var userID = '${user.userid}';
	$.ajax({
		type: "POST",
		url: "./chatBox",
		data:{
			name: userID,
		},
		success: function(data){
			console.log(data);
			if(data == "") return;
			if(data == "0") return;
			$('#boxList').html('');
			for(var i = 0 ; i < data.length ; i++){
				if(data[i].chatRead == '0'){
					data[i].chatRead = '';
				}
				addBox(data[i].fromName,data[i].toName,data[i].chatContent,data[i].profile,data[i].chatTime,data[i].chatRead);
			}
		}
	});
}

function addBox(name,id,chatContent,profile,chatTime,chatRead){
	if(profile == ''){
		profile = 'image.jpg';
	}
	$('#boxList').append('<tr onclick="location.href=\'chat?toID='+ id +'\'">'+
				'<td style="width:150px;">'+
				'<img class="media-object img-circle" style="max-width:40px; max-height:40px; margin:0 auto;" src="/resources/upload/'+profile+'">'+
				'<h5>'+name+'</h5>'+
				'</td>'+
				'<td>'+
				'<h5>'+chatContent+'<span class="label label-info">'+chatRead+'</span></h5>'+
				'<div class="pull-right">'+chatTime+'</div>'+
				'</td>'+
				'</tr>'
	);
}

function getListContinue(){
	setInterval(function(){
		getBox();
	},3000);
};

$(document).ready(function(){
	getListContinue();
	getBox();
});
</script>
<body>
	<div class="container">
		<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd;margin:0 auto;">
			<thead>
				<tr>
					<th>메세지함</th>
				</tr>
			</thead>
			<div style="overflow-y:auto;max-height:450px; width:100%;">
				<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd; margin:0 auto;">
					<tbody id="boxList">
					</tbody>
				</table>
			</div>
		</table>
	</div>
	
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog" id="message_modal_layout">
			<div class="modal-content"
				style="background-color: transparent; border: 1px solid transparent">
				<div class="modal-body">
					<div id="message_container">
						<div style="width: 800px">
							<!-- 메세지 목록 부분 -->
							<div class="card mr-2 float-left" style="width: 125px;">
								<div class="card-header bg-custom text-white"
									id="message_listtitle">
									<span>목록</span>
								</div>
								<div class="card-body" id="message_list">
									<div class="ml-2 mb-3 message_profile">
										<img class="rounded-circle message_listimage"
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

								<div class="card-body" id="message_body">
									<div class="message_commentwarp">
										<div class="message_imgwarp">
											<img class="rounded-circle" id="message_img"
												src="/resources/upload/image.jpg">
										</div>
										<div class="message_commentbox_other">
											<div class="message_nick">
												<p>김현우</p>
											</div>
											<div class="clear-fix"></div>
											<div class="message_baloon">
												<p>메세지</p>
											</div>
											<div class="message_date">
												<p>2019년 09월 17일</p>
											</div>
										</div>
									</div>
									<div class="clear-fix message_padding"></div>
								</div>
								<div class="card-footer" id="message_footer">
									<input type="text" class="messenger_input" id="message_input"
										data="message">
									<button class="btn btn-warning messenger_btn" id="message_btn"
										data="message">전송</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
