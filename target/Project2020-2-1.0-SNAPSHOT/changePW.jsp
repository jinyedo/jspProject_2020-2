<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0L);
    request.setCharacterEncoding("UTF-8");
%>
<%
    try {
%>
<% if (session.getAttribute("bLogin") != null && (boolean)session.getAttribute("bLogin")) { %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/changePW.css">
</head>
<body>
<div class="wrap">
    <header>
        <h1><a href="./list_all.jsp?page=1">HOME</a></h1>
        <input type="text" class="search" name="search">
        <input type="button" class="search_btn" name="search_btn" onclick="searchSend();">
    </header>
    <div class="box">
        <nav>
            <ul>
                <li><a href="./list_all.jsp?page=1">전체 게시글</a></li>
                <li><a href="./list_my.jsp?page=1">내 게시글</a></li>
                <li><a href="./write.jsp">게시글 작성</a></li>
                <li><a href="./profile.jsp">내 정보</a></li>
            </ul>
        </nav>
        <div class="content">
            <h2>비밀번호 변경</h2>
            <div class="form_box">
                <form name="changePW_form">
                    <div class="form-group">
                        <label for="exampleFormControlInput1">현재 비밀번호</label>
                        <input type="password" class="form-control password" id="exampleFormControlInput1" name="pw">
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">새 비밀번호</label>
                        <input type="password" class="form-control newPassword" id="exampleFormControlInput2" name="newPW">
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">새 비밀번호 확인</label>
                        <input type="password" class="form-control newPassword_confirm" id="exampleFormControlInput3" name="newPW2">
                    </div>
                    <input type="hidden" name="goChangePW" value="goChangePW">
                    <input type="hidden" name="goChangePW_process" value="goChangePW_process">
                    <div class="btns">
                        <a type="button" class="btn btn-success" onclick="changePW()">저장</a>
                        <a href="./profile.jsp" type="button" class="btn btn-secondary">취소</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script>
    changePW = () => {
        const changePW_form = document.changePW_form;
        const pw = changePW_form.pw;
        const newPW = changePW_form.newPW;
        const newPW2 = changePW_form.newPW2;
        if (pw.value.length === 0 || pw.value === "") {
            alert("필수 입력값입니다.");
            pw.focus();
        } else if (newPW.value.length === 0 || newPW.value === "") {
            alert("필수 입력값입니다.");
            newPW.focus();
        } else if (newPW2.value.length === 0 || newPW2.value === "") {
            alert("필수 입력값입니다.");
            newPW2.focus();
        } else {
            changePW_form.method = "post";
            changePW_form.action = "changePW_process.jsp";
            changePW_form.submit();
        }
    }

    searchSend = () => {
        const search = document.querySelector(".search");
        if (search.value.length === 0 || search.value === "") {
            alert("게시글 제목을 입력해주세요.");
            search.focus();
        } else {
            parent.location.href="search.jsp?title=" + search.value + "&page=1";
        }
    }
</script>
</body>
</html>

<% } else { %>
    <script>
        parent.location.href="index.jsp";
    </script>
<% } %>

<%
    } catch (Exception e) {
    e.printStackTrace();
    }
%>