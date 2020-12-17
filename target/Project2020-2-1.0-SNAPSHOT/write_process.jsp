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
    String goWrite_process = request.getParameter("goWrite_process");
    if (goWrite_process != null && goWrite_process.equals("goWrite_process")) {
%>

<% try { %>

<% if (session.getAttribute("bLogin") != null && (boolean)session.getAttribute("bLogin")) { %>

<% // 데이터 베이스 접속
    Setting setting = new Setting();
    Connection con = setting.getConnection();
    PreparedStatement pstmt;
%>

<%
    String id = (String) session.getAttribute("user");
    String title = request.getParameter("title");
    String memo = request.getParameter("memo");

    pstmt = con.prepareStatement("INSERT INTO list (title, memo, author) value (?,?,?)");
    pstmt.setString(1, title);
    pstmt.setString(2, memo);
    pstmt.setString(3, id);
    pstmt.executeUpdate();

    pstmt = con.prepareStatement("SET @COUNT = 0");
    pstmt.executeUpdate();
    pstmt = con.prepareStatement("UPDATE list SET idx = @COUNT:=@COUNT+1");
    pstmt.executeUpdate();
    con.close();
%>

<script>
    alert("게시글 작성이 완료되었습니다.")
    parent.location.href="list_all.jsp?page=1";
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