//find.jsp
function messengerOpen(user) {
	toID = user;
	$('#message_body').html('');
	$('#messengerModal').modal('show');
	chatListFunction(toID,0);
	msgContinue();
}

// 메신져 버튼 별 처리 구분
function messengerBtn() {
	// 결국 여기가 창 뜰때마다 실행되니까
	// 이벤트가 창 띄울때마다 추가되고

	$c('.messenger_btn').on('click', function() {
		var data = $(this).attr('data');
		if (data == 'message') {
			var nick = $('#message_title_text').attr('data');
			var content = $('#message_input').val();
			var type = data;
			sendMessage(nick, type, content);

		} else if (data == 'search') {
			var searchVal = $('#search_text').val();
			console.log(searchVal);
			findUser(searchVal);
		} else if (data == 'friend') {
			var friendVal = $('#friend_text').val();
		}
	});

	$c('.messenger_input').on('keyup', function(e) {
		var data = $(this).attr('data');
		var value = $(this).val();
		if (e.which == 13) {
			if (data == 'message') {

			} else if (data == 'search') {
				findUser(value);

			} else if (data == 'friend') {
				$('#friendModal').modal('hide');
			}
		}
	});
}

function findFunction() {
	var findName = $('#findName').val();
	if (findName == "") {
		$('#checkType').attr('class', 'modal-content panel-warning');
		$('#checkMessage').html('검색할 아이디를 입력해주세요.');
		$('#checkModal').modal('show');
		return;
	}
	$.ajax({
		type : "POST",
		url : "/findFriend",
		dataType : "JSON",
		data : {
			findName : $('#findName').val(),
		},
		success : function(result) {
			if (result.user == null) {
				$('#findTable').html('');
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkMessage').html('검색결과가 없습니다.');
				$('#checkModal').modal('show');
			} else {
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkMessage').html('검색이 되었습니다.');
				$('#checkModal').modal('show');
				getFriend(result);
			}
		}
	});
}

function getFriend(result) {
	console.log(result);
	if (result.user.userprofile == '') {
		result.user.userprofile = 'image.jpg';
	}
	$('#findTable')
			.html(
					'<thead>'
							+ '<tr>'
							+ '<thead>'
							+ '<th><h4>검색 결과</th></h4>'
							+ '</tr>'
							+ '<tbody>'
							+ '<td><img class="media-object img-circle" style="max-width:300px; margin:0 auto;" src="/resources/upload/'
							+ result.user.userprofile
							+ '">'
							+ '<h3>'
							+ result.user.username
							+ '&nbsp;('
							+ result.user.usergender
							+ ')</h3><br>'
							+ '<button type="button" class="btn btn-default" onclick="messengerOpen(\''+ result.user.userid +'\')">메세지 보내기</button>'
							+ '<a class="btn btn-default" href="/friendReq?toID='+ result.user.userid +'">친구 요청</a>'
							+ '</tbody>');
	
	
}

//Chat.jsp
function submitFunction() {
	var chatContent = $('#chatContent').val();
	if (chatContent == '') {
		autoClosingAlert('#dangerMessage', 2000);
		return;
	}
	$.ajax({
		type : "POST",
		url : "/chatSubmit",
		dataType : "JSON",
		data : {
			fromID : fromID,
			toID : toID,
			chatContent : chatContent,
		},
		success : function(result) {
			if (result == -1) {
				autoClosingAlert('#warningMessage', 2000);
			} else {
				autoClosingAlert('#successMessage', 2000);
			}
		}
	});
	$('#chatContent').val("");
}

function autoClosingAlert(selector, delay) {
	var alert = $(selector).alert();
	alert.show();
	window.setTimeout(function() {
		alert.hide()
	}, delay);
}

function addChat(chatName, chatContent, chatTime, profile) {
	if (chatName == '나') {
		$('#message_body')
				.append(
						'<div class="col-xs-12">'
								+ '<div class="message_commentwarp">'
								+ '<div class="message_imgwarp_me">'
								+ '<img class="media-object img-circle" id="message_img" src="/resources/upload/'
								+ profile
								+ '">'
								+ '</div>'
								+ '<div class="message_commentbox_me">'
								+ '<div class="message_nick_me ">'
								+ '<p>'
								+ chatName
								+ '</p>'
								+ '</div>'
								+ '<div class="clear-fix"></div>'
								+ '<div class="message_baloon_me">'
								+ '<p>'
								+ chatContent
								+ '</p>'
								+ '</div>'
								+ '<div class="message_date_me">'
								+ '<p>'
								+ chatTime
								+ '</p>'
								+ '</div></div></div></div>'
								+ '<div class="clear-fix message_padding"></div>');
	} else {
		$('#message_body')
				.append(
						'<div class="col-xs-12">'
								+ '<div class="message_commentwarp">'
								+ '<div class="message_imgwarp">'
								+ '<img class="media-object img-circle" id="message_img" src="/resources/upload/'
								+ profile
								+ '">'
								+ '</div>'
								+ '<div class="message_commentbox_other">'
								+ '<div class="message_nick">'
								+ '<p>'
								+ chatName
								+ '</p>'
								+ '</div>'
								+ '<div class="clear-fix"></div>'
								+ '<div class="message_baloon">'
								+ '<p>'
								+ chatContent
								+ '</p>'
								+ '</div>'
								+ '<div class="message_date">'
								+ '<p>'
								+ chatTime
								+ '</p>'
								+ '</div></div></div></div>'
								+ '<div class="clear-fix message_padding"></div>');
	}
	$('#message_body').scrollTop($('#message_body')[0].scrollHeight);
}


//friendRequest.jsp
function getList() {
	$.ajax({
		type : "POST",
		url : "./friendReqList",
		dataType : "JSON",
		data : {
			name : user,
		},
		success : function(result) {
			var table = document.getElementById("requestList");
			table.innerHTML = "";
			for (var i = 0; i < result.length; i++) {
				$('#requestList').append('<tr onclick="choose(\''+result[i].userid+'\')">'
						+ '<td style="width:150px;">'
						+ '<img class="media-object img-circle" style="max-width:40px; max-height:40px; margin:0 auto;" src="/resources/upload/'+result[i].userprofile+'">'
						+ '</td>'
						+ '<td style="width:150px;"><h5>'
						+ result[i].username
						+ '</h5></td>'
						+ '<td style="width:150px;"><h5>'
						+ result[i].userage
						+ '</h5></td>'
						+ '<td style="width:150px;"><h5>'
						+ result[i].usergender
						+ '</h5></td>' + '</tr>');
					}
				}
			});
}

function accept() {
	$.ajax({
		type : "POST",
		url : "./friendAccept",
		dataType : "JSON",
		data : {
			name : user,
			friendID : id,
		},
		success : function(result) {
			if(result == 1){
				$('#checkMessage').html('<h5>친구요청을 수락하였습니다.</h5>');
				$('#checkModal').modal('show');
			}else{
				$('#checkMessage').html('<h5>오류가 발생하였습니다.</h5>');
				$('#checkModal').modal('show');
			}
		}
	});
}

function refusal() {
	$.ajax({
		type : "POST",
		url : "./friendRefusal",
		dataType : "JSON",
		data : {
			name : user,
			friendID : id,
		},
		success : function(result) {
			if(result == 1){
				window.location.reload();
			}else{
				$('#checkMessage').html('<h5>오류가 발생하였습니다.</h5>');
				$('#checkModal').modal('show');
			}
		}
	});
}


function choose(chooseid) {
	id = chooseid;
	$('#chooseMessage').html('<h5>'+id+'님 친구요청을 수락하시겠습니까 ?</h5>');
	$('#chooseModal').modal('show');
}

