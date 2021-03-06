<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
<title>맛집보여주는오빠들</title>
</head>
<body>
	<nav class="navbar nabvar-default">
	      <div class="navbar-header">
	         <button type="button" class="navbar-toggle collapsed"
	            data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
	            aria-expanded="false">
	            <span class="icon-bar"></span> 
	            <span class="icon-bar"></span> 
	            <span class="icon-bar"></span>
	         </button>
	         <a class="navbar-brand" href="mainPage.jsp">맛보오</a>
	      </div>
	      <div class="collapse navbar-collapse"
	         id="bs-example-navbar-collapse-1">
	         <ul class="nav navbar-nav">
	            <li><a href="mainPage.jsp">메인</a></li>
	            <li><a href="con?command=bbs">게시판</a></li>
	            <li><a href="con?command=chart">관리페이지</a></li>
	         </ul>
	         <ul class="nav navbar-nav navbar-right">
	            <li class="dropdown">
	            <c:if test="${empty sessionScope.client}"> 
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
	               aria-expanded="false">접속하기<span class="caret"></span></a>
	               <ul class="dropdown-menu">
	                  <li><a href="login.jsp">로그인</a></li>
	                  <li><a href="signUp.html">회원가입</a></li>
	               </ul>
	            </li>
	            </c:if>
	            <c:if test="${not empty sessionScope.client}">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
	               aria-expanded="false">${sessionScope.client.userId }님<span class="caret"></span></a>
	               <ul class="dropdown-menu">
	                  <li><a href="con?command=inform">회원정보</a></li>
	                  <li><a href="con?command=logOut">로그아웃</a></li>
	               </ul>
	            </c:if>
	         </ul>
	      </div>
   	</nav>
	
<div class="container">
<table class ="table table-hover">
	<thead>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>날짜</th>
		<th>조회수</th>
	</tr>
	</thead>
	<tbody>
		<c:forEach items="${sessionScope.bbsContents}" var = "data">
			<tr>
				<td>${data.bbsID }</td>
				<td><a href="con?command=view&page=${data.bbsID}">${data.bbsTitle }</a></td>
				<td>${data.userID }</td>
				<td>${data.bbsDate }</td>
				<td>0</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<hr/>
<c:if test="${not empty sessionScope.client}">
	<a class="btn btn-default pull-right" href="bbswrite.jsp">글쓰기</a>
</c:if>
<c:if test="${empty sessionScope.client}">
	<script>
		function warrning(){
			alert('로그인을 하셔야 게시글을 작성하실 수 있습니다.');
			location.href="login.jsp";
		}
	</script>
	<a class="btn btn-default pull-right" onclick="warrning()">글쓰기</a>
</c:if>

<div class="text-center">
	<ul class="pagination">
	<c:forEach var ="i" begin="1" end="${sessionScope.PageCount }" step="1">
		<li><a href="con?command=bbs&page=${sessionScope.PageCount - i + 1}">${i}</a></li>
	</c:forEach>
	</ul>
</div>


</div>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>
</body>
</html>