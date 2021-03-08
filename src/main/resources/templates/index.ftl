<#include "template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>首页 | 会议室预约管理系统</title>
    <@style />
</head>

<body>
<!--[if lt IE 8]>
<div class="alert alert-danger">您正在使用 <strong>过时的</strong> 浏览器. 是时候 <a href="https://browsehappy.com/">更换一个更好的浏览器</a>
    来提升用户体验.
</div>
<![endif]-->
<#--<header class="custom-nav">-->

    <#--<a class="custom-nav-brand" href="#">-->
        <#--<img class="brand-image" src="/img/logo.png" alt="logo">-->
        <#--<span class="ml-2">会议室预约网页端</span>-->
    <#--</a>-->

    <#--<div class="navbar-collapse">-->

        <#--<ul class="custom-navbar">-->
            <#--<li class="active"><a id="closeLink" href="#"><i class="icon icon-off icon-2x"></i></a></li>-->
            <#--<li><a href="javascript: myTabs.open({url: '/informationPage', id: '9', icon: 'icon-user'});">-->
                    <#--<div class="nav-user">-->
                        <#--<i class="icon icon-user ml-2"></i>-->
                        <#--<span class="mr-3">-->
                            <#--<@shiro.user><@shiro.principal property="username" /></@shiro.user>-->
                            <#--<@shiro.guest>Admin</@shiro.guest>-->
                        <#--</span>-->
                    <#--</div>-->
                <#--</a></li>-->
        <#--</ul>-->
    <#--</div>-->
<#--</header>-->

<nav class="left-nav">
    <div class="logo">
        <a class="custom-nav-brand" href="#">
            <img class="brand-image" src="/img/logo.png" alt="logo"/>
            <h3 style="display: inline-block">会议室预约管理系统</h3>
        </a>
    </div>
    <ul class="admin-menu">
        <li class="level">
            <h3 data-toggle="collapse" class="collapsed"  data-target="#contentManagement">会议管理</h3>
            <ul class="collapse levelnext" id="contentManagement">
                <li><a href="javascript: myTabs.open({url: '/meetingListPage', id: '1', icon: 'icon-home'});">
                        <i class="icon icon-home"></i> 我的会议列表</a>
                </li>
                <li><a href="javascript: myTabs.open({url: '/meetingRequestPage', id: '2', icon: 'icon-user'});">
                        <i class="icon icon-user"></i> 发起会议</a>
                </li>
            </ul>
        </li>
        <li class="level">
            <h3 data-toggle="collapse" class="collapsed"  data-target="#messageManagement">消息管理</h3>
            <ul class="collapse levelnext" id="messageManagement">
                <li><a href="javascript: myTabs.open({url: '/remindPage', id: '3', icon: 'icon-check'});">
                        <i class="icon icon-check"></i> 我的消息
                    </a></li>
            </ul>
        </li>
    </ul>
</nav>

<div id="tabpanel" class="center-nav">
</div>

<div class="bottom-nav" align="center">
    <dfn class="">copyright&copy;复读机真香团队</dfn>
</div>
<div class="loginfo">
    <img src="/img/user.png" width="30px" height="30px">
    <div class="myhidden">
        <ul class="custom-navbar">

            <li class="active"><a id="closeLink" href="#">
                    <i class="icon icon-off ml-2"></i>
                    <span>
                    注销登录
                </span></a></li>

            <li><a href="javascript: myTabs.open({url: '/informationPage', id: '9', icon: 'icon-user'});">

                    <i class="icon icon-user ml-2"></i>
                    <span>
                           修改信息
                        </span>

                </a></li>
            <@shiro.hasPermission name="meeting:approve">
                <li class="active"><a id="closeLink" href="/manage">
                        <i class="icon icon-cog ml-2"></i>
                        <span>
                    进入管理
                </span></a></li>
            </@shiro.hasPermission>

        </ul>
    </div>
</div>
<@script />
<script>

    const closeBtn = document.getElementById('closeLink')
    const tabpanel = $('#tabpanel')
    let tabs = [{
        title: '我的会议列表',
        id: '1',
        url: '/meetingListPage',
        icon: 'icon-cube',
        type: 'iframe',
        forbidClose: true
    }]
    tabpanel.tabs({tabs: tabs})
    const myTabs = tabpanel.data('zui.tabs')
    closeBtn.addEventListener('click', function () {
        fetch('/user/logout', {method: 'POST'}).then(response => response.json()).then(
            json => {
                if (200 === json.code) {
                    window.location.href = '/'
                } else {
                    alert('注销失败，系统出错' + json.msg)
                }
            }
        )
        window.location.href = "/"
    })

</script>

</body>
</html>