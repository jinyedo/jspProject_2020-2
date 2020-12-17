<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0L);
    session.invalidate();
%>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="./css/index.css">
</head>
<body>
<div class="wrap">
    <div class="container">
        <h1>JIN YE DO</h1>
        <form name="signIn_form">
            <input class="user_id" type="text" name="user_id" placeholder="아이디">
            <input class="user_pw" type="password" name="user_pw" placeholder="비밀번호">
            <input class="signIn_btn" type="button" value="로그인" onclick="signIn()">
            <input type="hidden" name="goSignIn" value="goSignIn">
        </form>
        <ul>
            <li><a href="./findID.jsp">아이디 찾기</a></li>
            <li><a href="./findPW.jsp">비밀번호 찾기</a></li>
            <li><a href="./signUp.jsp">회원가입</a></li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    function signIn() {
        const signIn_form = document.signIn_form;
        const user_id = signIn_form.user_id;
        const user_pw = signIn_form.user_pw;

        if (user_id.value.length === 0 || user_id.value === "") {
            alert("아이디를 입력해주세요.");
            user_id.focus();
        } else if (user_pw.value.length === 0 || user_pw.value === "") {
            alert("비밀번호를 입력해주세요.");
            user_pw.focus();
        } else {
            signIn_form.method = "post";
            signIn_form.action = "signIn.jsp";
            signIn_form.submit();
        }
    }
</script>
</body>
</html>

