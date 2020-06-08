<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: PUJIT
  Date: 12-11-2019
  Time: 07:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession ses=request.getSession();
    ResultSet rs=null;
    final String id=(String) ses.getAttribute("id");
    String sid= (String) ses.getAttribute("temp");
if(id==null || sid==null){
    response.sendRedirect("index.html");
}
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    Connection conn=null;
    PreparedStatement stmt=null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
        String sql="select pid,name from prodDesc where pid not in(select pid from Product where id=?)";
        stmt=conn.prepareStatement(sql);
        stmt.setString(1,id);
        rs=stmt.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <title>NEW PRODUCT</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<div class="jumbotron jumbotron-fluid">
    <div class="container">
        <h1 class="display-7">Add Product</h1>
        <p class="lead">Product</p>
    </div>
</div>
    <div class="container">
        <div class="row">
            <div class="col col-lg-12">
                <form class="text-right" action="productManager" method="post">
                    <button class="btn btn-dark" type="submit">
                        Back
                    </button>
                </form>
            </div>
        </div>
        <div class="row mx-auto">
            <div class="col col-lg-8">
                <form action="newProduct" method="post">
                    <p>Product ID</p>
                    <select style="width: 50%" name="pid">
                        <%while(rs.next()){%>
                        <option value="<%=rs.getString("pid")%>"><%=rs.getString("name")%></option>
                        <%}%>
                    </select>
                    <input class="btn btn-dark" type="submit">
                </form>
            </div>
            <div class="col col-lg-8">
                <form action="productManager">
                    <input class="btn btn-dark" type="submit" value="HOME">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
