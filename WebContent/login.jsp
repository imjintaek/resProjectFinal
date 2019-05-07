<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
<title>맛집보여주는오빠들</title>
</head>
<body>
	<c:set var="errorMsg" value="${requestScope.error}"/>
	<c:if test="${errorMsg eq 'loginfail'}">
		<script>alert("로그인에 실패하셨습니다. 아이디와 비밀번호를 확인하세요");</script>
	</c:if>
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
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
               aria-expanded="false">접속하기<span class="caret"></span></a>
               <ul class="dropdown-menu">
                  <li class="active"><a href="login.jsp">로그인</a></li>
                  <li><a href="signUp.html">회원가입</a></li>
               </ul>
            </li>
         </ul>
      </div>
   </nav>
   <div class="container">
      <div class="col-lg-4"></div>
      <div class="col-lg-4">
         <div class="jumbotron" style="padding-top: 20px;">
            <form method="post" action="con">
            <input type="hidden"  name = "command" value="login">
            <h3 style="text-align: center;">로그인화면</h3>
            <div class="form-group">
               <input type="text" class="form-control" placeholder="아이디" name="userId" maxlenght="20">
            </div>
            <div class="form-group">
               <input type="password" class="form-control" placeholder="비밀번호" name="userPass" maxlenght="20">
                </div> 
               <input type="submit" class="btn btn-primary form-control" value="로그인">
            </from>
        </div>
      </div>
      <div class="col-lg-4"></div>
   </div>
   <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="bootstrap/js/bootstrap.js"></script>
</body>
</html>