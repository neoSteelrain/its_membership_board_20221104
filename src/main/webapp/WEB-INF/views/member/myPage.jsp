<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-10
  Time: 오후 4:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/main.css" />
    <script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
    <script src="../../../resources/assets/js/main.js"></script>
    <title>마이 페이지</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<main role="main" class="container">
    <section style="margin-top: 10px">
        <form id="boardDetailFrm" name="boardDetailFrm">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="memberNameIpt" class="form-label">이름</label>
                    <input type="text" class="form-control" id="memberNameIpt" name="memberNameIpt" value="${memberInfo.memberName}">
                </div>
                <div class="col-md-6">
                    <label for="memberEmailIpt" class="form-label">이메일</label>
                    <input type="text" class="form-control" id="memberEmailIpt" name="memberEmailIpt" readonly value="${memberInfo.memberEmail}">
                </div>
                <div class="col-md-6">
                    <label for="memberMobileIpt" class="form-label">전화번호</label>
                    <input type="text" class="form-control" id="memberMobileIpt" name="memberMobileIpt" value="${memberInfo.memberMobile}">
                </div>
                <div class="col-12">
                    <!-- 회원이 등록한 프로필이미지가 없으면 디폴트 프로필이미지, 있으면 프로필이미지 폴더에서 읽어서 출력 -->
                    <c:choose>
                        <c:when test="${memberInfo.memberProfile != null}">
                            <img alt="" src="${pageContext.request.contextPath}/profile/${memberInfo.memberEmail}-${memberInfo.memberProfile}" class="mr-2 rounded" width="96" height="96">
                        </c:when>
                        <c:otherwise>
                            <img alt="" src="../../../resources/assets/images/default-profile.jpg" class="mr-2 rounded" width="96" height="96">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="p-3 border bg-light"></div>
            <label for="memberPasswordIpt" class="form-label" style="width: 150px">비밀번호</label>
            <input type="text" class="form-control" id="memberPasswordIpt" name="memberPasswordIpt">
            <button type="button" class="btn btn-primary" id="updateMemberBtn" name="updateMemberBtn" onclick="requestMemberPassword()">수정</button>
        </form>
    </section>
</main>
</body>
<script>
    
    const requestMemberPassword = () => {
        const mName = $('#memberNameIpt').val();
        const mPw = $('#memberPasswordIpt');

        if(mName == ""){
            alert("회원의 이름은 반드시 입력해야 합니다.");
            return;
        }
        if(mPw.val() == ""){
            alert("회원의 비밀번호는 반드시 입력해야 합니다.");
            return;
        }
        $("#updateMemberBtn").prop("disabled", true);
        $.ajax({
            type:"post",
            url:"/member/checkMemberPassword",
            // async:false,
            data:{
                pw:mPw.val(),
                id:${memberInfo.id}
            },
            success:(result)=>{
                updateMemberInfo(result);
            },
            error:()=>{
                alert("비밀번호 확인도중 에러가 발생하였습니다.");
            }
        });
    }

    // $("#updateMemberBtn").on("click", function (){
    //     const mName = $('#memberName').val();
    //     const mPwTag = $('#memberPasswordIpt');
    //     console.log(mName);
    //     console.log(mPwTag.val());
    // });

    const updateMemberInfo = (oKparam) => {
        if(oKparam !== "ok"){
            alert("비밀번호가 맞지 않습니다.");
            return;
        }

        $.ajax({
            type:"post",
            url:"/member/updateMemberInfo",
            data:{
                id : ${memberInfo.id},
                memberName : $('#memberNameIpt').val(),
                memberMobile : $("#memberMobileIpt").val()
            },
            success:(result)=>{
                if(result == "success"){
                    alert("회원정보를 수정했습니다.");
                    location.href = "/member/myPage?memberId="+${memberInfo.id};
                }else{
                    alert("회원정보를 수정하지 못했습니다.");
                    $("#updateMemberBtn").prop("disabled", false);
                }
            },
            error:()=>{
                alert("회원정보 수정도중 에러가 발생하였습니다.");
                $("#updateMemberBtn").prop("disabled", false);
            }
        });
    }
</script>
</html>
