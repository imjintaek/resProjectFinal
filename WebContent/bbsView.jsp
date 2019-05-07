<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
<title>맛집보여주는오빠들</title>
</head>
<body>
	<script>
		function checknull(){
			if(!document.getElementById("content").value){
				alert("댓글을 입력해주세요!!");
				return false;
			}
		}
	</script>
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
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<c:if test="${empty sessionScope.client}">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="signUp.html">회원가입</a></li>
						<li><a href="con?command=chart">관리페이지</a></li>
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
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2">${requestScope.pageData.bbsTitle }</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2">${requestScope.pageData.userID }</td>
					</tr>
					<tr>
						<td>작성일</td>
						<td colspan="2">${requestScope.pageData.bbsDate }</td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;">${requestScope.pageData.bbsContent }</td>
					</tr>
				</tbody>
			</table>
			<a href = "con?command=bbs" class="btn btn-primary">목록</a>
			<c:if test="${sessionScope.client.userId == requestScope.pageData.userID }">
				<a class="btn btn-default pull-right" onclick="location.href='con?command=delete&deletepage=${requestScope.pageData.bbsID}'">삭제</a>
				<a class="btn btn-default pull-right" onclick="location.href='viewUpdate.jsp?updatepage=${requestScope.pageData.bbsID}'">수정</a>
			</c:if>
		</div>
		<p></p>
			<c:if test="${not empty sessionScope.client}">
				<label for ="content" style="padding-left:1.0em">comment</label>
				<form action="con" name="commentInsertForm" method="post" onsubmit="return checknull()">
					<input type="hidden" name="command"  value="commant">
					<input type="hidden" name="page" value="${requestScope.pageData.bbsID}">
					<input type="hidden" name="userID" value="${sessionScope.client.userId }">
					<div class="input-group">
						<input type="text" class="form-control" id="content" name="content" placeholder="댓글을 입력하세요.">
						<span class="input-group-btn">
							<button class="btn btn-default" type="submit" name="commentInsertBtn">등록</button>
						</span>
					</div>
				</form>
			</c:if>
			<div class="commentArea" id="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">
			
			</div>
			<script>
			var htmltag = '';
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var commentdata = JSON.parse(this.responseText);
					commentdata.forEach(makehtml);
					document.getElementById("commentArea").innerHTML = htmltag;
				}
			};
			xhttp.open("GET", "con?command=getComment&page=${requestScope.pageData.bbsID}", true);
			xhttp.send();
			
			function makehtml(data){
				htmltag = htmltag + '<div class="commentInfo">작성자 :' + data.userID + '</div>' +
					'<div class ="commentContent"><p>내용:' + data.content + '</p></div>';
			}
			</script>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
</body>
</html>