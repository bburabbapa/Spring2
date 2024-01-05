
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글쓰기</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="/css/summernote/summernote-lite.css" rel="stylesheet">
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<!-- <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>  -->
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}

h2 {
	text-align: center;
}

table {
	width: 920px;
	margin: 0 auto;
	text-align: center;
}

th, td {
	height: 40px;
}

td {
	text-align: left;
	padding-left: 30px;
}

input {
	width: 575px;
	height: 30px;
}

div {
	width: 400px;
	height: 60px;
	margin: 12px auto 0;
}

button {
	display: inline-block;
	width: 120px;
	height: 40px;
}

.bcont {
	height: 300px; width: 575px;
}
</style>
<script>
	$(function() {
		$('#summernote').summernote(
				{
					placeholder : 'Hello stand alone ui',
					tabsize : 2,
					height : 120,
					toolbar : [ [ 'style', [ 'style' ] ],
							[ 'font', [ 'bold', 'underline', 'clear' ] ],
							[ 'color', [ 'color' ] ],
							[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
							[ 'table', [ 'table' ] ],
							[ 'insert', [ 'link', 'picture', 'video' ] ],
							[ 'view', [ 'fullscreen', 'codeview', 'help' ] ] ]
				});
	});//제이쿼리

	function fboardBtn() {
		if ($("#btitle").val().length < 2) {
			alert("제목을 두글자 이상 입력하셔야 합니다.");
			$("#btitle").focus();
			return;
		}

		if (confirm("글쓰기를 저장하시겠습니까?")) {
			return fboardFrm.submit();
		}
	}

	function cancelBtn() {
		if (confirm("글쓰기를 취소하시겠습니까?"))
			location.href = "fboardList.do?page=${param.page}&searchTitle=${searchTitle}&searchWord=${searchWord}";
	}
</script>
</head>
<body>

	<h2>자유게시판 글쓰기</h2>
	<form action="doFboardWrite.do" method="post" name="fboardFrm"
		enctype="multipart/form-data">
		<table>
			<colgroup>
				<col width="30%">
				<col width="70%">
			</colgroup>
			<input type="hidden" name="page" value="${param.page}">
			<input type="hidden" name="searchTitle" value="${searchTitle}">
			<input type="hidden" name="searchWord" value="${searchWord}">
			<tr>
				<th>제목</th>
				<td><input type="text" name="btitle" id="btitle"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="id" id="id" value="aaa" readonly></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea id="summernote" name="editordata" class="bcont"></textarea>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="bfile" id="bfile"></td>
			</tr>

		</table>
		<div>
			<button type="button" onclick="fboardBtn()">글쓰기</button>
			<button type="button" onclick="cancelBtn()">취소</button>
		</div>
	</form>

</body>
</html>