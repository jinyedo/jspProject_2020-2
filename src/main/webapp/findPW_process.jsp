<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.Setting" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    String goFindPW_process = request.getParameter("goFindPW_process");
    if (goFindPW_process != null && goFindPW_process.equals("goFindPW_process")) {
%>

<%
    try {
%>

<%
    String name = request.getParameter("user_name");
    String id = request.getParameter("user_id");
    String email = request.getParameter("user_email");
%>

<% // 데이터 베이스 접속
    Setting setting = new Setting();
    Connection con = setting.getConnection();
    Statement stmt;
    ResultSet rs;
%>

<%
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM user WHERE name='" + name + "' AND id='" + id + "' AND email= '" + email + "'");
%>
    <% if (rs.next()) { %>
        <script>
            alert(`회원님의 비밀번호는 '<%=rs.getString("password")%>' 입니다.`);
            <% con.close(); %>
            parent.location.href="index.jsp";
        </script>
    <% } else { %>
        <script>
            parent.location.href="findPW.jsp";
            <% con.close(); %>
            alert("회원 정보가 존재하지 않습니다.");
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