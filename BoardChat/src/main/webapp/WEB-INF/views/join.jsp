<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	var checkID = 0;
	var checkPW = 0;

	function useIDCheck(id) {
		var idRegExp = /^[a-zA-Z0-9]{4,12}$/;
		if (!idRegExp.test(id)) {
			return false;
		}
		return true;
	}

	function ischeckID() {
		var id = $('#userID').val();
		if (id == "") {
			$('#checkType').attr('class', 'modal-content panel-warning');
			$('#checkMessage').html('<h5>아이디를 입력해주세요.</h5>');
			$('#checkModal').modal('show');
			return;
		}

		if (!useIDCheck(id)) {
			$('#checkType').attr('class', 'modal-content panel-warning');
			$('#checkMessage').html(
					'<h5>아이디는 영문 대소문자와 숫자 4~12자리로 입력해야합니다.</h5>');
			$('#checkModal').modal('show');
			return;
		}

		$.ajax({
			type : "POST",
			url : "/checkid",
			data : {
				userid : encodeURIComponent(id),
			},
			success : function(result) {
				if (result) {
					$('#checkType')
							.attr('class', 'modal-content panel-success');
					$('#checkMessage').html('<h5>사용 가능한 아이디입니다.</h5>');
					choiceID = $('#userID').val();
					checkID = 1;
				} else {
					$('#checkType')
							.attr('class', 'modal-content panel-warning');
					$('#checkMessage').html('<h5>이미 존재하는 회원입니다.</h5>')
				}
				$('#checkModal').modal('show');
			}
		});
	}

	function passwordCheck() {
		var password1 = $('#password1').val();
		var password2 = $('#password2').val();
		if (password1 != password2) {
			$('#passwordCheck').html('비밀번호가 일치하지 않습니다.');
			checkPW = 0;
		} else {
			if (password1.length >= 8) {
				$('#passwordCheck').html('');
				checkPW = 1;
			} else {
				$('#passwordCheck').html('8자리이상 비밀번호를 입력해주세요.');
				checkPW = 0;
			}
		}
	}

	function checkJoin() {
		var userID = $('#userID').val();
		var userName = $('#userName').val();
		var userAge = $('#userAge').val();
		var userEmail = $('#userEmail').val();
		var password1 = $('#password1').val();
		var password2 = $('#password2').val();

		if (userID == "" || userName == "" || userAge == "" || userEmail == ""
				|| password1 == "" || password2 == "") {
			$('#checkType').attr('class', 'modal-content panel-warning');
			$('#checkMessage').html('<h5>입력이 안된 사항이 있습니다.</h5>');
			$('#checkModal').modal('show');
			return false;
		}

		if (choiceID != $('#userID').val()) {
			checkID = 0;
		}

		if (checkID == 0) {
			$('#checkType').attr('class', 'modal-content panel-warning');
			$('#checkMessage').html('<h5>아이디 중복 확인해주세요.</h5>');
			$('#checkModal').modal('show');
			return false;
		}

		if (checkPW == 0) {
			$('#checkType').attr('class', 'modal-content panel-warning');
			$('#checkMessage').html('<h5>비밀번호와 비밀번호확인을 확인해주세요.</h5>');
			$('#checkModal').modal('show');
			return false;
		}
		return true;
	}
</script>
<body>
	<div class="container">
		<form method="post" action="/memberJoin">
			<table class="table table-hover table-bodered"
				style="boder: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3" style="text-align: center">회원가입</th>
					</tr>
				</thead>
				<tbody style="border: 1px solid #dddddd;">
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">아이디</td>
						<td><input class="form-control change-from" type="text"
							id="userID" name="userid" placeholder="아이디를 입력하세요."></td>
						<td style="width: 110px;"><button type="button"
								class="btn btn-primary" onclick="ischeckID();">중복확인</button></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">비밀번호</td>
						<td colspan="2"><input class="form-control" type="password"
							id="password1" onkeyup="passwordCheck();" name="userpw"
							placeholder="비밀번호를 입력하세요."></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">비밀번호확인</td>
						<td colspan="2"><input class="form-control" type="password"
							id="password2" onkeyup="passwordCheck();" name="userpwconfirm"
							placeholder="비밀번호를 입력하세요."></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">이름</td>
						<td colspan="2"><input class="form-control" type="text"
							id="userName" name="username" placeholder="이름을 입력하세요."></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">나이</td>
						<td colspan="2"><input class="form-control" type="number"
							id="userAge" name="userage" placeholder="나이를 입력하세요."></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">성별</td>
						<td colspan="2">
							<div class="form-group"
								style="margin: 0 auto; text-align: center;">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-default active"> <input
										type="radio" name="usergender" value="남자" checked>남자
									</label> <label class="btn btn-default"> <input type="radio"
										name="usergender" value="여자">여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">이메일</td>
						<td colspan="2"><input class="form-control" type="email"
							id="userEmail" name="useremail" placeholder="이메일을 입력하세요."></td>
					</tr>
					<tr>
						<td colspan="2"><h5 style="color: red; text-align: left;"
								id="passwordCheck"></h5></td>
						<td><button type="submit" class="btn btn-primary pull-right"
								onclick="return checkJoin();">회원가입</button></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>