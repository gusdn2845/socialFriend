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
	function checkLogin() {
		var userid = $('#userid').val();
		var userpw = $('#userpw').val();
		if (userid == '' || userpw == '') {
			$('#checkType').attr('class', 'modal-content panel-warning');
			$('#checkMessage').html('<h5>입력이 안된 사항이 있습니다.</h5>');
			$('#checkModal').modal('show');
			return false;
		} else {
			return true;
		}
	}

	
</script>
<body>
	<div class="container">
		<form method="post" action="/memberLogin">
			<table class="table table-hover table-bodered"
				style="boder: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3" style="text-align: center">로그인</th>
					</tr>
				</thead>
				<tbody style="border: 1px solid #dddddd;">
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">아이디</td>
						<td colspan="2"><input class="form-control" type="text"
							name="userid" id="userid" placeholder="아이디 입력하세요."></td>
					</tr>
					<tr>
						<td
							style="width: 110px; background-color: #fafafa; color: #000000;">비밀번호</td>
						<td colspan="2"><input class="form-control" type="password"
							name="password" id="password" placeholder="비밀번호를 입력하세요."></td>
					</tr>
					<tr>
						<td colspan="3"><button type="submit"
								onclick="return checkLogin()" class="btn btn-primary pull-right">로그인</button></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	
	<%@ include file="footer.jsp"%>
</body>
</html>