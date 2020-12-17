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
    <title>회원 탈퇴</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/deleteAccount.css">
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
            <h2>회원 탈퇴</h2>
            <div class="form_box">
                <form name="delete_form">
                    <div class="form-group">
                        <label for="exampleFormControlInput1">계정 비밀번호</label>
                        <input type="password" class="form-control password" id="exampleFormControlInput1" name="pw">
                    </div>
                    <p>※계정 삭제 시 복구 하실 수 없습니다.</p>
                    <p>※계정 삭제 시 작성하신 게시글은 모두 삭제됩니다.</p>
                    <input type="hidden" name="goDeleteAccount_process" value="goDeleteAccount_process">
                    <input type="button" class="btn btn-danger deleteAccount_btn" value="회원 탈퇴" onclick="deleteAccount()">
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script>
    deleteAccount = () => {
        const delete_form = document.delete_form;
        const pw = delete_form.pw;
        if (pw.value.length === 0 || pw.value === "") {
            alert("필수 입력값입니다.");
            pw.focus();
        } else {
            const question = confirm("정말로 탈퇴하시겠습니까?")
            if (question === true) {
                delete_form.method = "post";
                delete_form.action = "deleteAccount_process.jsp";
                delete_form.submit();
            }
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