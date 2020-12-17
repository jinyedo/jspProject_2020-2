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
    String idx = request.getParameter("idx");
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM list WHERE idx='" + idx + "'");
%>
    <% if (rs.next()) {%>
    <%
        String title = rs.getString("title");
        String memo = rs.getString("memo");
    %>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>게시글 관리</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/setList.css">
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
                <h2>게시글 관리</h2>
                <div class="form_box">
                    <form name="setList_form">
                        <div class="form-group">
                            <label for="exampleFormControlInput1">제목</label>
                            <input type="text" class="form-control titleTF" id="exampleFormControlInput1" name="title" value="<%=title%>">
                        </div>
                        <div class="form-group">
                            <label for="exampleFormControlTextarea1">내용</label>
                            <textarea class="form-control memoTA" id="exampleFormControlTextarea1" rows="3" name="memo"><%=memo%></textarea>
                        </div>
                        <input type="hidden" name="goSetList" value="goSetList">
                        <% con.close(); %>
                        <div class="btns">
                            <input type="button" class="btn btn-success" onclick="modify()" value="수정">
                            <input type="button" class="btn btn-danger" onclick="deletePost()" value="삭제">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <script>
        modify = () => {
            const setList_form = document.setList_form;
            const title = document.querySelector(".titleTF");
            const memo = document.querySelector(".memoTA");
            if (title.value.length === 0 || title.value === "") {
                alert("글제목을 입력해주세요.");
                title.focus();
            } else if (memo.value.length === 0 || memo.value === "") {
                alert("글내용을 입력해주세요.");
                memo.focus();
            } else {
                setList_form.method = "post";
                setList_form.action = "setList_modify.jsp?idx=<%=idx%>";
                setList_form.submit();
            }
        }

        deletePost = () => {
            const question = confirm("정말로 삭제하시겠습니까?");
            if (question === true) {
                const setList_form = document.setList_form;
                setList_form.method = "post";
                setList_form.action = "setList_delete.jsp?idx=<%=idx%>";
                setList_form.submit();
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
        <% con.close(); %>
        <script>
            alert("게시글이 존재하지 않습니다.")
            parent.location.href="index.jsp";
        </script>
    <% } %>
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