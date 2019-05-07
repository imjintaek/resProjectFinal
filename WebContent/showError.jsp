<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
		<div class="row">
			<form action="mainPage.jsp"method="post">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">요청하신 페이지를 확인할 수 없습니다.</th>
						</tr>
					</thead>
					<tbody>
				</table>
				<br>
				<br>
				<input type="submit" class="btn btn-primary form-control" value="메인페이지"/>
			</form>
		</div>
	</div>
</body>
</html>