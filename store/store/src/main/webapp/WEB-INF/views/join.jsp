<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="utf-8">
        <!-- meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"/ -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>회원가입</title>
        <!-- Bootstrap -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
        <script src="http://code.jquery.com/jquery.js"></script>

        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>

<body>
     <div class="container"><!-- 좌우측의 공간 확보 -->
            <!-- 헤더 들어가는 부분 -->
           
            <div class="row">
                <p></p>
                <div class="col-md-12">
                    <small>
                    <a href="/">로그인</a></a>
                    </small>
                </div>
            </div>
            <!--// 헤더 들어가는 부분 -->
            <!-- 모달창 -->
            <div class="modal fade" id="defaultModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">알림</h4>
                        </div>
                        <div class="modal-body">
                            <p class="modal-contents"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            <!--// 모달창 -->
            <hr/>
            <!-- 본문 들어가는 부분 -->
                
       <form action="/join" class="validation-form" novalidate method="post" onsubmit="return submitcheck(event)">

    <div class="form-group">
        <label for="inputId" class="col-lg-2 control-label">아이디</label>
        <div class="col-lg-10">
            <input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="아이디(특수문자,공백 불가)"/>      
            <input class="btn btn-primary" type="button" value="중복 확인" onclick="idOverlap()"/>
        </div>
    </div>
     <font id = "result" size = "2"></font>
    
    <div class="form-group">
        <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
        <div class="col-lg-10">
            <input type="password" class="form-control" id="userPw" name="userPw" data-rule-required="true" placeholder="" value="" required oninput="PassCheck()">
        </div>
    </div>
    <div class="form-group" id="divPasswordCheck">
        <label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
        <div class="col-lg-10">
            <input type="password" class="form-control" id="confirmPw" data-rule-required="true" placeholder="패스워드 확인" maxlength="30" oninput="PassCheck()">
        </div>
    </div>
    <div style="color: red; display: none" id="BadPass">
        *비밀번호가 일치하지 않습니다.
    </div>
    <div style="color: green; display: none" id="GoodPass">
        *비밀번호가 일치합니다.
    </div>
    <div class="form-group" id="divName">
        <label for="inputName" class="col-lg-2 control-label">이름</label>
        <div class="col-lg-10">
            <input type="text" class="form-control onlyHangul" id="name" data-rule-required="true" placeholder="한글만 입력 가능합니다." maxlength="15">
        </div>
    </div>
    <div class="form-group">
        <div class="col-lg-offset-2 col-lg-10">
            <input class="btn btn-primary" type="submit" value="회원가입">      
        </div>
    </div>
	</form>
            </div>

  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script>
  
  
  let idcheck = null; // null로 초기화하여 중복 확인 버튼을 눌렀는지 체크
  function submitcheck(event) {
	    if (idcheck == null) { // 중복 확인 버튼이 눌리지 않은 경우
	        alert("아이디 중복 확인을 해주세요.");
	        return false;
	    }
	    if (idcheck == true) { // 중복된 아이디인 경우
	        alert("아이디가 중복됩니다. 다시 입력해주세요.");
	        return false;
	    } else { // 사용 가능한 아이디인 경우
	        alert("회원 가입이 완료되었습니다!");
	        return true; // 폼 제출 진행
	    }
	}


  function PassCheck() {
      var password = document.getElementById("userPw").value;
      var confirmPassword = document.getElementById("confirmPw").value;
      var badPassMsg = document.getElementById("BadPass");
      var goodPassMsg = document.getElementById("GoodPass");

      if (password && confirmPassword) { // 두 필드가 모두 입력되었을 때만 체크
          if (password === confirmPassword) {
              badPassMsg.style.display = "none";
              goodPassMsg.style.display = "block";
          } else {
              badPassMsg.style.display = "block";
              goodPassMsg.style.display = "none";
          }
      } else { // 둘 중 하나라도 비어 있으면 메시지 숨김
          badPassMsg.style.display = "none";
          goodPassMsg.style.display = "none";
      }
  }
  
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

   
        }, false);
      });
    }, false);
    
    
    function idOverlap() {
        var userEmail = $("#userEmail").val();
        var special = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
        if (userEmail.search(/\W|\s/g) > -1) {
            $('#result').html('특수문자 또는 공백이 입력되었습니다.').css('color', 'red');
        } else {
            if (userEmail.trim().length != 0) {
                $.ajax({
                    url: "/idCheck",
                    type: "POST",
                    async: false,
                    dataType: "JSON", // 서버에서 반환하는 데이터 타입 
                    data: { "userEmail": userEmail }, // 서버에 보내는 데이터 타입 
                    success: function(boolean) {    
                        if (boolean == true) {
                            alert("아이디가 중복되었습니다.");
                            idcheck = true;
                        } else {
                            alert("사용 가능한 아이디입니다.");
                            idcheck = false;
                        }            
                        $('#result').text('');
                    },
                    error: function(error) {
                        alert("아이디를 입력해주세요.");
                    }        
                });
            } else {
                alert("아이디를 입력해주세요");
            }
        }
    }
 
  
    
  </script>
  
   <hr/>
            <!-- 푸터 들어가는 부분 -->       
            <div>
                <p class="text-center">
                    <small><strong>Store</strong></small><br>
                    <small>대표 : 최현식,김진영 ㆍ 주소 :  사거리 ㆍ 사업자등록번호:123-12-12345 ㆍ 전화 : 02-123-1234</small><br>
                    <small>Copyrightⓒ test.com All rights reserved.</small>
                </p>
            </div>
            <!--// 푸터 들어가는 부분 -->
        </div>
</body>

</html>