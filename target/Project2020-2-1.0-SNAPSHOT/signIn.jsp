<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.Setting" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    String goSignIn = request.getParameter("goSignIn");
    if ( goSignIn != null && goSignIn.equals("goSignIn")) {
%>

<%
    String id = request.getParameter("user_id");
    String pw = request.getParameter("user_pw");
%>

<%
    try {
%>

<% // 데이터 베이스 접속
    Setting setting = new Setting();
    Connection con = setting.getConnection();
    Statement stmt;
    ResultSet rs;
%>

<%
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM user WHERE id='" + id + "'");
%>

    <% if (rs.next()) { %>
        <%
            rs = stmt.executeQuery("SELECT * FROM user WHERE id='" + id + "' AND password='" + pw + "'");
            if (rs.next()) {
                session.setAttribute("bLogin", true);
                session.setAttribute("user", rs.getString("id"));
        %>
                <script>
                    parent.location.href="list_all.jsp?page=1";
                </script>
        <% } else { %>
            <script>
                parent.location.href="index.jsp";
                alert(`비밀번호가 일치하지 않습니다.`);
            </script>
        <% } %>
    <% } else { %>
        <script>
            parent.location.href="index.jsp";
            alert(`'<%=id%>'는 존재하지 않는 아이디입니다.`)
        </script>
    <% } %>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<% } else {%>
<script>
    alert("올바른 접근이 아닙니다.");
    history.back();
</script>
<% } %>