<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
    <title>Manager</title>
</head>
<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    HttpSession ses=request.getSession();
    String id= (String) ses.getAttribute("id");
    if(id!=null){
        response.sendRedirect("product.jsp");
    }
%>
<body>
<section id="main-section">
    <div id="cont" class="container-fluid">
        <div id="row-col" class="row">
            <div class="col-lg-6 col-sm-12">
                <div class="login-left">
                    <img width="350px" height="300px" src="apthamitra.JPG" alt="">
                </div>
            </div>
            <div class="col-lg-6 col-sm-12">
                <div class="login-right">
                    <p><strong>Please enter Id and Password</strong></p>
                    <form method="post" id="form-id">
                        <span class="login-text"><strong>Id</strong></span><br>
                        <input id="id-text" class="login-text" name="id" type="text" onblur="checkId()"><br><br>
                        <span class="login-text"><strong>Password</strong></span><br>
                        <input id="password-text" class="login-text" name="password" type="password" onblur="checkpassword()"><br><br>
                        <button type="submit" id="btn-id" class="btn btn-dark">Log in</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    var btn=document.getElementById('btn-id');
    btn.style.visibility='hidden';
    var id=document.getElementById("id-text");
    var password=document.getElementById("password-text");

    function checkId(){
        var data=id.value;
        data=data.trim();
        console.log(data);
        if(data.length === 5){
            btn.style.visibility = 'visible';
        }
    }

    function checkpassword() {
        if (password.value.length === 0) {
            console.log("please enter the password")
        }else{
            var form_id=document.getElementById("form-id");
            form_id.setAttribute("action","manager");
        }
    }
</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</body>
</html>