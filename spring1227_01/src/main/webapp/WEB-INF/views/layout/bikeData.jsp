<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>따릉이정보</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<style>
		  #main{width:1600px; margin:20px auto; text-align: center; }
		  #body{width:1600px; height:700px; margin:20px auto; border:3px solid black; }
		  table{width:1400px; margin:0 auto; }
		  table,th,td{border:1px solid black; border-collapse: collapse;}
		  th{height:40px; }
		  td{height:35px; }
		  td img{width:50%;}
		</style>
		<script>
		   $(function(){
			   $("#btn").click(function(){
				  alert("따릉이를 검색합니다."); 
				  let txt = $("#txt").val();
				  
				  $.ajax({
					  url:"/layout/searchBike",
					  type:"get",
					  data:{"txt":txt},
					  dataType:"json",
					  success:function(data){
						  alert("성공");
						  console.log(data);
						  let iarr = data.rentBikeStatus.row;
						  let hdata="";
						  for(let i=0;i<iarr.length;i++){
							  hdata += '<tr>';
							  hdata += '<td>'+ iarr[i].rackTotCnt +'</td>';
							  hdata += '<td>'+ iarr[i].stationName +'</td>';
							  hdata += '<td>'+ iarr[i].parkingBikeTotCnt +'</td>';
							  hdata += '<td>'+ iarr[i].shared +'% </td>';
							  hdata += '<td>'+ iarr[i].stationLatitude +'</td>';
							  hdata += '<td>'+ iarr[i].stationLongitude +'</td>';
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
	</head>
	<body>
	   <div id="main">
		   <h1>자전거데이터 정보</h1>
		   <input type="text" name="txt" id="txt">
		   <button type="button" id="btn">검색</button>
		   <br><br>
		   <div id="body">
		     <table>
		       <colgroup>
		         <col width="10%">
		         <col width="25%">
		         <col width="10%">
		         <col width="15%">
		         <col width="20%">
		         <col width="20%">
		       </colgroup>
		       <thead>
			       <tr>
			         <th>거치대개수</th>
			         <th>대여소이름</th>
			         <th>자전거주차총건수</th>
			         <th>거치율</th>
			         <th>위도</th>
			         <th>경도</th>
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
			       </tr>
		       </tbody>
		     
		     </table>
		   
		   </div>
	   </div>
	
	</body>
</html>