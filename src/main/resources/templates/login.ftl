<#include "template.ftl" />
<!doctype html>
<html lang="en">
<head>
    <title>登录 | 会议预约系统</title>
    <@style />
    <style>
        body {
            background-image: url("/img/loginbg1.png");
            background-size: cover;
        }
    </style>
</head>

<body>
<div class="loginbox-bg"></div>
<div class="loginbox">
    <div class="login">
        <div class="logo"></div>
        <p class="logintext">欢迎登录预约系统</p>

            <p class="pb-10">
                <input id="usernameInput" class="userinput" type="text" placeholder="用户名"/>
            </p>
            <p class="pb-10">
                <input id="passwordInput" class="userinput" type="password" placeholder="密码"/>
            </p>
            <p class="pb-10">
                <input id="loginBtn" class="userinput" type="button" value="登录"/>
            </p>


    </div>
</div>

<@script />
<script>
    let loginBtn = document.getElementById('loginBtn')
    loginBtn.addEventListener('click', function() {
      login();
    })

    function login() {
        let formData = new FormData()
        formData.append('username', document.getElementById('usernameInput').value)
        formData.append('password', document.getElementById('passwordInput').value)
        fetch('/user/login', {method: 'POST', body: formData}).then(
            response => response.json()
    ).then(json => {
            if (200 === json.code) {
            window.location.href = '/index'
        } else {
            alert(json.msg)
        }
    })
    }

    $("#passwordInput").keypress(function(event){
        var keynum = (event.keyCode ? event.keyCode : event.which);
        if(keynum == '13'){
            login();
        }
    });
</script>
</body>
</html>