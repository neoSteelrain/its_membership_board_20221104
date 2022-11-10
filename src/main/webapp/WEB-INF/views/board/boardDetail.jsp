<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-10
  Time: 오전 9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/main.css" />
    <title>게시물 보기</title>
</head>
<script>
    document.addEventListener('DOMContentLoaded',() => {
        /*
         본인이 작성한 글인 경우 수정가능하게 하고 수정, 삭제 버튼이 보이도록 한다.
         다른사람의 글이면 수정할 수 없도록 하고, 수정, 삭제 버튼이 안보이게 한다.
         */
        if(${sessionScope.id == board.memberId}){
            $('#boardTitle').prop('readonly', false);
            $('#boardContents').prop('readonly', false);
            $('#updateBoardBtn').show();
            $('#deleteBoardBtn').show();
        }else{
            $('#boardTitle').prop('readonly', true);
            $('#boardContents').prop('readonly', true);
            $('#updateBoardBtn').hide();
            $('#deleteBoardBtn').hide();
        }
    });
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
<main role="main" class="container bootdey.com">
    <section style="margin-top: 10px">
        <form id="boardDetaillFrm" name="boardDetaillFrm">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="boardWriter" class="form-label">작성자</label>
                    <input type="text" class="form-control" id="boardWriter" name="boardWriter" readonly value="${board.boardWriter}">
                </div>
                <div class="col-md-6">
                    <label class="form-label">작성일</label>
                    <label class="form-label"><fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate></label>
                </div>
                <div class="col-12">
                    <label for="boardTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}">
                </div>
                <div class="col-12">
                    <!-- 게시물 본문 -->
                    <textarea class="form-control" aria-label="With textarea" rows="10" id="boardContents" name="boardContents" >${board.boardContents}</textarea>
                </div>
                <div class="col-6">
                    <label class="form-control">첨부파일 갯수 : ${board.attachedFileCount}</label>
                </div>
                <div class="col-md-2">
                    <label class="form-label" style="margin-right: 10px">조회수 :</label><label class="form-label" id="boardHits" name="boardHits">${board.boardHits}</label>
                </div>
            </div>
                <div class="p-3 border bg-light"/>
                <button type="button" class="btn btn-primary" id="updateBoardBtn" name="updateBoardBtn" onclick="requestUpdateBoard()">수정</button>
                <button type="button" class="btn btn-primary" id="deleteBoardBtn" name="deleteBoardBtn" onclick="requestDeleteBoard()">삭제</button>
                <button type="button" class="btn btn-primary" id="boardListBtn" name="boardListBtn" onclick="requestBoardList()">목록</button>
        </form>
    </section>
</main>
</body>
<script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
<script src="../../../resources/assets/js/main.js"></script>
<script>
    const requestBoardList = () => {
        location.href = "/board/boardList?page=" + ${page};
    }

    const requestDeleteBoard = () => {
        enableButtons(false);

        $.ajax({
            type:"get",
            url:"/board/boardDelete",
            data:{
                boardId:${board.id}
            },
            success:(result)=>{
                if(result == "success") {
                    alert("게시글을 삭제하였습니다.");
                    enableButtons(true);
                    requestBoardList();
                }else{
                    alert("게시글을 삭제하지 못하였습니다.");
                    enableButtons(true);
                }
            },
            error:()=>{
                alert("게시글 삭제 도중 에러가 발생하였습니다.");
                enableButtons(true);
            }
        });
    }

    /*
    수정,삭제,목록 버튼을 활성화 / 비활성화 하는 헬퍼함수
     */
    const enableButtons = (e) => {
        $("#updateBoardBtn").prop("disabled", !e);
        $("#deleteBoardBtn").prop("disabled", !e);
        $("#boardListBtn").prop("disabled", !e);
    }

    const requestUpdateBoard = () => {
        enableButtons(false);
        $.ajax({
            type:"post",
            url:"/board/boardUpdate",
            data:{
                boardId:${board.id},
                boardTitle:$('#boardTitle').val(),
                boardContents:$('#boardContents').val()
            },
            success:(result)=>{
                if(result == "success"){
                    alert("게시물을 수정하였습니다.");
                    enableButtons(true);
                    requestBoardList();
                }else{
                    alert("게시물을 수정하지 못했습니다.");
                    enableButtons(true);
                }
            },
            error:()=>{
                alert("게시물 수정도중 에러가 발생하였습니다.");
                enableButtons(true);
            }
        });
    }

</script>
</html>
