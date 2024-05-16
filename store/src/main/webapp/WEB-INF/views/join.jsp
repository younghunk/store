<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">


  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

  <style>
    body {
      min-height: 100vh;

      background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
      background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
    }

    .input-form {
      max-width: 680px;

      margin-top: 80px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
  </style>
</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        <form action="/join" class="validation-form" novalidate method="post" id="check2" onsubmit="return submitcheck()">
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="name">아이디</label>
              <input type="text" class="form-control" id="userEmail"  name="userEmail"  placeholder="" value="" required>
              <div class="invalid-feedback">
                이름을 입력해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="nickname">이름</label>
              <input type="text" class="form-control" id="userName" name="userName" placeholder="" value="" required>
              <div class="invalid-feedback">
                별명을 입력해주세요.
              </div>
            </div>
          </div>
             <div class="mb-3">
            <label for="email">비밀번호</label>
            <input type="text" class="form-control" id="userPw" name="userPw" required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>
             <div class="mb-3">
            <label for="email">비밀번호 확인</label>
            <input type="text" class="form-control" id="confirmPw" required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>
           <div style="color: red; display: none" id="BadPass" onchange="PassCheck()">
          *비밀번호가 일치하지 않습니다.
        </div>
        <div style="color: green; display: none" id="GoodPass" onchange="PassCheck()">
          *비밀번호가 일치합니다.
        </div>


          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div>
          <div class="mb-4"></div>
            <input style="color: black;" class="btn btn-primary btn-lg btn-block" type="submit" value="회원가입" id="check2"/>
      
        </form>
      </div>
    </div>

  </div>
  <script>
  
  function PassCheck() {
      var password = document.getElementById("userPw").value;
      var confirmPassword = document.getElementById("confirmPw").value;
      var badPassMsg = document.getElementById("BadPass");
      var goodPassMsg = document.getElementById("GoodPass");

      if (password === confirmPassword) {
        badPassMsg.style.display = "none";
        goodPassMsg.style.display = "block";
      } else {
        badPassMsg.style.display = "block";
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

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
    
    
  
    
  </script>
</body>

</html>