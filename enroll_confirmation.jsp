<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
</head>
<body>
<h1 style="text-align: center;color: rgb(4, 33, 97);">
    THANK YOU!
</h1>
<h3 style="text-align: center;color: rgb(4, 33, 97);font-family: Georgia, 'Times New Roman', Times, serif;margin-block-start: 2em">
    Your details have been successfully recorded.
</h3>
<p style="text-align: center;color:rgb(4, 33, 97);font-size: x-large">Your unique ID:<span id="thi"></span></p>
<p style="text-align: center;color:rgb(4, 33, 97);font-size: x-large">Do NOT reload the page</p>
<p style="text-align: center;color:rgb(4, 33, 97);font-size: x-large">Take note of the unique id</p>
<form method="post" class="text-center" action="manager.jsp">
    <button class="btn btn-dark" type="submit">LOGIN</button>
</form>
<script>
    var check=true;
    var data;
    var obj;
    if(check){
        document.addEventListener("DOMContentLoaded",dothis);
        check=false;
    }
    function dothis() {
        if(window.sessionStorage.getItem("enroll")!=null){
            data = window.sessionStorage.getItem("enroll");
            sessionStorage.clear();
            obj = JSON.parse(data);
            console.log(obj);
        }else {
            window.location.href="Error.jsp";
        }
        var xhttp=new XMLHttpRequest();
        xhttp.onreadystatechange=function () {
            var obj=JSON.parse(xhttp.responseText);
            document.getElementById("thi").innerText = obj.id;
        }
        xhttp.open("POST",'enrollConfirmation',true);
        xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
         xhttp.send("enrollData="+data);
    }
</script>
</body>
</html>
