<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-08
  Time: 오후 1:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <title>Title</title>
</head>
<body>
<header class="p-3 text-bg-dark">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap">
                    <use xlink:href="#bootstrap"/>
                </svg>
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/" class="nav-link px-2 text-secondary">Home</a></li>
                <li><a href="../board/boardReg" class="nav-link px-2 text-white">글작성</a></li>
                <li><a href="#" class="nav-link px-2 text-white">글목록</a></li>
                <c:if test="${sessionScope.memberName == 'admin'}">
                    <li><a href="../member/admin" class="nav-link px-2 text-white">관리자페이지</a></li>
                </c:if>
            </ul>

            <form action="#" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
                <div class="input-group">
                    <select type="value" name="type" class="form-select">
                        <option value="boardTitle" selected>제목</option>
                        <option value="boardWriter">작성자</option>
                    </select>
                    <input type="search" name="q" class="form-control form-control-dark text-bg-dark" placeholder="검색어 입력"
                           aria-label="Search">
                    <button class="btn btn-outline-light"><i class="bi bi-search"></i></button>
                </div>
            </form>

            <div class="text-end">
                <c:choose>
                    <c:when test="${sessionScope.memberName != null}">
                        <span>${sessionScope.memberName}님</span>
                        <button id="memberSignOut" type="memberSignOut" onclick="requestSignOut()" class="btn btn-outline-light me-2">로그아웃</button>
                    </c:when>
                    <c:otherwise>
                        <button id="memberSignIn" name="memberSignIn" type="button" onclick="#" class="btn btn-outline-light me-2">로그인</button>
                        <button id="memberSignUp" name="memberSignUp" type="button" class="btn btn-warning">회원가입</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>
</body>
<script>
    const requestSignOut = () => {
        location.href = "/member/signOut";
    }
</script>
</html>
