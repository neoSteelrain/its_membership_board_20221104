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
    <link rel="stylesheet" href="../../../resources/assets/css/main.css" />
    <script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
    <script src="../../../resources/assets/js/main.js"></script>
    <title>게시물 목록</title>
</head>
<script>
    <%--document.addEventListener('DOMContentLoaded', () => {--%>
    <%--    if(${sessionScope.id == 1}){--%>
    <%--        $('#boardUpdateBtn').hide();--%>
    <%--    }--%>
    <%--});--%>
</script>
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
    <!-- 페이징 인덱스 시작 -->
    <div class="container">
        <ul class="pagination justify-content-center">
            <c:choose>
                <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
                <c:when test="${paging.page<=1}">
                    <li class="page-item disabled">
                        <a class="page-link">[이전]</a>
                    </li>
                </c:when>
                <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="/board/boardList?page=${paging.page-1}">[이전]</a>
                    </li>
                </c:otherwise>
            </c:choose>

            <%--  for(int i=startPage; i<=endPage; i++)      --%>
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                <c:choose>
                    <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                    <c:when test="${i eq paging.page}">
                        <li class="page-item active">
                            <a class="page-link">${i}</a>
                        </li>
                    </c:when>

                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/boardList?page=${i}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:choose>
                <c:when test="${paging.page>=paging.maxPage}">
                    <li class="page-item disabled">
                        <a class="page-link">[다음]</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="/board/boardList?page=${paging.page+1}">[다음]</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
    <!-- 페이징 인덱스 끝 -->

</body>
<script>
    const selectPageCount = () => {
        const selectedValue = parseInt($('#pageCountSlt').val());
    }

    const requestBoardUpdate = (boardId) => {
        location.href = "/board/boardUpdate?boardId="+boardId+"&page="+${paging.page};
    }

    const requestBoardDelete = (boardIdParam) => {
        $.ajax({
            type:"get",
            url:"/board/boardDelete",
            data:{
                boardId:boardIdParam
            },
            success:(result)=>{
                if(result == "success") {
                    alert("게시글을 삭제하였습니다.");
                    location.href = "/board/boardList?page=" + ${paging.page};
                }else{
                    alert("게시글을 삭제하지 못하였습니다.");
                }
            },
            error:()=>{
                alert("게시글 삭제 도중 에러가 발생하였습니다.");
            }
        });
    }
</script>
</html>
