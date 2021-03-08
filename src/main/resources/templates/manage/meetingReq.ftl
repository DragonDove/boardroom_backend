<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>会议申请</title>
    <@style />
</head>

<body>
    <div class="container mt-5">
        <div class="p-10">
            <ul class="nav nav-primary nav-justified">
                <li id="todoItem" class="active">
                    <a href="javascript:">待处理<span class="label label-badge label-success">${unchecked?size}</span></a>
                </li>
                <li id="doneItem">
                    <a href="javascript:">已处理</a>
                </li>
                <#--<li id="pastItem">-->
                    <#--<a href="javascript:">已过期</a>-->
                <#--</li>-->
            </ul>
            <div id="todoPage" class="mt-5">
                <div id="todoList" class="list-group">
                    <#list unchecked as meeting>
                        <a href="#todoItem${meeting.id?c}" class="list-group-item" data-toggle="collapse">
                            <h4 class="list-group-item-heading">${meeting.room.name}</h4>
                            <p class="list-group-item-text text-muted">${meeting.name}</p>
                        </a>
                        <div class="collapse in" id="todoItem${meeting.id?c}">
                            <div class="bg-gray with-padding">
                                <p>申请人：${meeting.leader.realName}</p>
                                <p>时间：${meeting.startTime} ~ ${meeting.endTime}</p>
                                <div>
                                    <button mId="${meeting.id?c}" class="btn approveButton btn-success">授权</button>
                                    <button mId="${meeting.id?c}" class="btn disapproveButton btn-danger">拒绝</button>
                                    <a href="/meetingPage?id=${meeting.id?c}" class="btn btn-info ml-5">查看详情</a>
                                </div>
                            </div>
                        </div>
                    </#list>
                </div>
            </div>
            <div id="donePage" class="mt-5 hidden">
                <div id="doneList">
                    <#list checked as meeting>
                        <a href="#doneItem${meeting.id?c}" class="list-group-item" data-toggle="collapse">
                            <h4 class="list-group-item-heading">${meeting.room.name}</h4>
                            <p class="list-group-item-text text-muted">${meeting.name}</p>
                        </a>
                        <div class="collapse in" id="doneItem${meeting.id?c}">
                            <div class="bg-gray with-padding">
                                <p>申请人：${meeting.leader.realName}</p>
                                <p>时间：${meeting.startTime} ~ ${meeting.endTime}</p>
                            </div>
                        </div>
                    </#list>
                </div>
            </div>
            <#--<div id="pastPage" class="mt-5 hidden">-->
                <#--<div id="pastList">-->
                    <#--<a href="#pastItem1" class="list-group-item" data-toggle="collapse">-->
                        <#--<h4 class="list-group-item-heading">20-506</h4>-->
                        <#--<p class="list-group-item-text text-muted">JAVA EE高级应用</p>-->
                    <#--</a>-->
                    <#--<div class="collapse in" id="pastItem1">-->
                        <#--<div class="bg-gray with-padding">-->
                            <#--<p>申请人：李四</p>-->
                            <#--<p>时间：2018-12-23 19:00 ~ 2018-12-23 21:00</p>-->
                        <#--</div>-->
                    <#--</div>-->
                    <#--<a href="#pastItem2" class="list-group-item" data-toggle="collapse">-->
                        <#--<h4 class="list-group-item-heading">20-102</h4>-->
                        <#--<p class="list-group-item-text text-muted">物理师范技能大赛</p>-->
                    <#--</a>-->
                    <#--<div class="collapse" id="pastItem2">-->
                        <#--<div class="bg-gray with-padding">-->
                            <#--<p>申请人：张三</p>-->
                            <#--<p>时间：2018-12-23 19:00 ~ 2018-12-23 21:00</p>-->
                        <#--</div>-->
                    <#--</div>-->
                    <#--<a href="#pastItem3" class="list-group-item" data-toggle="collapse">-->
                        <#--<h4 class="list-group-item-heading">22-103</h4>-->
                        <#--<p class="list-group-item-text text-muted">考研数学讲堂</p>-->
                    <#--</a>-->
                    <#--<div class="collapse" id="pastItem3">-->
                        <#--<div class="bg-gray with-padding">-->
                            <#--<p>申请人：张三</p>-->
                            <#--<p>时间：2018-12-23 19:00 ~ 2018-12-23 21:00</p>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
        </div>
    </div>
    <@script />
    <script>
        const todoPage = $('#todoPage')
        const donePage = $('#donePage')
        const pastPage = $('#pastPage')
        const todoItem = $('#todoItem')
        const doneItem = $('#doneItem')
        const pastItem = $('#pastItem')
        const approveButtons = document.getElementsByClassName('approveButton')
        const disapproveButtons = document.getElementsByClassName('disapproveButton')
        todoItem.click(function () {
            todoPage.removeClass('hidden')
            donePage.addClass('hidden')
            pastPage.addClass('hidden')
            $(this).addClass('active')
            doneItem.removeClass('active')
            pastItem.removeClass('active')
        })
        doneItem.click(function () {
            todoPage.addClass('hidden')
            donePage.removeClass('hidden')
            pastPage.addClass('hidden')
            $(this).addClass('active')
            todoItem.removeClass('active')
            pastItem.removeClass('active')
        })
        pastItem.click(function () {
            todoPage.addClass('hidden')
            donePage.addClass('hidden')
            pastPage.removeClass('hidden')
            $(this).addClass('active')
            todoItem.removeClass('active')
            doneItem.removeClass('active')
        })
        console.log(approveButtons.length)
        for (let approveButton of approveButtons) {

            approveButton.addEventListener('click', function () {
                fetch('/meeting/approve?id=' + this.getAttribute('mId')).then(response => response.json()).then(json => {
                    if (200 === json.code) {
                        alert('授权成功')
                        window.location.reload()
                    } else {
                        alert(json.msg)
                    }
                })
            })
        }
        for (let disapproveButton of disapproveButtons) {
            disapproveButton.addEventListener('click', function () {
                fetch('/meeting/disapprove?id=' + this.getAttribute('mId')).then(response => response.json()).then(json => {
                    if (200 === json.code) {
                        alert('授权成功')
                        window.location.reload()
                    } else {
                        alert(json.msg)
                    }
                })
            })
        }

    </script>
</body>

</html>