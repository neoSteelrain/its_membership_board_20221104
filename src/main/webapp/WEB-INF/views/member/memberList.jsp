<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-09
  Time: 오전 8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/main.css" />
    <title>회원목록</title>
    <style>
        body{background:#f5f5f5}
        .text-white-50 { color: rgba(255, 255, 255, .5); }
        .bg-blue { background-color:#00b5ec; }
        .border-bottom { border-bottom: 1px solid #e5e5e5; }
        .box-shadow { box-shadow: 0 .25rem .75rem rgba(0, 0, 0, .05); }
    </style>
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
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<main>
    <section role="main" class="container bootdey.com">
        <div class="d-flex align-items-center p-3 my-3 text-white-50 bg-blue rounded box-shadow">
            <img class="mr-3" src="../../../resources/assets/images/default-profile.jpg" alt="" width="48" height="48">
            <div class="lh-100">
                <h6 class="mb-0 text-white lh-100">관리자</h6>
                <small>이계정은 관리자계정입니다.</small>
            </div>
        </div>

        <div class="my-3 p-3 bg-white rounded box-shadow">
            <!-- 전체회원수에서 관리자는 제외해야 하므로 -1 해준다 -->
            <div class="p-3 border bg-light">회원수 : ${memberList.size() - 1}</div>
            <c:forEach items="${memberList}" var="member">
                <c:if test="${member.memberName != 'admin'}">
                    <div class="media text-muted pt-1">
                        <!-- 회원이 등록한 프로필이미지가 없으면 디폴트 프로필이미지, 있으면 프로필이미지 폴더에서 읽어서 출력 -->
                        <c:choose>
                            <c:when test="${member.memberProfile != null}">
                                <img src="${pageContext.request.contextPath}/profile/${member.memberEmail}-${member.memberProfile}" class="mr-2 rounded" width="32" height="32">
                            </c:when>
                            <c:otherwise>
                                <img src="../../../resources/assets/images/default-profile.jpg" class="mr-2 rounded" width="32" height="32">
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${sessionScope.memberName == 'admin'}">
                            <button id="btnDeleteMember" name="btnDeleteMember" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;" type="button" class="btn btn-primary" onclick="deleteMember(${member.id})" >회원삭제</button>
                        </c:if>
                        <p class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                            <strong class="d-block text-gray-dark">${member.memberName}</strong>
                            아이디 : ${member.id} 이메일 : ${member.memberEmail}
                        </p>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </section>
</main>
</body>
<script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
<script>
    const deleteMember = (memberId) => {
        // 회원가입 버튼 비활성화
        if($('#btnDeleteMember') != undefined){
            $("#btnDeleteMember").prop("disabled", true);
        }
        $.ajax({
            type:"get",
            url:"/member/memberDelete",
            data:{
                id : memberId
            },
            success:(result)=>{
                if(result == "success"){
                    alert('회원을 삭제하였습니다.');
                    location.href = '/member/';
                }else if(result == "fail"){
                    alert('회원을 삭제하지 못했습니다.');
                }
                // 회원가입 버튼 활성화
                if($('#btnDeleteMember') != undefined){
                    $("#btnDeleteMember").prop("disabled", false);
                }
            },
            error:()=>{
                alert('회원삭제 도중 에러가 발생하였습니다.');
                // 회원가입 버튼 활성화
                if($('#btnDeleteMember') != undefined){
                    $("#btnDeleteMember").prop("disabled", false);
                }
            }
        });
    }
</script>
<script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
<script src="../../../resources/assets/js/main.js"></script>
</html>
