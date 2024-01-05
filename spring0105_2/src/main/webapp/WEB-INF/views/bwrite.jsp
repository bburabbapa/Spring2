<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Pages - write</title>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/write.css">
  <script src="/js/summernote-lite.js"></script> 
  <script src="/js/summernote-ko-KR.js"></script> 
  <link rel="stylesheet" href="/css/summernote-lite.css">
  <script>
    $(function(){
    	//1. 여기 아래 부분 먼저 추가
    	$('#summernote').summernote({
    		  height: 300,                 // 에디터 높이
    		  minHeight: 300,           // 에디터 최소 높이
    		  maxHeight: 300,          // 에디터 최대 높이
    		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
    		  lang: "ko-KR",	         // 한글 설정
    		  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
    		  toolbar: [
  			    // [groupName, [list of button]]
  			    ['fontname', ['fontname']],
  			    ['fontsize', ['fontsize']],
  			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
  			    ['color', ['forecolor','color']],
  			    ['table', ['table']],
  			    ['para', ['ul', 'ol', 'paragraph']],
  			    ['height', ['height']],
  			    ['insert',['picture','link','video']],
  			    ['view', ['codeview', 'fullscreen', 'help']]
  			  ],
  			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
  			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
  			callbacks: { //3. 여기 부분이 이미지를 첨부하는 부분
  			   onImageUpload : function(files) {
  			   //하단 함수 호출
  			   uploadImage(files[0],this); //이미지 업로드 호출 - 이미지파일,현재위치값
  			  },
  			  onPaste: function (e) {
  			    var clipboardData = e.originalEvent.clipboardData;
  			    if (clipboardData && clipboardData.items &&    
  			    clipboardData.items.length) {
  			        var item = clipboardData.items[0];
  			if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
  			   e.preventDefault();
  			        }
  			    }
  			  }
  			} //callbacks
    	});//summernote
    });//jquery
    
    //2. ajax으로 파일을 서버에 전송하는 부분
    function uploadImage(file,this_location){ //매개변수 - file:이미지파일,현재위치값
    	var fdata = new FormData(); //ajax에서 전송할때 form형태로 전송
    	fdata.append("file",file); //file이미지를 첨부
    	$.ajax({
    		url:"/uploadImage",
    		type:"post",
    		dataType:"text", //파일을 받는형태 - text,json,xml...
    		data:fdata,
    		cache:false,       //남아 있는 데이터 정보 새롭게 정리
    		contentType:false, //파일을 보내는형태 default값 : application/x-www-form-urlencoded
    		processData:false, //query String 형태로 보내지 않음. http://localhost:8000/bno=1&
    		enctype:"multipart/form-data",
    		success:function(data){ //서버에 가서 이미지를 저장후 파일이름과 저장위치를 리턴
    			// data : /upload/4857947984_1.jpg
    			$(this_location).summernote('editor.insertImage',data); //js에서 함수호출해서 위치값에 데이터를 넣어줌.
    		},
    		error:function(){
    		    alert("실패");
    		}
    	});//ajax
    	
    }//uploadImage
    
    
    
  </script>
</head>

<body>
  <header>
    <ul>
      <li>회원가입</li> <span>|</span>
      <li>로그인</li> <span>|</span>
      <li>고객행복센터</li> <span>|</span>
      <li>배송지역검색</li> <span>|</span>
      <li>기프트카드 등록</li>
    </ul>
  </header>

  <nav>
    <div class="logo"></div>

    <div id="search">
      <div class="search"></div><br>
      <span>메뉴찾기</span>
    </div>

    <div id="cart">
      <div class="cart"></div><br>
      <span>장바구니</span>
    </div>

    <div class="nav-menu">
      <ul>
        <li>COOKIT소개</li>
        <li>COOKIT 메뉴</li>
        <li>리뷰</li>
        <li>이벤트</li>
        <li>MY쿡킷</li>
      </ul>  
    </div>
  </nav>

  <section>
    <h1>관리자 글쓰기</h1>
    <hr>
	<!-- action name 수정 및 enctype추가  -->
    <form action="bwrite" name="writeFrm" method="post" enctype="multipart/form-data">
      <table>
        <colgroup>
          <col width="15%">
          <col width="85%">
        </colgroup>
        
        <tr>
          <th>작성자</th>
          <td>
            <input type="text" name="id" value="bbb">
          </td>
        </tr>
        <tr>
          <th>제목</th>
          <td>
            <input type="text" name="btitle">
          </td>
        </tr>
        <tr>
          <th>내용</th>
          <td>
            <textarea name="bcontent" id="summernote" cols="50" rows="10"></textarea> <!-- id추가 -->
          </td>
        </tr>
        <tr>
          <th>이미지 표시</th>
          <td>
            <input type="file" name="file" id="file">
          </td>
        </tr>
      </table>
      <hr>
      <div class="button-wrapper">
        <button type="submit" class="write button">작성완료</button>
        <button type="button" class="cancel button" onclick="javascript:location.href='/blist'">취소</button>
      </div>
    </form>

  </section>

  <footer>
    <div class="wrapper">
      <div class="footer-left">
        <div class="footer-logo"></div>
        <div class="copyright">© COOKIT ALL RIGHTS RESERVED</div>
      </div>
  
      <div class="footer-center">
        <ul class="footer-nav">
          <li class="first-list">이용약관</li>
          <li class="green">개인정보처리 방침</li>
          <li>법적고지</li>
          <li>사업자정보 확인</li>
        </ul>
  
        <ul class="footer-info">
          <li class="first-list">씨제이제일제당(주)</li>
          <li>대표이사 : 손경식,강신호,신현재</li>
          <li>사업자등록번호 : 104-86-09535</li>
          <li class="first-list">주소 : 서울 중구 동호로 330 CJ제일제당 센터 (우) 04560</li>
          <li>통신판매업신고 중구 제 07767호</li>
          <li class="first-list">개인정보보호책임자 : 조영민</li>
          <li>이메일 : cjon@cj.net</li>
          <li>호스팅제공자 : CJ올리브네트웍스㈜</li>
        </ul>
  
        <div id="check">고객님은 안전거래를 위해 현금등으로 결제시 LG U+ 전자 결제의 매매보호(에스크로) 서비스를 이용하실 수 있습니다. <span class="check">가입 사실 확인</span></div>
      </div>
  
      <div class="footer-right">
        <div id="shortcut">
          <span>CJ그룹계열사 바로가기</span>
          <div class="shortcut"></div>
        </div>
  
        <div class="call">고객행복센터 1668-1920</div>
        <div class="inquery">1:1 문의</div>
      </div>
  
    </div>
  </footer>
</body>
</html>