<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="project.Setting" %>
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

<% // 데이터 베이스 접속
    Setting setting = new Setting();
    Connection con = setting.getConnection();
    Statement stmt;
    ResultSet rs;
%>

<%
    String id = (String) session.getAttribute("user");
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM user WHERE id='" + id + "'");
    if (rs.next()) {
        String name = rs.getString("name");
        String email = rs.getString("email");
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내정보</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/profile.css">
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
                <li><a class="select">내 정보</a></li>
            </ul>
        </nav>
        <div class="content">
            <h2>내정보</h2>
            <div class="user">
                <div class="profile_box">
                    <span class="name"><%=name%></span>
                    <input type="button" class="signOut_btn" value="로그아웃" onclick="signOut()">
                    <span class="email"><%=email%></span>
                </div>
                <hr>
                <div class="action_box">
                    <a href="./changePW.jsp">비밀번호 변경</a>
                    <a href="./deleteAccount.jsp">회원 탈퇴</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script>
    signOut = () => {
        const question = confirm("로그아웃 하시겠습니까?");
        if (question === true) {
            parent.location.href="index.jsp";
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

<% }
} else {
%>
<script>
    parent.location.href="index.jsp";
</script>
<% } %>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>