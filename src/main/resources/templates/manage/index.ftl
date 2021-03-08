<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>主页 | 会议室预约管理系统</title>
    <@style />
</head>

<body>
    <!--[if lt IE 8]>
    <div class="alert alert-danger">您正在使用 <strong>过时的</strong> 浏览器. 是时候 <a href="https://browsehappy.com/">更换一个更好的浏览器</a> 来提升用户体验.</div>
    <![endif]-->
    <#--<header class="custom-nav">-->

        <#--<a class="custom-nav-brand" href="#">-->
            <#--<img class="brand-image" src="/mg/logo.png" alt="logo">-->
            <#--<span class="ml-2">会议室预约后台管理系统</span>-->
        <#--</a>-->

        <#--<div class="navbar-collapse">-->

            <#--<ul class="custom-navbar">-->
                <#--<li class="active"><a id="closeLink" href="#"><i class="icon icon-off icon-2x"></i></a></li>-->
                <#--<li><a href="javascript: myTabs.open({url: '/manage/passwordChangePage', id: '9', icon: 'icon-user'});">-->
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
                <h3 data-toggle="collapse" class="collapsed" data-target="#contentManagement">内容管理</h3>
                <ul class="collapse levelnext" id="contentManagement">
                    <li><a href="javascript: myTabs.open({url: '/manage/roomListPage', id: '2', icon: 'icon-home'});">
                        <i class="icon icon-home"></i> 会议室管理</a>
                    </li>
                    <li><a href="javascript: myTabs.open({url: '/manage/userListPage', id: '3', icon: 'icon-user'});">
                        <i class="icon icon-user"></i> 员工管理</a>
                    </li>
                    <li><a href="javascript: myTabs.open({url: '/manage/permissionManagementPage', id: '4', icon: 'icon-lock'});">
                        <i class="icon icon-lock"></i> 权限管理</a>
                    </li>
                </ul>
            </li>
            <li class="level">
                <h3 data-toggle="collapse" class="collapsed" data-target="#messageManagement">会议管理</h3>
                <ul class="collapse levelnext" id="messageManagement">
                    <li><a href="javascript: myTabs.open({url: '/manage/meetingRequestPage', id: '5', icon: 'icon-check'});">
                        <i class="icon icon-check"></i> 会议申请
                        <span id="meetingRequireNumber" class="label label-badge label-success" style="display: inline;">?</span>
                    </a></li>
                    <li><a href="javascript: myTabs.open({url: '/manage/meetingListPage', id: '6', icon: 'icon-cube'});">
                        <i class="icon icon-cube"></i> 会议列表

                    </a></li>
                    <#--<li><a href="javascript: myTabs.open({url: '/feedbackPage', id: '6', icon: 'icon-history'});">-->
                        <#--<i class="icon icon-history"></i> 反馈消息-->
                        <#--<span class="label label-badge label-warning" style="display: inline;">3</span>-->
                    <#--</a></li>-->
                </ul>
            </li>
            <li class="level">
                <h3 data-toggle="collapse" class="collapsed" data-target="#systemManagement">系统管理</h3>
                <ul class="collapse levelnext" id="systemManagement">
                    <li><a href="javascript: myTabs.open({url: '/manage/systemConfigPage', id: '7', icon: 'icon-cog'});">
                        <i class="icon icon-cog"></i> 系统信息</a></li>
                    <li><a href="javascript: myTabs.open({url: '/manage/systemLogPage', id: '8', icon: 'icon-file-text'});">
                        <i class="icon icon-file-text"></i> 系统日志
                        <#--<span class="label label-badge label-danger" style="display: inline;">284</span>-->
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
        <li><a href="javascript: myTabs.open({url: '/manage/passwordChangePage', id: '9', icon: 'icon-user'});">

                    <i class="icon icon-user ml-2"></i>
                    <span>
                           修改密码
                        </span>

            </a></li>
    </ul>
</div>
</div>
    <@script />
    <script>

        const closeBtn = document.getElementById('closeLink')
        const tabpanel = $('#tabpanel')
        let tabs = [{
            title: '后台首页',
            id: '1',
            url: '/manage/mainPage',
            icon: 'icon-star',
            type: 'iframe',
            forbidClose: true
        }];
        tabpanel.tabs({tabs: tabs})
        const myTabs = tabpanel.data('zui.tabs')
        closeBtn.addEventListener('click', function () {
            fetch('/user/logout', {method: 'POST'}).then(response => response.json()).then(
                json => {
                    if (200 === json.code) {
                        window.location.href = '/manage'
                    } else {
                        alert('注销失败，请查看系统日志')
                    }
                }
            )
            window.location.href = "/manage"
        })
        const meetingRequireNumber = document.getElementById('meetingRequireNumber')
        setInterval(function () {
            fetch('/meeting/count?state=0').then(response => response.json()).then(json => {
                if (200 === json.code) {
                    if (meetingRequireNumber.innerText !== json.extras.count.toString()) {
                        meetingRequireNumber.innerText = json.extras.count
                        myTabs.reload(myTabs.getTab('5'))
                    }
                } else {
                    alert('api "/meeting/count?state=0" 异常，请检查系统日志')
                }
            })
        }, 2000)


    </script>

</body>
</html>