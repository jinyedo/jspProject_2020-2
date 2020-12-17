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
    String goDeleteAccount_process = request.getParameter("goDeleteAccount_process");
    if (goDeleteAccount_process != null && goDeleteAccount_process.equals("goDeleteAccount_process")) {
%>

    <% try { %>

        <% if (session.getAttribute("bLogin") != null && (boolean)session.getAttribute("bLogin")) { %>

            <% // 데이터 베이스 접속
            Setting setting = new Setting();
            Connection con = setting.getConnection();
            Statement stmt;
            PreparedStatement pstmt;
            ResultSet rs;

            String id = (String) session.getAttribute("user");
            String pw = request.getParameter("pw");
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT * FROM user WHERE id='" + id + "'");
            %>

            <% if (rs.next()) { %>
                <% if (rs.getString("password").equals(pw)) { %>
                    <%
                        pstmt = con.prepareStatement("DELETE FROM user WHERE id='" + id + "'");
                        pstmt.executeUpdate();

                        pstmt = con.prepareStatement("SET @COUNT = 0");
                        pstmt.executeUpdate();
                        pstmt = con.prepareStatement("UPDATE user SET idx = @COUNT:=@COUNT+1");
                        pstmt.executeUpdate();

                        pstmt = con.prepareStatement("DELETE FROM list WHERE author='" + id + "'");
                        pstmt.executeUpdate();

                        pstmt = con.prepareStatement("SET @COUNT = 0");
                        pstmt.executeUpdate();
                        pstmt = con.prepareStatement("UPDATE list SET idx = @COUNT:=@COUNT+1");
                        pstmt.executeUpdate();
                        con.close();
                    %>
                    <script>
                        alert("탈퇴되었습니다. 로그인 화면으로 돌아갑니다.");
                        parent.location.href="index.jsp";
                    </script>
                <% } else { %>
                    <script>
                        <% con.close(); %>
                        alert("비밀번호가 올바르지않습니다.");
                        history.back();
                    </script>
                <% } %>
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

<% } else {%>
<script>
    alert("올바른 접근이 아닙니다.");
    history.back();
</script>
<% } %>
