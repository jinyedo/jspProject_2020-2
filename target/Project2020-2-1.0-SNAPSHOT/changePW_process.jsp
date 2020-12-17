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
    String goChangePW_process = request.getParameter("goChangePW_process");
    if (goChangePW_process != null && goChangePW_process.equals("goChangePW_process")) {
%>

    <% try { %>

        <% if (session.getAttribute("bLogin") != null && (boolean)session.getAttribute("bLogin")) { %>

            <% // 데이터 베이스 접속
                Setting setting = new Setting();
                Connection con = setting.getConnection();
                Statement stmt;
                PreparedStatement pstmt;
                ResultSet rs;
            %>

            <%
                String id = (String) session.getAttribute("user");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM user WHERE id='" + id + "'");
            %>
                <% if (rs.next()) { %>
                    <%
                    String pw = request.getParameter("pw");
                    String newPW = request.getParameter("newPW");
                    String newPW2 = request.getParameter("newPW2");
                    %>
                    <% if (rs.getString("password").equals(pw)) { %>
                        <% if (newPW.equals(newPW2)) { %>
                            <%
                            pstmt = con.prepareStatement("UPDATE user SET password=? WHERE id='" + id + "'");
                            pstmt.setString(1, newPW);
                            pstmt.executeUpdate();
                            con.close();
                            %>
                            <script>
                                alert("비밀번호가 변경되었습니다. 다시 로그인해주세요.")
                                parent.location.href="index.jsp";
                            </script>
                        <% } else { %>
                            <% con.close(); %>
                            <script>
                                alert("새로운 비밀번호가 일치하지 않습니다.");
                                history.back();
                            </script>
                        <% } %>
                    <% } else { %>
                        <% con.close(); %>
                        <script>
                            alert("현제 비밀번호가 일치하지 않습니다.");
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
