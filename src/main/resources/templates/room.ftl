<#include "template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>房间信息</title>
    <@style />
</head>

<body>
<div class="container mt-5">
    <div class="card shadow-sm p-10">
        <div class="card-content">
            <h2 id="roomName">房间名称: ${room.name}</h2>
        </div>
        <div class="card-content">
            <h4 id="roomDescription">房间配置：<#if room.microphoneAvailable>话筒</#if>
                <#if room.projectorAvailable>投影仪</#if></h4>
        </div>
        <div class="card-content">
            <div class="row">
                <h5 class="col">时间安排:</h5>
                <span class="text-right col">
                    <button id="newScheduleBtn" class="btn btn-primary" data-toggle="modal"
                            data-target="#newScheduleModal">新增会议</button>
                </span>
            </div>
        </div>
        <div class="card-body">
            <div id="calendar" class="calendar">
            </div>
        </div>
    </div>
    <div class="text-right">
        <a href="/meetingRequestPage" class="btn btn-info mt-2">返回</a>
    </div>
</div>
<!-- 新增会议对话框 -->
<div class="modal fade" id="newScheduleModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">新增会议</h3>
            </div>
            <div class="modal-body">
                <div>
                    <div class="form-group">
                        <label for="nameInput">会议名称</label>
                        <input type="text" class="form-control" id="nameInput" required>
                    </div>
                    <div class="form-group">
                        <label for="datePickInput">选择日期</label>
                        <input type="text" class="form-control" id="datePickInput" readonly=""
                               style="background-color: #ffffff;">
                    </div>
                    <div class="form-group">
                        <label for="timePickInput">选择开始时间</label>
                        <input type="text" class="form-control" id="startTimePickInput" readonly=""
                               style="background-color: #ffffff;">
                    </div>
                    <div class="form-group">
                        <label for="timePickInput">选择结束时间</label>
                        <input type="text" class="form-control" id="endTimePickInput" readonly=""
                               style="background-color: #ffffff;">
                    </div>
                    <div class="form-group">
                        <label for="descriptionInput">描述</label>
                        <input type="text" class="form-control" id="descriptionInput">
                    </div>
                    <div class="form-group">
                        <label for="departmentSelect">选择与会人员</label>
                        <select name="" id="departmentSelect" class="form-control">

                        </select>
                    </div>
                    <div id="userCheckboxDiv" class="form-group">

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="scheduleSubmitBtn" type="button" class="btn btn-primary">提交</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<@script />
<script>
    const calendarView = $('#calendar')
    const leaderSelectButton = document.getElementById('leaderSelectButton')
    const newScheduleBtn = document.getElementById('newScheduleBtn')
    const scheduleSubmitBtn = document.getElementById('scheduleSubmitBtn')
    const departmentSelect = document.getElementById('departmentSelect')
    const userCheckboxDiv = document.getElementById('userCheckboxDiv')
    calendarView.calendar({dragThenDrop: false, lang: 'zh_cn'})
    const calendar = calendarView.data('zui.calendar')
    let departments = null
    let users = null
    let userCheckboxes = null
    let userCheckboxLabels = null
    fetch('/room/meetings?id=' + ${room.id}).then(response => response.json()).then(json => {
        let calendarEvents = []
        json.extras.meetings.forEach(meeting => {
            calendarEvents.push({
                title: meeting.name,
                desc: meeting.description,
                start: meeting.startTime,
                end: meeting.endTime
            })
        })
        calendar.addEvents(calendarEvents)
    })

    function refreshuserCheckboxDiv() {
        userCheckboxDiv.innerHTML = ''
        const nowDepartmentId = departmentSelect.value
        userCheckboxLabels.forEach(label => {
            if (label.getAttribute('dId') === nowDepartmentId) {
                userCheckboxDiv.appendChild(label)
            }
        })
    }

    newScheduleBtn.addEventListener('click', function () {
        if (null === departments) {
            fetch('/department/all').then(response => response.json()).then(json => {
                departments = json.extras.departments
                departments.forEach(department => {
                    const option = document.createElement('option')
                    option.value = department.id
                    option.innerText = department.name
                    departmentSelect.appendChild(option)
                })
            })
        }

        if (null === users) {
            fetch('/user/all').then(response => response.json()).then(json => {
                users = json.extras.users
                if (null === userCheckboxes) {
                    userCheckboxes = []
                    userCheckboxLabels = []
                    users.forEach(user => {
                        const label = document.createElement('label')
                        label.setAttribute('class', 'checkbox-inline')
                        label.setAttribute('dId', user.department.id.toString())
                        const checkbox = document.createElement('input')
                        checkbox.setAttribute('type', 'checkbox')
                        checkbox.setAttribute('uId', user.id)
                        label.appendChild(checkbox)
                        label.appendChild(document.createTextNode(user.realName))
                        userCheckboxes.push(checkbox)
                        userCheckboxLabels.push(label)
                    })
                }
            }).then(refreshuserCheckboxDiv)
        }
    })

    departmentSelect.onchange = refreshuserCheckboxDiv

    $('#datePickInput').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0,
        format: 'yyyy-mm-dd'
    })

    $('#startTimePickInput').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 0,
        autoclose: 1,
        todayHighlight: 1,
        startView: 1,
        minView: 0,
        maxView: 1,
        forceParse: 0,
        format: 'hh:ii'
    })

    $('#endTimePickInput').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 0,
        autoclose: 1,
        todayHighlight: 1,
        startView: 1,
        minView: 0,
        maxView: 1,
        forceParse: 0,
        format: 'hh:ii'
    })

    scheduleSubmitBtn.addEventListener('click', function () {
        let name = document.getElementById('nameInput').value
        let day = $('#datePickInput').val()
        let startTime = $('#startTimePickInput').val()
        let endTime = $('#endTimePickInput').val()
        let description = document.getElementById('descriptionInput').value
        let users = []
        if ('' === day || '' === startTime || '' === endTime) {
            bootbox.alert('请选择时间')
        }
        userCheckboxes.forEach(userCheckBox => {
            if (userCheckBox.checked) {
                users.push({id: userCheckBox.getAttribute('uId')})
            } else {
                if (userCheckBox.uId === ${user.id}) {
                    userMeetings.push({id: ${user.id}})
                }
            }
        })
        let meeting = {}
        meeting.name = name
        meeting.leader = {id: ${user.id}}
        meeting.room = {id: ${room.id}}
        meeting.startTime = day + ' ' + startTime + ':00'
        meeting.endTime = day + ' ' + endTime + ':00'
        meeting.state = 0
        meeting.description = description
        fetch('/meeting', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(meeting)
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                const meetingId = json.extras.meeting.id
                fetch('/meeting/users?id=' + meetingId, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(users)
                }).then(response => response.json()).then(json => {
                    if (200 === json.code) {
                        alert('创建成功')
                        window.location.reload()
                    } else {
                        alert(json.msg)
                    }
                })
            } else {
                alert(json.msg)
            }
        })
    })

</script>
</body>

</html>