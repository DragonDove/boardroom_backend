<#include "template.ftl">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <@style />
    <title>发起会议</title>
    <style>
        .nav-tabs li{
            border: solid 1px #353535;
        }
    </style>
</head>
<body>


<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-heading p-10">
            <h2 class="ml-5">发起会议</h2>
        </div>
        <hr style="width: 100%" class="mt-1">
        <div class="card-content p-10 ml-5 mb-5">
            <div class="p-10">
                <div class="row">
                    <div class="col-xs-3" style="margin-top: 20px">
                        <ul class="nav nav-tabs nav-stacked">
                            <li class="active"><a href="javascript:" data-target="#findByRoom" data-toggle="tab">
                                    按房间发起会议</a></li>
                            <li><a href="javascript:" data-target="#findByTime" data-toggle="tab">
                                    按时间寻找房间
                                </a></li>
                        </ul>
                    </div>
                    <div class="col-xs-9" style="margin-top: -40px;">
                        <div class="tab-content">
                            <div class="tab-pane fade active in" id="findByRoom">
                                <h3>会议室列表</h3>
                                <hr>
                                <#list rooms as room>
                                    <a href="/roomPage?id=${room.id}" class="col-xs-3 btn btn-primary">${room.name}</a>
                                </#list>
                            </div>
                            <div class="tab-pane fade" id="findByTime">
                                <h3>请选择日期及起止时间</h3>
                                <hr>
                                <div>
                                    <div class="col-xs-4 form-group">
                                        <label for="datePickInput">选择日期</label>
                                        <input type="text" class="form-control" id="datePickInput" readonly=""
                                               style="background-color: #ffffff;">
                                    </div>
                                    <div class="col-xs-4 form-group">
                                        <label for="startTimePickInput">选择开始时间</label>
                                        <input type="text" class="form-control" id="startTimePickInput" readonly=""
                                               style="background-color: #ffffff;">
                                    </div>
                                    <div class="col-xs-4 form-group">
                                        <label for="endTimePickInput">选择结束时间</label>
                                        <input type="text" class="form-control" id="endTimePickInput" readonly=""
                                               style="background-color: #ffffff;">
                                    </div>
                                    <p class="text-right">
                                        <button id="queryAvailable" class="btn btn-primary">查询</button>
                                    </p>
                                    <div id="roomContainer">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<@script />

<script>

    const queryButton = document.getElementById('queryAvailable')

    const roomContainer = document.getElementById('roomContainer')

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

    queryButton.addEventListener('click', function () {
        let day = $('#datePickInput').val()
        let startTime = $('#startTimePickInput').val()
        let endTime = $('#endTimePickInput').val()

        fetch('/room/available?startTime=' + day + ' ' + startTime + ':00' + '&endTime=' +
            day + ' ' + endTime + ':00').then(response => response.json()).then(json => {
            if (200 === json.code) {
                let rooms = json.extras.rooms
                roomContainer.innerHTML = ''
                rooms.forEach(room => {
                    roomContainer.innerHTML += '<a href="/roomPage?id=' + room.id + '" class="col-xs-3 btn btn-primary">' + room.name + '</a>'
                })
            } else {
                alert(json.msg)
            }
        })
    })

</script>

</body>
</html>