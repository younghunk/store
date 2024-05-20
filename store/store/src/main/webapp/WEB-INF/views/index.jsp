<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=yp5ato10s6&submodules=geocoder"></script>
<!-- Bootstrap CSS 포함 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
  integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<title>간단한 지도 표시하기</title>
</head>
<body>
<div style="width:70%; margin: auto;">
	<div class="search mt-3 mb-3">
		<input id="address" type="text" placeholder="검색할 주소">
		<input id="submit" type="button" value="주소검색">
	</div>
	<div id="map" style="height:800px;"></div>
    
	<div class="mt-3 mb-3">
	<table class="table">
		<thead>
			<tr>
				<th>주소</th>
				<th>위도</th>
				<th>경도</th>
			</tr>    
		</thead>
		<tbody id="mapList"></tbody>
	</table>
	</div>
</div>

<script>
var map = new naver.maps.Map('map', {
	center: new naver.maps.LatLng(37.3595704, 127.105399), // 지도의 초기 중심 좌표 설정
	zoom: 15 // 초기 줌 레벨 설정
});

var marker = new naver.maps.Marker({
	position: new naver.maps.LatLng(37.3595704, 127.105399),
	map: map
});

// 정보 창 생성
var infoWindow = new naver.maps.InfoWindow();

// 성공적으로 위치 정보를 가져왔을 때 호출되는 함수
function onSuccessGeolocation(position) {
	var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);
    
	// 지도의 중심을 사용자의 현재 위치로 설정
	map.setCenter(location); 
	map.setZoom(15);
    
	// 정보 창에 현재 위치 정보를 표시
	infoWindow.setContent('<div style="padding:20px;">' + 'geolocation.getCurrentPosition() 위치' + '</div>');
	infoWindow.open(map, location);
	console.log('Coordinates: ' + location.toString());
}

// 위치 정보를 가져오지 못했을 때 호출되는 함수
function onErrorGeolocation() {
	var center = map.getCenter();
    
	// 정보 창에 에러 메시지와 지도의 중심 좌표를 표시
	infoWindow.setContent('<div style="padding:20px;">' +
		'<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');
	infoWindow.open(map, center);
}

$(document).ready(function() {
	// Geolocation API를 사용하여 사용자의 현재 위치를 가져옴
	if(navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
	} else {
		var center = map.getCenter();
		// Geolocation API가 지원되지 않는 경우
		infoWindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
		infoWindow.open(map, center);
	}

	// 주소 검색 버튼 클릭 시 실행되는 함수
	$('#submit').click(function() {
		var address = $('#address').val(); // 입력된 주소 가져오기
		if (!address) {
			alert("주소를 입력하세요.");
			return;
		}
		naver.maps.Service.geocode({
			address: address
		}, function(status, response) {
			if (status !== naver.maps.Service.Status.OK) {
				return alert('주소 검색에 실패하였습니다.');
			}

			var result = response.v2.addresses[0];
			var location = new naver.maps.LatLng(result.y, result.x);

			// 지도 중심을 검색된 주소의 좌표로 이동
			map.setCenter(location);
			map.setZoom(15);

			// 마커 생성 및 지도에 표시
			var marker = new naver.maps.Marker({
				position: location,
				map: map
			});

			// 정보 창 생성 및 표시
			infoWindow.setContent('<div style="padding:20px;">' + result.roadAddress + '</div>');
			infoWindow.open(map, marker);

			// 검색된 주소와 좌표를 테이블에 추가
			$('#mapList').append('<tr><td>' + result.roadAddress + '</td><td>' + result.y + '</td><td>' + result.x + '</td></tr>');
		});
	});
	
	naver.maps.Event.addListener(map, 'click', function(e) {
		marker.setPosition(e.coord);
	});
	
});
</script>
</body>
</html>
