<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<%
    String title = request.getParameter("title");
    int pageNum = Integer.parseInt(request.getParameter("page"));

    // 데이터 베이스 접속
    Setting setting = new Setting();
    Connection con = setting.getConnection();
    Statement stmt;
    ResultSet rs;

    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM list WHERE title='" + title + "'");
%>
<% if (rs.next()) { %>

<%
    // 게시글 개수 구하기
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM list WHERE title='" + title + "'");
    int allPosts = 0;
    if (rs.next()) {
        allPosts = rs.getInt(1);
    }
    System.out.println("게시글 수: "+allPosts);

    // 페이지 개수 구하기
    int maxPage = 0;
    if (allPosts > 5 && allPosts % 5 != 0) {
        maxPage = (allPosts / 5) + 1;
    } else if (allPosts > 5 && allPosts % 5 == 0) {
        maxPage = allPosts / 5 ;
    } else if (allPosts < 5) {
        maxPage = 0;
    }
    System.out.println("페이지 수: " + maxPage);
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 검색</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/list.css">
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
            <h2>검색된 게시글</h2>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th scope="col">글번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col">작성일</th>
                    <th scope="col">조회수</th>
                </tr>
                </thead>
                <tbody>
                <%
                    stmt = con.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM list WHERE title='" + title + "' ORDER BY idx DESC");
                %>
                <% if (!rs.next()){ %>
                <tr>
                    <td colspan="5" style="text-align: center">게시글이 존재하지 않습니다.</td>
                    <%
                        rs.close();
                        con.close();
                    %>
                </tr>
                <% } else { %>
                <%
                    rs = stmt.executeQuery("SELECT * FROM list WHERE title='" + title + "' ORDER BY idx DESC");
                    int i = 1;
                %>
                <% while (rs.next()) { %>
                <%
                    if (pageNum == 1 && i > 5) break;
                    if (pageNum > 1 && (i <= (pageNum-1)*5 || i > pageNum*5)) {
                        i++;
                        continue;
                    }
                    i++;

                %>
                <tr>
                    <th><%=rs.getString("idx")%></th>
                    <td><a href="read.jsp?idx=<%=rs.getString("idx")%>"><%=rs.getString("title")%></a></td>
                    <td><%=rs.getString("author")%></td>
                    <td><%=rs.getString("dateCreated")%></td>
                    <td><%=rs.getString("viewCount")%></td>
                </tr>
                <% } %>
                <% } %>
                </tbody>
            </table>
            <%
                rs.close();
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT COUNT(*) FROM list WHERE title='" + title + "'");
            %>
            <% if (rs.next()) { %>
                <% if (rs.getInt(1) > 5) { %>
                    <ul class="pageNavigation">
                        <% if (pageNum > 1) { %>
                            <a href="list_all.jsp?page=<%=pageNum-1%>"><&nbsp;</a>
                        <% } else { %>
                            <&nbsp;
                        <% } %>
                        <% for (int i=1; i<=maxPage; i++) {%>
                    &nbsp;      <li><a href="list_all.jsp?page=<%=i%>"><%=i%></a></li>&nbsp;
                        <% } %>
                        <% if (pageNum < maxPage) { %>
                            <a href="list_all.jsp?page=<%=pageNum+1%>">&nbsp;></a>
                        <% } else { %>
                            &nbsp;>
                        <% } %>
                    </ul>
                <% } %>
            <% } %>
            <% con.close(); %>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script>
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
<% } else {%>
<script>
    <% con.close(); %>
    alert("게시글이 존재하지않습니다.");
    history.back();
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