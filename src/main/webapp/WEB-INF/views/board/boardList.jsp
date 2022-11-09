<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-08
  Time: 오후 1:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/LineIcons.2.0.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/animate.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/tiny-slider.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/glightbox.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/main.css"/>
    <title>게시물 목록</title>
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

                </tbody>
            </table>
        </div>
    </section>
</main>
    <!-- 페이징 인덱스 시작 -->
<%--    <div class="container">--%>
<%--        <ul class="pagination justify-content-center">--%>
<%--            <c:choose>--%>
<%--                &lt;%&ndash; 현재 페이지가 1페이지면 이전 글자만 보여줌 &ndash;%&gt;--%>
<%--                <c:when test="${paging.page<=1}">--%>
<%--                    <li class="page-item disabled">--%>
<%--                        <a class="page-link">[이전]</a>--%>
<%--                    </li>--%>
<%--                </c:when>--%>
<%--                &lt;%&ndash; 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 &ndash;%&gt;--%>
<%--                <c:otherwise>--%>
<%--                    <li class="page-item">--%>
<%--                        <a class="page-link" href="/board/paging?page=${paging.page-1}">[이전]</a>--%>
<%--                    </li>--%>
<%--                </c:otherwise>--%>
<%--            </c:choose>--%>

<%--            &lt;%&ndash;  for(int i=startPage; i<=endPage; i++)      &ndash;%&gt;--%>
<%--            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">--%>
<%--                <c:choose>--%>
<%--                    &lt;%&ndash; 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 &ndash;%&gt;--%>
<%--                    <c:when test="${i eq paging.page}">--%>
<%--                        <li class="page-item active">--%>
<%--                            <a class="page-link">${i}</a>--%>
<%--                        </li>--%>
<%--                    </c:when>--%>

<%--                    <c:otherwise>--%>
<%--                        <li class="page-item">--%>
<%--                            <a class="page-link" href="/board/paging?page=${i}">${i}</a>--%>
<%--                        </li>--%>
<%--                    </c:otherwise>--%>
<%--                </c:choose>--%>
<%--            </c:forEach>--%>

<%--            <c:choose>--%>
<%--                <c:when test="${paging.page>=paging.maxPage}">--%>
<%--                    <li class="page-item disabled">--%>
<%--                        <a class="page-link">[다음]</a>--%>
<%--                    </li>--%>
<%--                </c:when>--%>
<%--                <c:otherwise>--%>
<%--                    <li class="page-item">--%>
<%--                        <a class="page-link" href="/board/paging?page=${paging.page+1}">[다음]</a>--%>
<%--                    </li>--%>
<%--                </c:otherwise>--%>
<%--            </c:choose>--%>
<%--        </ul>--%>
<%--    </div>--%>
    <!-- 페이징 인덱스 끝 -->

</body>
<script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/assets/js/wow.min.js"></script>
<script src="../../../resources/assets/js/tiny-slider.js"></script>
<script src="../../../resources/assets/js/glightbox.min.js"></script>
<script src="../../../resources/assets/js/main.js"></script>
<script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
<script>
    const selectPageCount = () => {
        const selectedValue = parseInt($('#pageCountSlt').val());
        console.log(selectedValue);
    }
</script>
</html>
