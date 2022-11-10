<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-10
  Time: 오후 5:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/main.css" />
    <script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
    <script src="../../../resources/assets/js/main.js"></script>
    <title>게시판 검색 결과</title>
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
    <section>
        <div class="container">
            <nav class="navbar navbar-expand-lg navbar-dark bg-light border-dark">
                <div class="container-fluid">
                    <div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
                        <select id="pageCountSlt" name="pageCountSlt" class="form-select form-select-sm" aria-label=".form-select-sm example" onchange="selectPageCount()" style="width: 120px">
                            <option selected>페이지 갯수</option>
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                        </select>
                    </div>
                </div>
            </nav>
            <table class="table caption-top">
                <caption>게시물 목록입니다.</caption>
                <thread class="table-light">
                    <th scope="col">번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col">등록일</th>
                    <th scope="col">조회</th>
                    <th scope="col">수정</th>
                    <th scope="col">삭제</th>
                </thread>
                <tbody>
                <c:forEach items="${boardList}" var="board">
                    <tr>
                        <td>${board.id}</td>
                        <td><a href="/board/boardDetail?boardId=${board.id}&page=${paging.page}">${board.boardTitle}</a></td>
                        <td>${board.boardWriter}</td>
                        <td><fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate> </td>
                        <td>${board.boardHits}</td>
                        <c:choose>
                            <c:when test="${sessionScope.id == board.memberId}">
                                <td><button id="boardUpdateBtn" name="boardUpdateBtn" class="btn-outline-light" type="button" onclick="javascript:requestBoardUpdate('${board.id}');" >수정</button></td>
                                <td><button id="boardDeleteBtn" name="boardDeleteBtn" class="btn-outline-light" type="button" onclick="javascript:requestBoardDelete('${board.id}');" >삭제</button></td>
                            </c:when>
                            <c:when test="${sessionScope.id == 1}">
                                <td></td>
                                <td><button id="boardDeleteAdminBtn" name="boardDeleteAdminBtn" class="btn-outline-light" type="button" onclick="javascript:requestBoardDelete('${board.id}');" >삭제</button></td>
                            </c:when>
                            <c:otherwise>
                                <td></td>
                                <td></td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
</main>
</body>
</html>
