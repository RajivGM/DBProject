var invalid=document.getElementById('invalid');
var email=document.getElementsByClassName("email-data")[0];
var password=document.getElementsByClassName("password-data")[0];
var first=document.getElementsByClassName("first-data")[0];
var last=document.getElementsByClassName("last-data")[0];
var address=document.getElementsByClassName("address-data")[0];
var place=document.getElementById('location-data');
var submit=document.getElementById('button');
var click_sumbit=true;
submit.addEventListener("click",sendData);
var p=document.createElement('p');
invalid.appendChild(p);

function data(email,password,first,last,address,location){
    this.email=email;
    this.password=password;
    this.first=first;
    this.last=last;
    this.address=address;
    this.location=location;
}

function checkdata(){
    if(email.value===""){
        p.innerText="Please enter Email"
        return false;
    }else if(password.value===""){
        p.innerText="Please enter Password";
        return false;
    }else if(first.value===""){
        p.innerText="Please enter FIRST NAME";
        return false;
    }else if(address.value===""){
        p.innerText="Please enter Address"
        return false;
    }
    return true;
}


function sendData() {
    var jsonData;
    var xhttp = new XMLHttpRequest();
    if (click_sumbit === true && checkdata()) {
        var obj1 = new data(email.value, password.value, first.value, last.value, address.value, place.options[place.selectedIndex].text);
        jsonData = JSON.stringify(obj1);
        console.log(jsonData);
        xhttp.open("POST", "enroll", true);
        xhttp.send(jsonData);
  }
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            var rt = this.responseText;
            if (rt.trim()==="SUCCESSFUL") {
                click_sumbit = false;
                p.innerText=rt;
                window.sessionStorage.setItem("enroll",jsonData);
                window.location.href="enroll_confirmation.jsp";
            }else{
                p.innerText=rt;
            }
        }
    }
}