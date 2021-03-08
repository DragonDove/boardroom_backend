<#include "template.ftl" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>会议列表</title>
    <@style />
</head>
<body>

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-heading p-10">
            <h2 class="ml-5">会议列表</h2>
        </div>
        <hr style="width: 95%" class="mt-1">
        <div class="card-content p-10 ml-5 mb-5">
            <div id="meetingTable" class="datagrid">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="roomSearch" style="margin-bottom: 10px; max-width: 300px">
                    <input id="inputSearchExample2" type="search" class="form-control search-input" placeholder="搜索">
                    <label for="inputSearchExample2" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                </div>
                <div class="datagrid-container"></div>
                <div class="pager"></div>
            </div>
        </div>

    </div>
</div>

<@script />
<script>
    const meetingTable = $('#meetingTable')
    let meetings = []
    fetch('/user/meetings?id=' + ${user.id}).then(response => response.json()).then(json => {
        meetings = json.extras.meetings
    }).then(function () {
        meetings.forEach(meeting => {
            if (null === meeting.leader) {
                meeting.leaderName = ''
            } else {
                meeting.leaderName = meeting.leader.realName
            }
            if (null === meeting.room) {
                meeting.roomName = ''
            } else {
                meeting.roomName = meeting.room.name
            }
            switch (meeting.state) {
                case 0:
                    meeting.state = '审核中'
                    break
                case 1:
                    meeting.state = '已通过'
                    break
                case 2:
                    meeting.state = '进行中'
                    break
                case 3:
                    meeting.state = '已结束'
                    break
                case 4:
                    meeting.state = '已拒绝'
                    break
                case 5:
                    meeting.state = '审核超时'
                    break
                default:
                    meeting.state = '异常'
            }
            meeting.name = '<a href="/meetingPage?id=' + meeting.id + '">' + meeting.name + '</a>'
        })
        meetingTable.datagrid({
            dataSource: {
                cols: [
                    {name: 'id', label: '会议编号'},
                    {name: 'name', label: '会议名称'},
                    {name: 'leaderName', label: '会议发起人'},
                    {name: 'roomName', label: '会议地点'},
                    {name: 'startTime', label: '开始时间'},
                    {name: 'endTime', label: '结束时间'},
                    {name: 'state', label: '会议状态'}
                ],
                array: meetings
            },
            configs: {
                C2: {html: true}
            },
            states: {
                pager: {page: 1, recPerPage: 10}
            },
            height: 'page'
        })
    })



</script>

</body>
</html>