<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>영화정보</title>
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
				  alert("영화정보를 검색합니다."); 
				  let txt = $("#txt").val();
				  
				  $.ajax({
					  url:"/layout/searchScreen",
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
	</head>
	<body>
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