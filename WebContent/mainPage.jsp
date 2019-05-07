<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8"); %>
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
</body>
<div class="container">
	<div id="map" style="width:100%;height:400px;"></div>
</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800ca059e8d14618fcc8e7060b5185ff&libraries=clusterer"></script>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
   	<script src="bootstrap/js/bootstrap.js"></script>
	<script>
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var mapdata = JSON.parse(this.responseText);
				getMapData(mapdata);
			}
		};
		xhttp.open("GET", "con?command=mapPage", true);
		xhttp.send();
		
		// 지도를 생성합니다    
		function getMapData(data){
		    var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
		        center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
		        level : 14 // 지도의 확대 레벨 
		    });
		    
		    // 마커 클러스터러를 생성합니다 
		    var clusterer = new daum.maps.MarkerClusterer({
		        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		        minLevel: 10 // 클러스터 할 최소 지도 레벨 
		    });
		
		    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
		    var markers = data.positions.map(function(position, i) {
		            var marker = new daum.maps.Marker({
		                position : new daum.maps.LatLng(position.lat, position.lng),
		                clickable : true
		            });
		            
		            var iwContent = '<div style="padding:5px;">가게명:' + position.name +'<br/>' + position.address + '</div>', iwRemoveable = true;
		            
		            var infowindow = new daum.maps.InfoWindow({
		            	content : iwContent,
		            	removable : iwRemoveable
		            });
		            
		            daum.maps.event.addListener(marker, 'click', function() {
		                // 마커 위에 인포윈도우를 표시합니다
		                infowindow.open(map, marker);      
		          	});
					
		            return marker;
		    });
		    
		
		    daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
		        // 현재 지도 레벨에서 1레벨 확대한 레벨
		        var level = map.getLevel()-1;
		
		        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
		        map.setLevel(level, {anchor: cluster.getCenter()});
		    });
		    clusterer.addMarkers(markers);
		}
	
	</script>
</html>