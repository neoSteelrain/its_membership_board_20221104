<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-11-10
  Time: 오후 4:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../../../resources/assets/css/main.css" />
    <title>마이 페이지</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<main role="main" class="container bootdey.com">
    <section style="margin-top: 10px">
        <form id="boardDetaillFrm" name="boardDetaillFrm">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="boardWriter" class="form-label">이름</label>
                    <input type="text" class="form-control" id="boardWriter" name="boardWriter" readonly value="#">
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
</html>
