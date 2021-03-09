<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>Title</title>
</head>
<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    HttpSession ses=request.getSession();
    String sid=(String) ses.getAttribute("temp");
    Connection conn=null;
    Statement stmt=null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
    } catch (Exception e) {
        e.printStackTrace();
    }
    final String pid=request.getParameter("pid");
    final String id=(String) ses.getAttribute("id");
    if(id==null || sid==null){
        response.sendRedirect("index.html");
    }
    String sql="Select * from Product p,ProdDesc d where p.pid=d.pid and p.id='"+id+"'  and p.pid='"+pid+"'";
    stmt=conn.createStatement();
    ResultSet rs=stmt.executeQuery(sql);
%>
<body>
<div class="jumbotron jumbotron-fluid">
    <div class="container">
        <h1 class="display-7">Change Description</h1>
        <p class="lead">Product</p>
    </div>
</div>
    <div class="container">
        <div class="row">
            <div class="col col-lg-12">
                <form class="text-right" action="productManager" method="post">
                    <button class="btn btn-dark" type="submit">
                        HOME
                    </button>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col col-lg-6">
                <% while(rs.next()){ %>
                        <form  action="change" method="post">
                            <h5>Name</h5>
                            <input style="width: 70%" type="text" value="<%= rs.getString("name")%>" name="name"><br><br>
                            <h5>Color</h5>
                            <input style="width: 70%"  type="text" value="<%= rs.getString("color") %>" name="color"><br><br>
                            <h5>Connection</h5>
                            <input style="width: 70%"  type="text" value="<%= rs.getString("connection") %>" name="connection"><br><br>
                            <h5>type</h5>
                            <input style="width: 70%"  type="text" value="<%= rs.getString("type") %>" name="type"><br><br>
                            <h5>Description</h5>
                            <input style="width: 70%" type="text" value="<%=rs.getString("Description")%>" name="desc" ><br><br>
                            <input type="hidden" name="pid" value="<%=pid%>">
                            <button class="btn btn-dark" type="submit">
                                Submit
                            </button>
                        </form>
                <% }%>
            </div>
        </div>
    </div>
</body>
</html>
