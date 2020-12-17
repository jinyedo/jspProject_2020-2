<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.Setting" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    String goFindID_process = request.getParameter("goFindID_process");
    if (goFindID_process != null && goFindID_process.equals("goFindID_process")) {
%>

<%
    try {
%>

<%
    String name = request.getParameter("user_name");
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
    rs = stmt.executeQuery("SELECT * FROM user WHERE name='" + name + "' AND email= '" + email + "'");
%>
    <% if (rs.next()) { %>
        <script>
            alert(`회원님의 아이디는 '<%=rs.getString("id")%>' 입니다.`);
            <% con.close(); %>
            parent.location.href="index.jsp";
        </script>
    <% } else { %>
        <script>
            parent.location.href="findID.jsp";
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
