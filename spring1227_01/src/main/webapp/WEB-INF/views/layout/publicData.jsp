<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공공데이터</title>
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
				  alert("공공데이터를 검색합니다."); 
				  let txt = $("#txt").val();
				  
				  $.ajax({
					  url:"/layout/searchData",
					  type:"get",
					  data:{"txt":txt},
					  dataType:"json",
					  success:function(data){
						  alert("성공");
						  console.log("전체데이터 : "+data);
						  let iarr = data.response.body.items.item;
						  //console.log("iarr[0].galTitle 데이터 : "+iarr[0].galTitle);
						  let hdata="";
						  for(let i=0;i<iarr.length;i++){
						  hdata += '<tr>';
						  hdata += '<td>'+ iarr[i].galContentId +'</td>';
						  hdata += '<td>'+ iarr[i].galTitle +'</td>';
						  hdata += '<td>'+ iarr[i].galCreatedtime +'</td>';
						  hdata += '<td>'+ iarr[i].galPhotographyLocation +'</td>';
						  hdata += '<td>'+ iarr[i].galPhotographer +'</td>';
						  hdata += '<td>'+ iarr[i].galWebImageUrl +'</td>';
						  hdata += '<td><img src="'+ iarr[i].galWebImageUrl +'"></td>';
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
		   <h1>공공데이터 정보</h1>
		   <input type="text" name="txt" id="txt">
		   <button type="button" id="btn">검색</button>
		   <br><br>
		   <div id="body">
		     <table>
		       <colgroup>
		         <col width="8%">
		         <col width="18%">
		         <col width="11%">
		         <col width="16%">
		         <col width="15%">
		         <col width="23%">
		         <col width="9%">
		       </colgroup>
		       <thead>
			       <tr>
			         <th>번호</th>
			         <th>제목</th>
			         <th>촬영일</th>
			         <th>촬영장소</th>
			         <th>촬영자</th>
			         <th>URL</th>
			         <th>사진</th>
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