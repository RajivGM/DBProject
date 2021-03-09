<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Product.Product" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Manage Products</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<%HttpSession ses=request.getSession(); %>
<% String id= (String) ses.getAttribute("id"); %>
<%String sid=(String) ses.getAttribute("temp"); %>
<%ArrayList arr=(ArrayList) ses.getAttribute("product");%>
<% response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");%>
<div class="jumo-heading container-fluid">
    <div class="row">
        <div class="col">
            <div class="jumbotron jumbotron-fluid">
                <div class="container">
                    <h1 class="display-4">SETTINGS</h1>
                    <p class="lead">PRODUCTS</p>
                </div>
            </div>
        </div>
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
        </div>
        <div class="row">
            <%
               if(id!=null && sid!=null){
                for(Object p:arr){
            Product product=(Product) p; %>
            <div class="col col-lg-8 mx-auto">
                <div>
                    <p style="display: inline-block;width:200px;" ><%=product.name%></p>
                    <p style="display: inline-block;width:200px;" ><%=product.ProductID%></p>
                    <form style="display: inline-block" action="change.jsp">
                    <button class="btn btn-dark" type="submit" name="pid" value="<%=product.ProductID%>">Change Description</button>
                    </form>
                    <form style="display: inline-block"  action="delete">
                        <button class="btn btn-dark" type="submit" name="pid" value="<%=product.ProductID%>"><span>Remove Item</span></button>
                    </form>
                </div>
            </div>
            <% }}else{
                response.sendRedirect("index.html");
            }%>
        </div>
        <div class="row">
            <div class="col col-lg-12">
                <form action="newProduct.jsp">
                    <button class="btn btn-dark" type="submit">
                        ADD PRODUCT
                    </button>
                </form>
                <form action="productManager">
                    <button class="btn btn-dark" type="submit">
                        REFRESH
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
<script>
 function doThis(ele) {
     console.log(ele)
     var id=document.getElementById("form-id");
     id.setAttribute("action",ele)
 }
</script>
</html>
