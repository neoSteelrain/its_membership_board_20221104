<%--
  Created by IntelliJ IDEA.
  User: steelrain
  Date: 2022-11-05
  Time: 오후 3:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="../../../resources/assets/images/favicon.svg" />
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../../resources/assets/css/LineIcons.2.0.css" />
    <link rel="stylesheet" href="../../../resources/assets/css/animate.css" />
    <link rel="stylesheet" href="../../../resources/assets/css/tiny-slider.css" />
    <link rel="stylesheet" href="../../../resources/assets/css/glightbox.min.css" />
    <link rel="stylesheet" href="../../../resources/assets/css/main.css" />
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
                        <h4 class="title">회원가입</h4>
                        <form id="memberSignUpForm" name="memberSignUpForm">
                            <div class="form-group">
                                <label>이름</label>
                                <input id="memberName" name="memberName" type="text" class="border border-primary" onblur="checkName()">
                                <span id="nameNotice"></span>
                            </div>
                            <div class="form-group">
                                <label>이메일</label>
                                <input id="memberEmail" name="memberEmail" type="email" class="border border-primary" onblur="checkDuplicateEmail()">
                                <span id="emailNotice"></span>
                            </div>
                            <div class="form-group">
                                <label>전화번호</label>
                                <input id="memberMobile" name="memberMobile" type="text" class="border border-primary" onblur="checkMobile()" >
                                <span id="mobileNotice"></span>
                            </div>
                            <div class="form-group">
                                <label>비밀번호</label>
                                <input id="memberPassword" name="memberPassword" type="password" class="border border-primary" onblur="checkPassword()" >
                                <span id="pwNotice"></span>
                            </div>
                            <div class="button">
                                <input id="memberSignUp" name="memberSignUp" type="button" class="btn" onclick="requestSignUp()">회원가입</input>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-6 col-12">
<%--                    <div class="p-3 border bg-light">Custom column padding</div>--%>
                    <div class="row" gx-5>
                        <div class="col">
                            <div class="p-3 border">
                                <img id="previewProfile" src="../../../resources/assets/images/default-profile.jpg" >
                            </div>
                            <form id="memberProfileForm" name="memberProfileForm">
                                <input id="memberProfile" class="file-upload" type="file" accept="image/*" onchange="showProfile(this)" />
                            </form>
                        </div>
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
        /*
        form 태그가 2개 있어서 그런지 document.form.submit 함수가 먹히지 않는다.
        일단 ajax로 fordata 만들어서 해보자.
         */
        // MemberDTO 에 매핑되로록 키값을 넣어준다.
        const requestSignUp = () => {
            let signUpFrmData = new FormData();
            signUpFrmData.append("memberName", $('#memberName').val());
            signUpFrmData.append("memberEmail", $('#memberEmail').val());
            signUpFrmData.append("memberMobile", $('#memberMobile').val());
            signUpFrmData.append("memberPassword", $('#memberPassword').val());
            // 디폴트이미지인 경우 files[0] 에는 값이 없다.
            //signUpFrmData.append("profileFile", $('#memberProfile').prop('files')[0])
            // console.log(signUpFrmData.get("memberName"));
            // 회원가입 버튼 비활성화
            $("#memberSignUp").prop("disabled", true);

            $.ajax({
                type:"post",
                url:"/member/sign-up",
                data:{signUpFrmData},
                success:function (result){
                    console.log(result);
                },
                error:function (){

                }
            });

            // $.ajax({
            //     type:"post",
            //     enctype: "multipart/form-data",
            //     url:"/member/sign-up",
            //     data:{signUpFrmData},
            //     data:{
            //         memberName : $('#memberName').val(),
            //         memberEmail : $('#memberEmail').val(),
            //         memberMobile : $('#memberMobile').val(),
            //         memberPassword : $('#memberPassword').val(),
            //         profileFile : $('#memberProfile').prop('files')[0]
            //     },
            //     processData:false,
            //     contentType:false,
            //     success:function (result){
            //         console.log(result);
            //         // 회원가입 버튼 활성화
            //         $("#memberSignUp").prop("disabled", false);
            //     },
            //     error:function (e) {
            //         console.log(e);
            //         $("#memberSignUp").prop("disabled", false);
            //     }
            // });
        }
        const showProfile = (input) => {
            if (input.files == undefined && input.files[0] == undefined) {
                return;
            }

            let reader = new FileReader();
            reader.onload = (e) => {
                $('#previewProfile').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
        const checkName = () => {
            const nameTag = $('#memberName');
            const nameInput = nameTag.val();
            const nameNoticeTag = $('#nameNotice');
            if(nameInput == ""){
                nameNoticeTag.css('color', 'red');
                nameNoticeTag.html('이름은 필수입력입니다.');
            }else{
                nameNoticeTag.css('color', 'white');
                nameNoticeTag.html('');
            }
        }
        const checkPassword = () => {
            const passwordTag = $('#memberPassword');
            const pwInput = passwordTag.val();
            const pwNoticeTag = $('#pwNotice');
            const pwRegex = /^[A-Za-z\d\[\]\{\}\/\(\)\.\?\<\>!@#$%^&*=+-]{6,18}$/;
            if(pwInput != "" && !pwRegex.test(pwInput)) {
                pwNoticeTag.css('color', 'red');
                pwNoticeTag.html('비밀번호는 영문대,소문자,숫자,특수기호 조합으로 6-18자 입니다.');
                passwordTag.val('');
                passwordTag.focus();
            }else{
                pwNoticeTag.css('color', 'red');
                pwNoticeTag.html('');
            }
        }
        const checkMobile = () => {
            const mobileInput = $('#memberMobile').val();
            const mobileNoticeTag = $('#mobileNotice');
            const mobilRegex = /^\d{2,3}-\d{3,4}-\d{3,4}$/;
            if( mobileInput != "" && !mobilRegex.test(mobileInput)){
                mobileNoticeTag.css('color', 'red');
                mobileNoticeTag.html('유효하지 않은 전화번호 형식입니다.');
            }else{
                mobileNoticeTag.css('color', 'white');
                mobileNoticeTag.html('');
            }
        }
        const checkDuplicateEmail = () => {
            const emailInput = $('#memberEmail').val();
            const emailNoticeTag = $('#emailNotice');
            //const emailRegex = /^[A-Za-z\d]@[A-Za-z\d].[A-Za-z]|.[A-Za-z]$/;
            // console.log(emailRegex.test('test@test.co.kr'));
            if(emailInput == "") {
                emailNoticeTag.css('color', 'red');
                emailNoticeTag.html('이메일 주소는 필수입력입니다')
                $('#memberEmail').focus();
                return;
            }
            $.ajax({
                type:"get",
                url:"/member/checkDuplicatedEmail",
                data:{
                    email: emailInput
                },
                success:function (result){
                    if(result == "yes"){
                        emailNoticeTag.css('color', 'red');
                        emailNoticeTag.html('중복된 이메일입니다.')
                    }else if(result == "no"){
                        emailNoticeTag.css('color', 'green');
                        emailNoticeTag.html('사용가능한 이메일입니다.')
                    }
                },
                error:function (){

                }
            });
        }
    </script>
</html>
