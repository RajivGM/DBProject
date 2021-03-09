<%@ page import="javax.xml.transform.Result" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Description</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<% HttpSession ses=request.getSession(); %>
<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    if(ses.getAttribute("id")==null){
        response.sendRedirect("Error.jsp");
    }
%>
<%!String id=null; %>
<% id= (String) ses.getAttribute("id"); %>
<% String pcid=(String)request.getParameter("product-des"); %>
<% Connection conn=null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
    } catch (Exception e) {
        e.printStackTrace();
    }
    String sql="Select * from product,prodDesc where id='"+id+"' and prodDesc.pid='"+pcid+"' and product.pid=prodDesc.pid";
    Statement stmt= null;
    try {
        stmt = conn.createStatement();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    ResultSet rs= null;
    try {
        rs = stmt.executeQuery(sql);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<div class="jumbotron jumbotron-fluid">
    <div class="container">
        <h2 class="display-7">Product Description</h2>
        <p class="lead">Product</p>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col col-lg-12">
            <form class="text-right" action="product.jsp" method="post">
                <button class="btn btn-dark" type="submit">
                    HOME
                </button>
            </form>
        </div>
    <div class="row">
            <% while(rs.next()) { %>
                <div class="col col-lg-6">
                    <img src="h.jpg" alt="Image here" width="100%">
                </div>
                <div class="col col-lg-6">
                    <h3 style="text-align: justify;width: 100%"><%=rs.getString("name")%> Super Extra Bass <% if( (rs.getString("connection").equalsIgnoreCase("wireless")) ){
                        out.print("Bluetooth");
                    }else out.print("wired");%> Headset with Mic  (<%=rs.getString("color")%>,<% if( (rs.getString("type").equalsIgnoreCase("onEar")) ){
                       out.print("ON THE EAR");
                    }else out.print("OVER THE EAR");%>)</h3>
                    <p> No Cost EMI on Bajaj Finserv EMI Card on cart value above ₹4499T&C</p>
                    <div class="desc">
                        <div>
                            <p style="margin-right:10px;font-family: verdana;font-style: italic;">Description</p>
                        </div>
                        <div style="text-align: justify;width: 100%;">
                            <p> <%=rs.getString("Description")%></p>
                        </div>
                    </div>
                </div>
        <% } %>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</html>
