<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9b168a84b11a47a30f09a2898cf4b5da&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- Bootstrap CSS 포함 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
  integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<title>간단한 지도 표시하기</title>
</head>
<body>
<div style="width:70%; margin: auto;">
	
	<div class="post-form mt-3 mb-3">
	<label for="postLoc" class="post-label">주 소</label>
		<div class="post-search">
			<!-- 검색창 -->
			<input name="postLoc" id="postLoc" class="form-control" placeholder="주소를 입력해주세요.">
			<input id="submit" type="button" value="주소검색" class="btn btn-primary mt-2">
		</div>
		<!-- 검색어에 대한 응답 출력 -->
		<div id="resultContainer"></div>
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
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.3595704, 127.105399), // 지도의 초기 중심 좌표 설정
        level: 3 // 초기 줌 레벨 설정
    };

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: map.getCenter() 
}); 
marker.setMap(map);

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 버튼 클릭 시 주소 검색 및 마커 이동
$('#submit').on('click', function() {
    var address = $('#postLoc').val(); // 입력된 주소 가져오기
    if (!address) {
        alert("주소를 입력하세요.");
        return;
    }

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);

            // 마커를 결과값으로 받은 위치로 이동시킵니다
            marker.setPosition(coords);

            // 정보 창 생성 및 표시
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;">' + result[0].road_address.address_name + '</div>'
            });
            infowindow.open(map, marker);

            // 검색된 주소와 좌표를 테이블에 추가
            $('#mapList').append('<tr><td>' + result[0].road_address.address_name + '</td><td>' + result[0].y + '</td><td>' + result[0].x + '</td></tr>');
        } else {
            alert('주소 검색에 실패하였습니다.');
        }
    });
});

// 지도를 클릭하면 클릭한 위치에 마커를 표시합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    var latlng = mouseEvent.latLng; 

    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);

    // 정보 창 생성 및 표시
    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="padding:5px;">Latitude: ' + latlng.getLat() + '<br>Longitude: ' + latlng.getLng() + '</div>'
    });
    infowindow.open(map, marker);

    // 클릭한 위치의 좌표를 테이블에 추가
    $('#mapList').append('<tr><td>클릭한 위치</td><td>' + latlng.getLat() + '</td><td>' + latlng.getLng() + '</td></tr>');
});

// Geolocation API를 사용하여 사용자의 현재 위치를 가져옴
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
        var lat = position.coords.latitude,
            lon = position.coords.longitude;

        var locPosition = new kakao.maps.LatLng(lat, lon);

        // 지도 중심을 사용자 위치로 이동
        map.setCenter(locPosition);
        
        // 마커를 사용자 위치로 이동
        marker.setPosition(locPosition);

        // 정보 창 생성 및 표시
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="padding:5px;">현재 위치</div>'
        });
        infowindow.open(map, marker);
    }, function() {
        var center = map.getCenter();
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="padding:5px;">Geolocation failed!</div>'
        });
        infowindow.open(map, center);
    });
} else {
    var center = map.getCenter();
    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="padding:5px;">Geolocation not supported</div>'
    });
    infowindow.open(map, center);
}


</script>
</body>
</html>
