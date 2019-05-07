<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Time', '게시글수'],
          ['0시-1시',  ${requestScope.chartData[0]}],
          ['1시-2시',  ${requestScope.chartData[1]}],
          ['2시-3시',  ${requestScope.chartData[2]}],
          ['3시-4시',  ${requestScope.chartData[3]}],
          ['4시-5시',  ${requestScope.chartData[4]}],
          ['5시-6시',  ${requestScope.chartData[5]}],
          ['6시-7시',  ${requestScope.chartData[6]}],
          ['7시-8시',  ${requestScope.chartData[7]}],
          ['8시-9시',  ${requestScope.chartData[8]}],
          ['9시-10시',  ${requestScope.chartData[9]}],
          ['10시-11시',  ${requestScope.chartData[10]}],
          ['11시-12시',  ${requestScope.chartData[11]}],
          ['12시-13시',  ${requestScope.chartData[12]}],
          ['13시-14시',  ${requestScope.chartData[13]}],
          ['14시-15시',  ${requestScope.chartData[14]}],
          ['15시-16시',  ${requestScope.chartData[15]}],
          ['16시-17시',  ${requestScope.chartData[16]}],
          ['17시-18시',  ${requestScope.chartData[17]}],
          ['18시-19시',  ${requestScope.chartData[18]}],
          ['19시-20시',  ${requestScope.chartData[19]}],
          ['20시-21시',  ${requestScope.chartData[20]}],
          ['21시-22시',  ${requestScope.chartData[21]}],
          ['22시-23시',  ${requestScope.chartData[22]}],
          ['23시-24시',  ${requestScope.chartData[23]}]
        ]);

        var options = {
          title: '하루 게시글 게이터',
          hAxis: {title: '시간별',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
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
	
	<div id="chart_div" style="width: 100%; height: 500px;"></div>
</body>
</html>