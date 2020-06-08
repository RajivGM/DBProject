<%--
  Created by IntelliJ IDEA.
  User: PUJIT
  Date: 14-11-2019
  Time: 10:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>VALIDATION</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
</head>
<%
    HttpSession ses=request.getSession();
    String id=(String) ses.getAttribute("id");
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    if(id==null){
        response.sendRedirect("index.html");
    }
%>
<body>
        <form action="validate" method="post">
            <h5>ENTER YOUR PASSWORD</h5>
            <input type="password" name="password" value="">
            <input type="hidden" name="page" value="<%=request.getParameter("page")%>">
            <button class="btn btn-dark" type="submit">SUBMIT</button>
        </form>
</body>
</html>
