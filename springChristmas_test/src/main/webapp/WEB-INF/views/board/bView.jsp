<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <title>뷰페이지</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
  <link rel="stylesheet" href="../css/style.css">
  <link rel="stylesheet" href="../css/read.css">
</head>
<body>
<section>
    <h1>NOTICE</h1>
	<form action="" id="bFrm" name="bFrm" method="post">
	<input type="hidden" name="bno" value="${map.bdto.bno}">
	<table>
      <colgroup>
        <col width="15%">
        <col width="50%">
        <col width="15%">
        <col width="20%">
       </colgroup>
      <tr>
      	<th><strong>글번호</strong></th>
        <th colspan="3">${map.bdto.bno}</th>
      </tr>
      <tr>
      	<td><strong>제목</strong></td>
        <td colspan="3">${map.bdto.btitle}</td>
      </tr>
      <tr>
        <td><strong>작성자</strong></td>
        <td>${map.bdto.id}</td>
        <td><strong>조회수</strong></td>
        <td>${map.bdto.bhit}</td>
      </tr>
      <tr>
        <td colspan="4" class="article">${map.bdto.bcontent}</td>
      </tr>
      <tr>
      	<td><strong>파일이름</strong></td>
        <td colspan="3">${map.bdto.bfile}</td>
      </tr>
      <c:if test="${map.bdto.bfile!=null}">
      <tr>
      	<td><strong>이미지</strong></td>
        <td colspan="3"><img src="/upload/${map.bdto.bfile}"></td>
      </tr>
      </c:if>
      <c:if test="${map.bdto.bfile==null}">
      <tr>
      	<td><strong>이미지</strong></td>
        <td colspan="3">이미지가 존재하지 않습니다.</td>
      </tr>
      </c:if>
      <c:if test="${map.nextdto.bno!=null}">
      <tr>
      	<td><strong>다음글</strong></td>
        <td colspan="3"><a href="bView?bno=${map.nextdto.bno}">${map.nextdto.btitle}</a></td>
      </tr>
      </c:if>
      <c:if test="${map.nextdto.bno==null}">
      <tr>
      	<td><strong>다음글</strong></td>
        <td colspan="3">다음글이 존재하지 않습니다.</td>
      </tr>
      </c:if>
      <c:if test="${map.prevdto.bno!=null}">
      <tr>
      	<td><strong>이전글</strong></td>
        <td colspan="3"><a href="bView?bno=${map.prevdto.bno}">${map.prevdto.btitle}</a></td>
      </tr>
      </c:if>
      <c:if test="${map.prevdto.bno==null}">
      <tr>
      	<td><strong>이전글</strong></td>
        <td colspan="3">이전글이 존재하지 않습니다.</td>
      </tr>
      </c:if>
    </table>
	<script>
		$(function(){
			$(".delBtn").click(function(){
				if(confirm("게시글을 삭제하시겠습니까?")){
					$("#bFrm").attr("action","bDelete").submit();
				};
			});
			$(".updateBtn").click(function(){
				alert("수정페이지로 이동합니다.");
				$("#bFrm").attr("action","bUpdate").submit();
			});
			
			$(".replyBtn").click(function(){
				if(confirm("답글을 추가하시겠습니까?")){
					$("#bFrm").attr("action","bReply").submit();//택한 폼의 action 속성을 "bDelete"로 변경합니다
				};
			});
			
		});//jquery
	
	</script>
    <c:if test="${session_id == map.bdto.id}">
    </c:if>
    <c:if test="${session_id != null}">
    </c:if>
    	<a href="bList"><div class="list">목록</div></a>
   	 	<div class="list delBtn" style="cursor:pointer;">삭제</div>
    	<div class="list updateBtn">수정</div>
    	<div class="list replyBtn">답글달기</div>
    </form>
  </section>
</body>
</html>