<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-07
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8"/>
<meta http-equiv="x-ua-compatible" content="ie=edge"/>
<meta name="description" content=""/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="shortcut icon" type="image/x-icon" href="../../../resources/assets/images/favicon.svg"/>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/animate.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/tiny-slider.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/main.css"/>
    <title>로그인</title>
</head>
<body>
<div class="preloader">
    <div class="preloader-inner">
        <div class="preloader-icon">
            <span></span>
            <span></span>
        </div>
    </div>
</div>
<section class="login registration section">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-12">
                <div class="form-head">
                    <h4 class="title">로그인</h4>
                    <form id="memberSignInForm" name="memberSignInForm">
                        <div class="form-group">
                            <label>이메일</label>
                            <input id="memberEmail" name="memberEmail" type="email" class="border border-primary" onblur="checkDuplicateEmail()">
                            <span id="emailNotice"></span>
                        </div>
                        <div class="form-group">
                            <label>비밀번호</label>
                            <input id="memberPassword" name="memberPassword" type="password" class="border border-primary" onblur="checkPassword()" >
                            <span id="pwNotice"></span>
                        </div>
                        <div class="button">
                            <input id="memberSignIn" name="memberSignIn" type="button" class="btn" onclick="requestSignIn()" value="로그인">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
<script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/assets/js/wow.min.js"></script>
<script src="../../../resources/assets/js/tiny-slider.js"></script>
<script src="../../../resources/assets/js/glightbox.min.js"></script>
<script src="../../../resources/assets/js/main.js"></script>
<script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
<script>
    const requestSignIn = () => {
        // 로그인 버튼 비활성화
        $("#memberSignIn").prop("disabled", true);

        $.ajax({
            type:"post",
            url:"/member/sign-in",
            data:{
                memberEmail:$('#memberEmail').val(),
                memberPassword:$('#memberPassword').val()
            },
            success:(result)=>{
                if(result == "success"){
                    console.log(result);
                    location.href = "../board/boardList";
                }else if("fail"){
                    console.log(result);
                    $('#memberEmail').attr('value', '');
                    $('#memberPassword').attr('value', '');
                    alert('아이디 또는 비밀번호가 맞지 않습니다.');
                    // 로그인 버튼 활성화
                    $("#memberSignIn").prop("disabled", false);
                }
            },
            error:()=>{
                alert("로그인에 실패하였습니다.");
            }
        });
    }
</script>
</html>
