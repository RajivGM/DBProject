<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="jdk.nashorn.internal.ir.RuntimeNode" %>
<%@ page import="com.sun.xml.internal.fastinfoset.algorithm.BooleanEncodingAlgorithm" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%
        response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
        HttpSession ses=request.getSession();
        ses.setAttribute("temp",null);
        final String id= (String) ses.getAttribute("id");
        if(id==null){
            response.sendRedirect("index.html");
        }
        ResultSet rs = null;
        String finalSql=null;
        String[] colorValues=request.getParameterValues("color");
        String[] connectivityValues=request.getParameterValues("connect");
        String[] ageValues=request.getParameterValues("age");
        String[] typeValues=request.getParameterValues("type");
        try {
            finalSql=getProducts(colorValues,connectivityValues,ageValues,typeValues,id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <%
        Connection conn=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/learn","root","dancebar123");
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            assert conn != null;
            String value = request.getParameter("search-value");
            if (value == null)
                value = "";
            Statement st = conn.createStatement();
            if (value.trim().length() == 0) {
                PreparedStatement stmt = conn.prepareStatement(finalSql);
               rs = integrate(finalSql, colorValues, request.getParameterValues("connect"), request.getParameterValues("age"), request.getParameterValues("type"), stmt);
            } else if (value.trim().length() != 0) {
                System.out.println("inside search");
                String sql2 = "Select * from product,prodDesc where id='" + id + "' and name like '%" + value + "%' and product.pid=prodDesc.pid";
                String sql4= "select * from searchHistory where id='"+id+"' and  Sname='"+value.trim()+"'";
                rs = st.executeQuery(sql2);
                Statement st2=conn.createStatement();
                ResultSet check=st2.executeQuery(sql4);
                if(check.next()){
                    String sql5="update searchHistory set count=count+1 where id='"+id+"' and Sname='"+value.trim()+"'";
                    Statement st3=conn.createStatement();
                    st3.execute(sql5);
                }else{
                    Statement st4=conn.createStatement();
                    String sql3= "insert into searchHistory values('"+id+"','"+value.trim()+"',1)";
                    st4.execute(sql3);
                }
                System.out.println(check.next());
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <%!
        public static ResultSet integrate(String sqlFinal,String[] colorValues,String[] connectivityValues,String[] ageValues,String[] typeValues,PreparedStatement stmt) throws SQLException {
            int i=0;
            int k=1;
            if(colorValues!=null) {
                for (i = 0; i < colorValues.length; i++) {
                    System.out.println(colorValues[i]);
                    stmt.setString(k, colorValues[i]);
                    k++;
                }
            }

            if(connectivityValues!=null) {
                for (i = 0; i < connectivityValues.length; i++) {
                    stmt.setString(k, connectivityValues[i]);
                    k++;
                }
            }

            if(ageValues!=null) {
                for (i = 0; i < ageValues.length; i++) {
                    stmt.setString(k, ageValues[i]);
                    k++;
                }
            }
            if(typeValues!=null) {
                for (i = 0; i < typeValues.length; i++) {
                    stmt.setString(k, typeValues[i]);
                    k++;
                }
            }
                return (stmt.executeQuery());
        }
    %>
    <%!
        public static StringBuilder build(String[] values, String att,String id){
            String si="Select prodDesc.pid from product,prodDesc where id='"+id+"' and product.pid=prodDesc.pid";
            StringBuilder sb=new StringBuilder(si);
            if(values!=null){
                for(int i=0;i<values.length;i++){
                    if(i==0){
                        sb.append(" and ").append(att).append(" in('0',?");
                    }else{
                        sb.append(",?");
                    }
//                    if(i==0){
//                        sb.append(" and "+att+"=?");
//                        sb.append(" or "+att+" is null");
//                    }else{
//                        sb.append(" or "+att+"=?");
//                    }
                }
                sb.append(")");
            }
            return sb;
        }
    %>
    <%! public static String getProducts(String[] colorValues,String[] connectivityValues,String[] ageValues,String[] typeValues,String id) throws SQLException {
        String sql1=new String(build(colorValues,"color",id));
        String sql2=new String(build(connectivityValues,"connection",id));
        String sql3=new String(build(ageValues,"age",id));
        String sql4=new String(build(typeValues,"type",id));
        String sqlFinal="select * from product,prodDesc where id='"+id+"' and product.pid=prodDesc.pid and prodDesc.pid in("+sql1+") and prodDesc.pid in("+sql2+") and prodDesc.pid in("+sql3+") and prodDesc.pid in("+sql4+")";
        System.out.println(sqlFinal);
        return sqlFinal;
    }
    %>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="STYLE/product.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>Title</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <style>

    </style>
</head>
<body>
<%--<div id="stick" class="container-fluid">--%>
<%--    <div class="row">--%>
        <div id="nav-col" class="col col-lg-12 col-md-12 col-sm-12 sticky-top">
            <nav id="nav-color" class="navbar">
                <h4>APTHAMITRA</h4>
                <form action="product.jsp" method="get" class="form-inline ml-auto">
                    <input id="search-bar" type="text" name="search-value" value="">
                    <button style="color:white;background-color: transparent;border: 1px solid white " type="submit">Search</button>
                </form>
                <div style="display: flex;">
                    <form method="post" action="validate.jsp">
                        <input class="pro-sup text-uppercase" type="submit" name="id" value="Support">
                        <input type="hidden" name="page" value="S">
                    </form>
                    <form method="post" action="validate.jsp">
                        <button class="text-uppercase" style="border: none;text-decoration: none;background-color: transparent;color: white" name="id" value="<%=id%>">Product</button>
                        <input type="hidden" name="page" value="PM">
                    </form>
                    <form action="logout.jsp">
                        <input class="pro-sup" type="submit" value="LOG OUT">
                    </form>
                </div>
            </nav>
        </div>
<%--    </div>--%>
<%--</div>--%>
<div id="pre">
    <h4 id="preference" style="display: inline-block;color: grey;">PREFERENCE ></h4>
</div>
<div id="lefty" class="left-col text-center">
    <h5>CHANGE</h5>
    <h6>COLOR</h6>

    <form action="product.jsp" method="get">
        <div class="one">
            <input type="checkbox" name="color" value="red"> RED <br>
            <input type="checkbox" name="color" value="pink"> PINK <br>
            <input type="checkbox" name="color" value="yellow"> YELLOW <br>
            <input type="checkbox" name="color" value="green"> GREEN <br>
            <input type="checkbox" name="color" value="white"> WHITE
        </div>
        <h6>CONNECTIVITY</h6>
        <div class="one">
            <input type="checkbox" name="connect" value="wired"> WIRED <br>
            <input type="checkbox" name="connect" value="wireless"> WIRELESS
        </div>
        <h6>AGE</h6>
        <div class="one">
            <input type="checkbox" name="age" value="10"> < 10years<br>
            <input type="checkbox" name="age" value="20"> 10-20 years <br>
            <input type="checkbox" name="age" value="30"> 20-30 years<br>
            <input type="checkbox" name="age" value="40"> 30-40 years <br>
            <input type="checkbox" name="age" value="50"> > 40 years
        </div>
        <h6>TYPE</h6>
        <div class="one">
            <input type="checkbox" name="type" value="onEar"> ON Ear<br>
            <input type="checkbox" name="type" value="overEar"> Over Ear <br>
        </div>
        <h6>MUSIC PREFERENCE</h6>
        <div class="one">
            <input type="checkbox" name="music" value="base"> BASE<br>
            <input type="checkbox" name="music" value="baseless"> BASELESS<br>
        </div>
        <button type="submit">GET</button>
    </form>
</div>

<div class="right-col">
    <div class="container-fluid">
        <div class="row">
            <% while(rs.next()){ %>
            <div class="col col-lg-4">
                <div style="margin:30px" class="card" style="width: 18rem;">
                    <img height="250px" src="h.jpg" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title"><%= rs.getString("name") %></h5>
                        <p class="card-text">COLOR:<%= rs.getString("color") %></p>
                        <p class="card-text">Type:<%= rs.getString("type") %></p>
                        <form action="viewDescription.jsp" method="post">
                            <button class="btn btn-dark" type="submit" value="<%=rs.getString("pid")%>" name="product-des">View Details</button>
                        </form>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
</div>
</body>
<script>
var search=document.getElementById("search-bar")
</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</html>