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
    <title>회원가입</title>

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
                                <input id="memberSignUp" name="memberSignUp" type="button" class="btn" onclick="requestSignUp()" value="회원가입">
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
        - 일단 값이 Controller로 잘 넘어가는 것은 확인했지만 뭔가 꺼림직하다.
        !중요
        - memberProfile : 사용자 프로필이미지 처리
        디폴트이미지인 경우 $('#memberProfile').prop('files')[0] 에는 값이 없다. undefined 으로 나옴
        undefined 상태로 formdata에 실어서 보내면 400 응답코드 반환됨
        MemberDTO 에서 memberProfile을 @Nullable 으로 해봤지만 똑같은 결과...
        사용자가 프로필 이미지를 선택하지 않고 디폴트 이미지를 선택했다면
        formdata에 memberProfile 속성 자체를 넣지 않아야 한다.

        - TO DO
        spring 에서 jquery ajax 로 formdata에 이미지같은 첨부파일 처리하는 법을 좀더 알아봐야 한다.
        DTO에 정의된 첨부파일을 옵션으로 자동처리해서 키값은 있으면서 값을 null로 넣어도 처리되는 방법이 있을거 같다.
         */
        // MemberDTO 에 매핑되로록 키값을 넣어준다.
        const requestSignUp = () => {
            let signUpFrmData = new FormData();
            signUpFrmData.append("memberName", $('#memberName').val());
            signUpFrmData.append("memberEmail", $('#memberEmail').val());
            signUpFrmData.append("memberMobile", $('#memberMobile').val());
            signUpFrmData.append("memberPassword", $('#memberPassword').val());
            // 프로필이미지 처리
            const profileImgs = $('#memberProfile').prop('files');
            if(profileImgs.length > 0){
                // 프로필이미지는 1개만 선택가능하므로 0번째 값만 읽어온다.
                signUpFrmData.append("profileFile", profileImgs[0]);
            }
            // 회원가입 버튼 비활성화
            $("#memberSignUp").prop("disabled", true);

            $.ajax({
                type:"post",
                enctype: "multipart/form-data",
                url:"/member/sign-up",
                data:signUpFrmData, // 수업시간에 했던 식으로 data:{signUpFrmData} 같이 중괄호 묶으면 에러난다.
                // 아래와 같이 formdata로 넣어주지 않고 바로 키:값으로 넣어주면 Controller에서 전부 null 떨어진다.
                // data:{
                //     memberName : $('#memberName').val(),
                //     memberEmail : $('#memberEmail').val(),
                //     memberMobile : $('#memberMobile').val(),
                //     memberPassword : $('#memberPassword').val(),
                //     profileFile : $('#memberProfile').prop('files')[0]
                // },
                processData:false,
                contentType:false,
                success:function (result){
                    // 회원가입 버튼 활성화
                    $("#memberSignUp").prop("disabled", false);
                    alert("회원가입이 완료되었습니다.");
                    location.href = "/member/sign-in";
                },
                error:function (e) {
                    alert("회원가입이 실패하였습니다.");
                    $("#memberSignUp").prop("disabled", false);
                }
            });
        }
        const showProfile = (input) => {
            if (input.files == undefined && input.files[0] == undefined) {
                return;
            }
            // $( "input[value='Hot Fuzz']" ).next().text( "Hot Fuzz" );
            console.log($("#profileUpload[value='files']"));
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
