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

<% // 데이터 베이스 접속
    Setting setting = new Setting();
    Connection con = setting.getConnection();
    Statement stmt;
    PreparedStatement pstmt;
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

            pstmt = con.prepareStatement("UPDATE list SET viewCount=viewCount+1 where idx=" + idx);
            pstmt.executeUpdate();
        %>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>글읽기</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
            <link rel="stylesheet" href="./css/write.css">
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
                    <h2>글읽기</h2>
                    <div class="form_box">
                        <form>
                            <div class="form-group">
                                <label for="exampleFormControlInput1">제목</label>
                                <input type="text" class="form-control titleTF" id="exampleFormControlInput1" readonly value="<%=title%>">
                            </div>
                            <div class="form-group">
                                <label for="exampleFormControlTextarea1">내용</label>
                                <textarea class="form-control memoTA" id="exampleFormControlTextarea1" readonly rows="3"><%=memo%></textarea>
                            </div>
                            <% con.close(); %>
                            <div class="btns">
                                <a href="list_all.jsp?page=1" type="button" class="btn btn-secondary">나가기</a>
                            </div>
                        </form>
                    </div>
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