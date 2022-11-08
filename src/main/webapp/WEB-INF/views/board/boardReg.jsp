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
    <title>Title</title>
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
        <form>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="inputEmail4" class="form-label">작성자</label>
                    <input type="email" class="form-control" id="inputEmail4">
                </div>
                <div class="col-md-6">
                    <label for="inputPassword4" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="inputPassword4">
                </div>
                <div class="col-12">
                    <label for="inputAddress" class="form-label">제목</label>
                    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
                </div>
                <div class="col-12">
                    <!-- 게시물 본문 -->
                    <textarea class="form-control" aria-label="With textarea" rows="10" id="boardContents" name="boardContents"></textarea>
                </div>
                <div class="col-md-2">
                    <label class="form-label" style="margin-right: 10px">조회수 :</label><label class="form-label">0000</label>
                </div>
            </div>
            <div class="p-3 border bg-light"/>
            <button type="button" class="btn btn-primary">등록</button>
            <button type="button" class="btn btn-primary">목록</button>
        </form>
    </section>
</main>
</body>
<script src="../../../resources/assets/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/assets/js/jquery-3.6.1.min.js"></script>
</html>
