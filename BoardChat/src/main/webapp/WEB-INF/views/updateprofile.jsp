<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="header.jsp"%>
<c:if test="${empty sessionScope.user }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>

</script>
<body>
	<div class="container">
		<form method="post" action="/memberprofile" enctype="multipart/form-data">
			<table class="table table-hover table-bodered" style="boder:1px solid #dddddd;text-align:center;">
				<thead>
					<tr>
						<th colspan="3">프로필 수정</th>
					</tr>
				</thead>
				<tbody style="border:1px solid #dddddd;">
					<tr>
						<td colspan="3" style="height: 300px;">
							<img style="max-width:300px; height:300px; margin:0 auto;" class="media-object img-circle"
							 src="/resources/upload/<c:if test="${not empty user.userprofile}"><c:out value="${user.userprofile}"/></c:if>">
						</td>
					</tr>
					<tr>
						<td style="width:110px;background-color:#fafafa; color:#000000;"><h5>이름</h5></td>
						<td colspan="2"><h5><c:out value="${user.username }"/></h5></td>
					</tr>
					<tr>
						<td style="width:110px;background-color:#fafafa; color:#000000;"><h5>나이</h5></td>
						<td colspan="2"><h5><c:out value="${user.userage }"/></h5>
					</tr>
					<tr>
						<td style="width:110px;background-color:#fafafa; color:#000000;"><h5>성별</h5></td>
						<td colspan="2">
							<h5><c:out value="${user.usergender }"/></h5>
						</td>
					</tr>
					<tr>
						<td style="width:110px; background-color:#fafafa; color:#000000;"><h5>프로필 사진</h5></td>
						<td colspan="2">
							<input class="file" name="file" type="file">
							<div class="input-group col-xs-12">
								<input type="text" class="form-control" name="fileName" style="text-align:center;" disabled placeholder="이미지를 업로드하세요.">
								<span class="input-group-btn">
									<button type="button" class="browse btn btn-default"><i class="glyphicon glyphicon-search">파일찾기</i></button>
								</span>
							</div>							
						</td> 
					</tr>
					<tr>
						<td colspan="3"><button type="submit" class="btn btn-primary pull-right">프로필 수정</button></td>
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