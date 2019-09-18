<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<html>
<head>
<title>Home</title>
</head>
<script type="text/javascript">
	
</script>
<body>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class="form-control" id="userName" onkeyup="searchFunction();" type="text" size="20">
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" type="button" onclick="searchFunction();">검색</button>
			</div>
		</div>
		<table class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #dddddd; margin: 0 auto;">
			<thead>
				<tr>
					<th>친구 목록</th>
				</tr>
			</thead>
			<div style="overflow-y: auto; max-height: 450px; width: 100%;">
				<table class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #dddddd; margin: 0 auto;">
					<tbody id="boxList">
					</tbody>
					<tfoot>
					</tfoot>
				</table>
			</div>
		</table>
	</div>
</body>
</html>
