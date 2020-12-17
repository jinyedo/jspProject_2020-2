<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% session.invalidate(); %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="./css/find_PW.css">
</head>
<body>
<div class="wrap">
    <div class="container">
        <h1>비밀번호 찾기</h1>
        <form name="findPW_form">
            <p>이름</p>
            <input class="user_name" type="text" name="user_name">
            <p>아이디</p>
            <input class="user_id" type="text" name="user_id">
            <p>이메일</p>
            <input class="user_email" type="email" name="user_email">
            <input type="hidden" name="goFindPW_process" value="goFindPW_process">
            <div class="btns">
                <input class="findPW_btn" type="button" value="비밀번호 찾기" onclick="findPW()">
                <a href="./index.jsp" class="exit">취소</a>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    function findPW() {
        const findPW_form = document.findPW_form;
        const name = findPW_form.user_name.value;
        const id = findPW_form.user_id.value;
        const email = findPW_form.user_email.value;

        if (name.length === 0 || name === "") {
            alert("이름을 입력해주세요");
            findPW_form.user_name.focus();
        } else if (id.length === 0 || id === "") {
            alert("아이디를 입력해주세요");
            findPW_form.user_id.focus();
        } else if (email.length === 0 || email === "") {
            alert("이메일을 입력해주세요");
            findPW_form.user_email.focus();
        } else {
            findPW_form.method = "post";
            findPW_form.action = "findPW_process.jsp";
            findPW_form.submit();
        }
    }
</script>
</body>
</html>
