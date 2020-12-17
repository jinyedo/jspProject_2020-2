<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.Setting" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    String goSignUp_process = request.getParameter("goSignUp_process");
    if (goSignUp_process != null && goSignUp_process.equals("goSignUp_process")) {
%>

<%
    try {
%>

<%
    String user_id = request.getParameter("user_id");
    String user_pw = request.getParameter("user_pw");
    String user_pwConfirm = request.getParameter("user_pwConfirm");
    String user_name = request.getParameter("user_name");
    String user_email = request.getParameter("user_email");
%>

<% // 데이터 베이스 접속
    Setting setting = new Setting();
    Connection con = setting.getConnection();
    PreparedStatement pstmt;
    Statement stmt;
    ResultSet rs;
%>

<%
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM user WHERE id='" + user_id + "'");
%>
    <!-- 아이디 중복 확인 -->
    <!-- 중복된 아이디가 있다면 -->
    <% if (rs.next()) { %>
        <script>
            parent.location.href="signUp.jsp";
            <% con.close(); %>
            alert(`<%=user_id%>는 이미 존재하는 아이디입니다.`);
        </script>
    <!-- 중복된 아이디가 없다면 -->
    <% } else {%>
        <% // 이메일 종복 검사
            rs = stmt.executeQuery("SELECT * FROM user WHERE email='" + user_email + "'");
        %>
            <!-- 중복된 이메일이 있다면 -->
            <% if (rs.next()) { %>
                <script>
                    parent.location.href="signUp.jsp";
                    <% con.close(); %>
                    alert(`<%=user_email%>로 가입된 아이디가 이미 존재합니다.`);
                </script>

            <!-- 중복된 이메일이 없다면 -->
            <% } else { %>
                <!-- "비밀번호" 와 "비밀번호 확인" 이 같다면 -->
                <% if (user_pw.equals(user_pwConfirm)) { %>
                    <%
                        // 회원 정보 저장
                        pstmt = con.prepareStatement("INSERT INTO user (id, password, name, email) VALUE (?,?,?,?)");
                        pstmt.setString(1, user_id);
                        pstmt.setString(2, user_pw);
                        pstmt.setString(3, user_name);
                        pstmt.setString(4, user_email);
                        pstmt.executeUpdate();

                        // 회원 idx 초기화
                        pstmt = con.prepareStatement("SET @COUNT = 0");
                        pstmt.executeUpdate();
                        pstmt = con.prepareStatement("UPDATE user SET idx = @COUNT:=@COUNT+1");
                        pstmt.executeUpdate();
                    %>
                        <script>
                            <% con.close(); %>
                            parent.location.href="index.jsp";
                            alert("회원가입 완료");
                        </script>
                <!-- "비밀번호" 와 "비밀번호 확인" 이 다르다면 -->
                <% } else { %>
                    <script>
                        <% con.close(); %>
                        parent.location.href="signUp.jsp";
                        alert("비밀번호가 동일하지 않습니다.");
                    </script>
                <% } %>
        <% } %>
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