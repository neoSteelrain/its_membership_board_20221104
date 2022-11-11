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
    <script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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

        /*
         로그인 상태일때
         - 댓글의 작성자에 회원의 이름이 나온다.
         - 작성자 input 태그를 readonly 한다.
         */
        if(${sessionScope.memberName != null}){
            $('#commentWriter').prop('value', '${sessionScope.memberName}');
            $('#commentWriter').prop('readonly', true);
        }

        //$('#comment-list').hide();

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
    <section>
        <div class="container mt-5" id="comment-write" >
            <div class="input-group-sm mb-3">
                <div class="form-group">
                    <label for="commentWriter">작성자</label>
                    <input type="text" id="commentWriter" class="form-control" placeholder="작성자">
                </div>
                <div class="form-group">
                    <label for="commentContents">내용</label>
                    <input type="text" id="commentContents" class="form-control" placeholder="내용">
                </div>
                <button type="button" id="comment-write-btn" class="btn btn-secondary" onclick="requestComment()" >댓글작성</button>
            </div>
        </div>
        <div class="container mt-5" id="comment-list">
            <table class="table">
                <tr>
                    <th>댓글번호</th>
                    <th>작성자</th>
                    <th>내용</th>
                    <th>작성시간</th>
                </tr>
                <c:forEach items="${commentList}" var="comment">
                    <tr>
                        <td>${comment.id}</td>
                        <td>${comment.commentWriter}</td>
                        <td>${comment.commentContents}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${comment.commentCreatedDate}"></fmt:formatDate></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </section>
</main>
</body>
<script>
    const requestComment = () => {
        const mId = ${sessionScope.id};
        const bId = ${board.id};
        const cWriter = $('#commentWriter').val();
        const comtContents = $('#commentContents').val();

        if(comtContents == ""){
            alert('내용을 입력하셔야 합니다.');
            return;
        }

        $("#comment-write-btn").prop("disabled", true);

        $.ajax({
            type:"post",
            url:"/comment/commentWrite",
            data:{
                memberId:mId,
                boardId:bId,
                commentWriter:cWriter,
                commentContents:comtContents
            },
            dataType:"json",
            success:(commentList)=>{
                // $('#comment-list').show();
                // console.log(commentList);
                let output = "<table class='table'>";
                output += "<tr><th>댓글번호</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th></tr>";
                for(let i in commentList){
                    output += "<tr>";
                    output += "<td>"+commentList[i].id+"</td>";
                    output += "<td>"+commentList[i].commentWriter+"</td>";
                    output += "<td>"+commentList[i].commentContents+"</td>";
                    output += "<td>"+moment(commentList[i].commentCreatedDate).format("YYYY-MM-DD HH:mm:ss")+"</td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('comment-list').innerHTML = output;
                document.getElementById('commentWriter').value=cWriter;
                document.getElementById('commentContents').value='';
                $("#comment-write-btn").prop("disabled", false);
            },
            error:()=>{
               $("#comment-write-btn").prop("disabled", false);
            }
        });
    }

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
