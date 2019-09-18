<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function(){
		
	})
		
	var checkPW = 0;
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

	function checkupdate() {
		var userpw1 = $('#password1').val();
		var userpw2 = $('#password2').val();
		var usereamil = $('#usereamil').val();
		if (userpw1 == '' || userpw2 == ''|| useremail == '') {
			$('#checkType').attr('class', 'modal-content panel-warning');
			$('#checkMessage').html('<h5>입력이 안된 사항이 있습니다.</h5>');
			$('#checkModal').modal('show');
			return false;
		} else {
			if(checkPW == 0){
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkMessage').html('<h5>비밀번호가 서로 일치하지 않습니다.</h5>');
				$('#checkModal').modal('show');
				return false;
			}
			if(userpw1.length > 15){
				$('#checkType').attr('class', 'modal-content panel-warning');
				$('#checkMessage').html('<h5>비밀번호가 너무 깁니다.</h5>');
				$('#checkModal').modal('show');
				return false;
			}
			return true;
		}
	}
</script>
<body>
	<div class="container">
		<form method="post" action="/memberupdate">
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2"><h4>회원정보수정</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;"><h5>아이디</h5></td>
						<td><h5>
								<c:out value="${user.userid}" />
							</h5> <input type="hidden" value=""></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;"><h5>비밀번호</h5></td>
						<td colspan="2"><input class="form-control"
							onkeyup="passwordCheck();" type="password" id="password1"
							name="userpw" maxlength="20" placeholder="비밀번호를 입력하세요"></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;"><h5>비밀번호
								확인</h5></td>
						<td colspan="2"><input class="form-control"
							onkeyup="passwordCheck();" type="password" id="password2"
							name="userpwconfirm" maxlength="20" placeholder="비밀번호확인을 입력하세요"></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;"><h5>이름</h5></td>
						<td colspan="2"><h5>
								<c:out value="${user.username}" />
							</h5> <input type="hidden" disabled
							value="<c:out value="${user.username}"/>"></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;"><h5>나이</h5></td>
						<td colspan="2"><h5>
								<c:out value="${user.userage}" />
							</h5> <input type="hidden" disabled
							value="<c:out value="${user.userage}"/>"></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;"><h5>성별</h5></td>
						<td colspan="2">
							<h5>
								<c:out value="${user.usergender}" />
							</h5> <input type="hidden" name="userGender"
							value="<c:out value="${user.usergender}"/>">
						</td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control" type="email"
							id="useremail" name="useremail" maxlength="20"
							placeholder="이메일을 입력하세요" value=<c:out value="${user.useremail}" />></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;"><h5>프로필사진</h5></td>
						<td colspan="2">
							<div class="input-group col-xs-12">
								<input style="text-align: center;" type="text" disabled
									class="form-control" value=""> <span
									class="input-group-btn"> <a href="updateprofile"
									class="btn btn-primary">프로필사진 수정</a>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"><h5 style="color: red; text-align: left;"
								id="passwordCheck"></h5>
							<button type="submit" class="btn btn-primary pull-right"
								onclick="return checkupdate();">수정</button></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		$('.browse').on('click', function() {
			var file = $(this).parent().parent().parent().find('.file');
			file.trigger('click');
		});

		$('.file').on(
				'change',
				function() {
					$(this).parent().find('.form-control').val(
							$(this).val().replace(/C:\\fakepath\\/i, ''));
				});
	</script>
	<%@ include file="footer.jsp"%>
</body>
</html>