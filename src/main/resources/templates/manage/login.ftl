<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>登录 | 会议室预约管理系统</title>
    <@style />
    <style>
        body {
            background-image: url("/img/loginbg.png");
            background-size: cover;
        }
    </style>
</head>

<body>
<div class="all">
    <div class="loginbox-bg">

    </div>
    <div class="loginbox">
        <div class="login">
            <div class="logo"></div>
            <p class="logintext">欢迎登录管理系统</p>
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

</div>

    <@script />
    <script>
    let loginBtn = document.getElementById('loginBtn')
    loginBtn.addEventListener('click', function() {
        login();
    })
    $("#passwordInput").keypress(function(event){
        var keynum = (event.keyCode ? event.keyCode : event.which);
        if(keynum == '13'){
            login();
        }
    });
        function login() {
            let formData = new FormData()
            formData.append('username', document.getElementById('usernameInput').value)
            formData.append('password', document.getElementById('passwordInput').value)
            fetch('/user/login', {method: 'POST', body: formData}).then(
                response => response.json()
        ).then(json => {
                if (200 === json.code) {
                window.location.href = '/manage/index'
            } else {
                alert(json.msg)
            }
        })
        }
    </script>
</body>

</html>