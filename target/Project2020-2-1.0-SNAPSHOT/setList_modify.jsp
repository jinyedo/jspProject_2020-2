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
    String goSetList = request.getParameter("goSetList");
    if (goSetList != null && goSetList.equals("goSetList")) {
%>
<% try { %>

<% if (session.getAttribute("bLogin") != null && (boolean)session.getAttribute("bLogin")) { %>

<% // 데이터 베이스 접속
    Setting setting = new Setting();
    Connection con = setting.getConnection();
    PreparedStatement pstmt;
%>
<%
    String idx = request.getParameter("idx");
    String title = request.getParameter("title");
    String memo = request.getParameter("memo");

    pstmt = con.prepareStatement("UPDATE list SET title=?, memo=? WHERE idx=" + idx);
    pstmt.setString(1, title);
    pstmt.setString(2, memo);
    pstmt.executeUpdate();
    con.close();
%>

<script>
    alert("수정이 완료되었습니다.")
    parent.location.href="list_my.jsp?page=1";
</script>

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

<% } else {%>
<script>
    alert("올바른 접근이 아닙니다.");
    history.back();
</script>
<% } %>