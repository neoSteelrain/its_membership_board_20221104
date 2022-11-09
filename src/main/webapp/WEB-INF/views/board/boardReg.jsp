<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-08
  Time: 오후 3:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
    <title>게시물 등록</title>
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
<main role="main" class="container bootdey.com">
    <section style="margin-top: 10px">
        <form id="boardRegFrm" name="boardRegFrm" action="/board/boardReg" method="post" enctype="multipart/form-data">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="boardWriter" class="form-label">작성자</label>
                    <input type="text" class="form-control" id="boardWriter" name="boardWriter" readonly value="${sessionScope.memberName}">
                </div>
                <div class="col-md-6">
                    <label for="boardPassword" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="boardPassword" name="boardPassword">
                </div>
                <div class="col-12">
                    <label for="boardTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="boardTitle" name="boardTitle">
                </div>
                <div class="col-12">
                    <!-- 게시물 본문 -->
                    <textarea class="form-control" aria-label="With textarea" rows="10" id="boardContents" name="boardContents"></textarea>
                </div>
                <div class="col-6">
                    <input type="file" multiple="multiple" id="boardFileList" name="boardFileList">
                </div>
<%--                <div class="col-md-2">--%>
<%--                    <label class="form-label" style="margin-right: 10px">조회수 :</label><label class="form-label" id="boardHits" name="boardHits">0000</label>--%>
<%--                </div>--%>
            </div>
            <div class="p-3 border bg-light"/>
            <button type="button" class="btn btn-primary" id="boardRegister" name="boardRegister" onclick="regiterBoardSubmit()">등록</button>
<%--            <button type="button" class="btn btn-primary" id="boardRegister" name="boardRegister" onclick="regiterBoard()" >등록</button>--%>
            <button type="button" class="btn btn-primary" id="memeberList" name="memeberList">목록</button>
        </form>
    </section>
</main>
</body>
<script>
    const regiterBoardSubmit = () => {
        document.boardRegFrm.submit();
    }

    /*
        ajax 구현은 잘 안된다.회원가입 할때와 똑같고 첨부파일 부분만 배열로 바꿨을 뿐인데... 안된다.
        구글링해도 기본의 1개일때와 기본틀은 똑같고 첨부파일부분만 배열이냐 List 이냐 차이일뿐이다.
        Controller 부분도 ModelAttribute 로 받는 것은 동일한것으로 보이지만, 다른 설정이나 코딩이 추가적으로 필요한것 같다.
        ModelAttribute 에 DTO 받는 방법외에 파라미터는 RequestParam, 첨부파일은 MultipartFile[]로 따로 받는 것도 해봐야 한다.
     */
    const regiterBoard = () => {
        $("#boardRegister").prop("disabled", true);
        const boardData = new FormData();
        boardData.append("boardWriter", '${sessionScope.memberName}');
        boardData.append("boardPassword", $('#boardPassword').val());
        boardData.append("boardTitle", $('#boardTitle').val());
        boardData.append("boardContents", $('#boardContents').val());
        boardData.append("memberId", '${sessionScope.id}');
        /*
        첨부파일 처리
         */
        const file = $('#boardFileList').prop('files');
        //boardData.append("boardFileList", file[0]);
        const fileList = $('#boardFileList').prop('files');
        for(let f in fileList){
            boardData.append("boardFileList", f);
        }

        $.ajax({
            enctype: "multipart/form-data",
            processData:false,
            contentType:false,
            type:"post",
            url:"/board/boardReg",
            data:boardData,
            success:(result)=>{
                $("#boardRegister").prop("disabled", false);
            },
            error:()=>{
                $("#boardRegister").prop("disabled", false);
            }
        });
    }
</script>
</html>
