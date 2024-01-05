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
  <title>글수정</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="../css/style.css">
  <link rel="stylesheet" href="../css/write.css">
</head>
<body>
<section>
    <h1>게시글수정</h1>
    <hr>

    <form action="doBReply" name="replyFrm" method="post" enctype="multipart/form-data">
      <table>
      <input type="hidden" name="id" value="${map.bdto.id }">
      <input type="hidden" name="bgroup" value="${map.bdto.bgroup }">
      <input type="hidden" name="bstep" value="${map.bdto.bstep }">
      <input type="hidden" name="bindent" value="${map.bdto.bindent }">
        <colgroup>
          <col width="15%">
          <col width="85%">
        </colgroup>
        <tr>
          <th>작성자</th>
          <td>${map.bdto.id }</td>
        </tr>
        <tr>
          <th>제목</th>
          <td>
            <input type="text" name="btitle" value="<답변> ${map.bdto.btitle }">
          </td>
        </tr>
        <tr>
          <th>내용</th>
          <td>
<textarea name="bcontent" cols="50" rows="10">

---------------------------
[답글]
${map.bdto.bcontent }
</textarea>
          </td>
        </tr>
        <tr>
          <th>이미지 표시</th>
          <td>
            <input type="file" name="files" id="file">
          </td>
        </tr>
      </table>
      <hr>
      <div class="button-wrapper">
        <button type="submit" class="write">답변완료</button>
        <button type="button" class="cancel" onclick="javascript:location.href='list.do'">취소</button>
      </div>
    </form>

  </section>

</body>
</html>