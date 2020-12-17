<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% session.invalidate(); %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="./css/find_ID.css">
</head>
<body>
<div class="wrap">
    <div class="container">
        <h1>아이디 찾기</h1>
        <form name="findID_form">
            <p>이름</p>
            <input class="user_name" type="text" name="user_name">
            <p>이메일</p>
            <input class="user_email" type="email" name="user_email">
            <div class="btns">
                <input class="findID_btn" type="button" value="아이디 찾기" onclick="findID()">
                <a href="./index.jsp" class="exit">취소</a>
            </div>
            <input type="hidden" name="goFindID_process" value="goFindID_process">
        </form>
    </div>
</div>
<script type="text/javascript">
    function findID() {
        const findID_form = document.findID_form;
        const name = findID_form.user_name.value;
        const email = findID_form.user_email.value;

        if (name.length === 0 || name === "") {
            alert("이름을 입력해주세요");
            findID_form.user_name.focus();
        } else if (email.length === 0 || email === "") {
            alert("이메일을 입력해주세요");
            findID_form.user_email.focus();
        } else {
            findID_form.method = "post";
            findID_form.action = "findID_process.jsp";
            findID_form.submit();
        }
    }
</script>
</body>
</html>
