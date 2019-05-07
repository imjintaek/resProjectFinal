<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css">

<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<link href="SummerNote/dist/summernote.css" rel="stylesheet" type="text/css"/>
<script src="SummerNote/dist/summernote.js" type="text/javascript"></script>
<title>맛집보여주는오빠들</title>
</head>
<body>
	<nav class="navbar nabvar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="mainPage.jsp">맛보오</a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="mainPage.jsp">메인</a></li>
			<li><a href="con?command=bbs">게시판</a></li>
			<li><a href="con?command=chart">관리페이지</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><c:if test="${empty sessionScope.client}">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"
						role="button" aria-haspopup="true" aria-expanded="false">접속하기<span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="signUp.html">회원가입</a></li>
					</ul></li>
			</c:if>
			<c:if test="${not empty sessionScope.client}">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown"
					role="button" aria-haspopup="true" aria-expanded="false">${sessionScope.client.userId }님<span
					class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="con?command=inform">회원정보</a></li>
					<li><a href="con?command=logOut">로그아웃</a></li>
				</ul>
			</c:if>
		</ul>
	</div>
	</nav>

	<div class="container">
		<div class="row">
			<form action="con"method="post">
				<input type="hidden" name="command" value="update">
				<input type="hidden" name="updatepage" value="${param.updatepage}">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">글 수정</th>
						</tr>
					</thead>
					<tbody>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"/></td>
						</tr>
					</tbody>
				</table>
				<textarea id="summernote" name="bbsContent"></textarea>
						
				<script>
				$(document).ready(function(){
					$('#summernote').summernote({
						height : 300,
						minHeight: null,
						maxHeight: null,
						focus: true
					});
				});
				</script>
				<input type="submit" class="btn btn-primary pull-right" value="글수정"/>
			</form>
		</div>
	</div>
</body>
</html>