<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% session.invalidate(); %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="./css/signUp.css">
</head>
<body>
<div class="wrap">
    <div class="container">
        <h1>회원가입</h1>
        <form name="signUp_form">
            <ul>
                <li>
                    <p>아이디</p>
                    <input type="text" name="user_id">
                </li>
                <li>
                    <p>비밀번호</p>
                    <input type="password" name="user_pw">
                </li>
                <li>
                    <p>비밀번호 확인</p>
                    <input type="password" name="user_pwConfirm">
                </li>
                <li>
                    <p>이름</p>
                    <input type="text" name="user_name">
                </li>
                <li>
                    <p>이메일</p>
                    <input type="email" name="user_email">
                </li>
            </ul>
            <input type="hidden" name="goSignUp_process" value="goSignUp_process">
            <div class="btns">
                <input type="button" value="가입하기" onclick="signUp()">
                <a href="./index.jsp" class="exit">취소</a>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    function signUp() {
        const signUp_form = document.signUp_form;
        const id = signUp_form.user_id.value;
        const pw = signUp_form.user_pw.value;
        const pwConfirm = signUp_form.user_pwConfirm.value;
        const name = signUp_form.user_name.value;
        const email = signUp_form.user_email.value;

        if (id.length === 0 || id === "") {
            alert("아이디를 입력해주세요");
            signUp_form.user_id.focus();
        } else if (pw.length === 0 || pw === "") {
            alert("비밀번호 입력해주세요");
            signUp_form.user_pw.focus();
        } else if (pwConfirm.length === 0 || pwConfirm === "") {
            alert("비밀번호 확인창을 입력해주세요");
            signUp_form.user_pwConfirm.focus();
        } else if (name.length === 0 || name === "") {
            alert("이름 입력해주세요");
            signUp_form.user_name.focus();
        } else if (email.length === 0 || email === "") {
            alert("이메일을 입력해주세요");
            signUp_form.user_email.focus();
        } else {
            signUp_form.method="post";
            signUp_form.action="signUp_process.jsp";
            signUp_form.submit();
        }
    }
</script>
</body>
</html>
