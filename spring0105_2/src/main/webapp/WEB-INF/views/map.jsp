<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>다음api주소</title>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7ceeb8b6489d35ca143e5666967082fc"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	</head>
	<style>
		* {margin: 0; padding: 0;}
		#map{border: 3px black;}
		#header{width:100%; height:80px;text-align: center;margin-top: 50px;}
		.overlaybox {position:relative;width:500px;height:350px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px;}
		.overlaybox div, ul {overflow:hidden;margin:0;padding:0;}
		.overlaybox li {list-style: none;}
		.overlaybox .boxtitle {color:#fff;font-size:16px;font-weight:bold;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png') no-repeat right 120px center;margin-bottom:8px;}
		.overlaybox .first {position:relative;width:247px;height:136px;background: url('https://images.chosun.com/resizer/VvLEitsEExA9bPWRnUheCmNuKS8=/616x0/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosun/JG6C7OWUIXWJANFCREHCVBHDKQ.jpg') no-repeat;margin-bottom:8px;}
		.first .text {color:#fff;font-weight:bold;}
		.first .triangle {position:absolute;width:300px;height:48px;top:0;left:0;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png') no-repeat; padding:6px;font-size:18px;}
		.first .movietitle {position:absolute;width:100%;bottom:0;background:rgba(0,0,0,0.4);padding:7px 15px;font-size:14px;}
		.overlaybox ul {width:247px;}
		.overlaybox li {position:relative;margin-bottom:2px;background:#2b2d36;padding:5px 10px;color:#aaabaf;line-height: 1;}
		.overlaybox li span {display:inline-block;}
		.overlaybox li .number {font-size:16px;font-weight:bold;}
		.overlaybox li .title {font-size:13px;}
		.overlaybox ul .arrow {position:absolute;margin-top:8px;right:25px;width:5px;height:3px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png') no-repeat;} 
		.overlaybox li .up {background-position:0 -40px;}
		.overlaybox li .down {background-position:0 -60px;}
		.overlaybox li .count {position:absolute;margin-top:5px;right:15px;font-size:10px;}
		.overlaybox li:hover {color:#fff;background:#d24545;}
		.overlaybox li:hover .up {background-position:0 0px;}
		.overlaybox li:hover .down {background-position:0 -20px;}   
		
		
	</style>
	<script>
	 $(function(){
		   $("#btn").click(function(){
			  alert("영화정보를 검색합니다."); 
			  let txt = $("#txt").val();
			  
			  $.ajax({
				  url:"searchScreen",
				  type:"get",
				  data:{"txt":txt},
				  dataType:"json",
				  success:function(data){
					  alert("성공");
					  console.log("전체데이터 : "+data);
					  
					  //-----
					  let iarr = data.boxOfficeResult.dailyBoxOfficeList;
					  //console.log("iarr[0].galTitle 데이터 : "+iarr[0].galTitle);
					  let hdata="";
					  for(let i=0;i<iarr.length;i++){
						  hdata += '<tr>';
						  hdata += '<td>'+ iarr[i].rank +'</td>';
						  hdata += '<td>'+ iarr[i].rankInten +'</td>';
						  hdata += '<td>'+ iarr[i].movieNm +'</td>';
						  hdata += '<td>'+ iarr[i].openDt +'</td>';
						  hdata += '<td>'+ Number(iarr[i].salesAcc).toLocaleString('ko-KR'); +'</td>';
						  hdata += '<td>'+ Number(iarr[i].audiAcc).toLocaleString('ko-KR'); +'</td>';
						  hdata += '<td>영화포스터</td>';
						  hdata += '</tr>';
					  }
					  $("#content").html(hdata);
					  
				  },
				  error:function(){
					  alert("실패");
				  }
				  
			  });
			  
		   });
	   });
	
	
	</script>
	
	
	<body>
		<div id="header"><h1>다음api주소</h1></div>
		<div id="map" style="width:100%;height:400px;"></div>
		<script>
			//제이쿼리 $("map") == 자바스크립트 document.getElementById('map') 내용이 같음
/* 			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
				    mapOption = { 
				        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };
				
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				 
				// 마커를 표시할 위치와 title 객체 배열입니다 
				var positions = [
				    {
				        title: '카카오', 
				        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
				    },
				    {
				        title: '생태연못', 
				        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
				    },
				    {
				        title: '텃밭', 
				        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
				    },
				    {
				        title: '근린공원',
				        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
				    }
				];
				
				// 마커 이미지의 이미지 주소입니다
				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
				    
				for (var i = 0; i < positions.length; i ++) {
				    
				    // 마커 이미지의 이미지 크기 입니다
				    var imageSize = new kakao.maps.Size(24, 35); 
				    
				    // 마커 이미지를 생성합니다    
				    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
				    
				    // 마커를 생성합니다
				    var marker = new kakao.maps.Marker({
				        map: map, // 마커를 표시할 지도
				        position: positions[i].latlng, // 마커를 표시할 위치
				        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				        image : markerImage // 마커 이미지 
				    });
				} */
				
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					    mapOption = { 
					        center: new kakao.maps.LatLng(37.502, 127.026581), // 지도의 중심좌표
					        level: 4 // 지도의 확대 레벨
					    };
		
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
					// 커스텀 오버레이에 표시할 내용입니다     
					// HTML 문자열 또는 Dom Element 입니다 
					var content = '<div class="overlaybox">' +
					    '    <div class="boxtitle">금주 영화순위</div>' +
					    '    <div class="first">' +
					    '        <div class="triangle text">1</div>' +
					    '        <div class="movietitle text">노량: 죽음의 바다</div>' +
					    '    </div>' +
					    '    <ul>' +
					    '        <li class="up">' +
					    '            <span class="number">2</span>' +
					    '            <span class="title">서울의 봄</span>' +
					    '            <span class="arrow up"></span>' +
					    '            <span class="count">2</span>' +
					    '        </li>' +
					    '        <li>' +
					    '            <span class="number">3</span>' +
					    '            <span class="title">아쿠아맨과 로스트 킹덤</span>' +
					    '            <span class="arrow up"></span>' +
					    '            <span class="count">6</span>' +
					    '        </li>' +
					    '        <li>' +
					    '            <span class="number">4</span>' +
					    '            <span class="title">	신차원! 짱구는 못말려 더 무비 초능력 대결전 ~날아</span>' +
					    '            <span class="arrow up"></span>' +
					    '            <span class="count">3</span>' +
					    '        </li>' +
					    '        <li>' +
					    '            <span class="number">5</span>' +
					    '            <span class="title">안녕, 헤이즐</span>' +
					    '            <span class="arrow down"></span>' +
					    '            <span class="count">1</span>' +
					    '        </li>' +
					    '    </ul>' +
					    '</div>';
		
					// 커스텀 오버레이가 표시될 위치입니다 
					var position = new kakao.maps.LatLng(37.49887, 127.026581);  
		
					// 커스텀 오버레이를 생성합니다
					var customOverlay = new kakao.maps.CustomOverlay({
					    position: position,
					    content: content,
					    xAnchor: 0.3,
					    yAnchor: 0.91
					});
		
					// 커스텀 오버레이를 지도에 표시합니다
					customOverlay.setMap(map);
	
		</script>
		
		<div id="main">
		   <h1>영화데이터 정보</h1>
		   <input type="text" name="txt" id="txt">
		   <button type="button" id="btn">검색</button>
		   <br><br>
		   <div id="body">
		     <table>
		       <colgroup>
		         <col width="7%">
		         <col width="7%">
		         <col width="36%">
		         <col width="10%">
		         <col width="15%">
		         <col width="15%">
		         <col width="10%">
		       </colgroup>
		       <thead>
			       <tr>
			         <th>순위</th>
			         <th>전일대비</th>
			         <th>영화제목</th>
			         <th>개봉일</th>
			         <th>누적매출액</th>
			         <th>누적관객수</th>
			         <th>포스터</th>
			       </tr>
		       </thead>
		       <tbody id="content">
			       <tr>
			         <td></td>
			         <td></td>
			         <td></td>
			         <td></td>
			         <td></td>
			         <td></td>
			         <td></td>
			       </tr>
		       </tbody>
		     
		     </table>
		   
		   </div>
	   </div>
		
		
	</body>
</html>