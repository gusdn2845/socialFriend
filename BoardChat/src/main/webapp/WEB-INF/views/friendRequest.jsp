<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<html>
<head>
<title>Home</title>
</head>
<script type="text/javascript">
	var user = '${user.userid}';
	var id = '';

	function requestContinue(){
		setInterval(function(){
			getList();	
		},2000);	
	}
	
	$(document).ready(function() {
		requestContinue();
		getList();
	})
</script>
<body>
	<div class="container">
		<table class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #dddddd; margin: 0 auto;">
			<thead>
				<tr>
					<th colspan="4">친구 요청 관리</th>
				</tr>
				<tr>
					<th
						style="color: black; background-color: #fafafa; text-align: center;">프로필</th>
					<th
						style="color: black; background-color: #fafafa; text-align: center;">이름</th>
					<th
						style="color: black; background-color: #fafafa; text-align: center;">나이</th>
					<th
						style="color: black; background-color: #fafafa; text-align: center;">성별</th>
				</tr>
			</thead>
			<tbody id="requestList">
			</tbody>
		</table>
	</div>
	
	<div class="modal fade" id="chooseModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div id="checkType" class="modal-content panel-success">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">확인 메세지</h4>
					</div>
					<div id="chooseMessage" class="modal-body"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" onclick="accept()" data-dismiss="modal">수락</button>
						<button type="button" class="btn btn-default" onclick="refusal()" data-dismiss="modal">거절</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
