<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>后台首页</title>
    <@style />

</head>

<body>
    <div class="p-10">
        <blockquote>
            欢迎来到会议室预约管理系统后台管理页面。
        </blockquote>
        <div class="dashboard" data-height="300">
            <section class="row">
                <div class="col-md-5 col-sm-6">
                    <div class="panel" data-id="1" style="height: 280px;">
                        <div class="panel-heading">
                            <i class="icon icon-branch"></i>
                            <span class="title">系统组织</span>
                        </div>
                        <div class="panel-body">
                            <div id="treemapView" class="treemap">
                                <ul class="treemap-data hide">
                                    <li>
                                        会议室预约管理系统
                                        <ul>
                                            <li>
                                                后台服务器
                                                <ul>
                                                    <li>用户照片存储</li>
                                                    <li>用户权限管制</li>
                                                </ul>
                                            </li>
                                            <li>
                                                后台管理
                                                <ul>
                                                    <li>会议室管理</li>
                                                    <li>员工管理</li>
                                                    <li>权限管理</li>
                                                </ul>
                                            </li>
                                            <li>
                                                前端
                                                <ul>
                                                    <li>人脸识别</li>
                                                    <li>数据交互</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-7 col-sm-6">
                    <div class="panel" style="height: 280px;">
                        <div class="panel-heading">
                            <i class="icon icon-dashboard"></i>
                            <span class="title">系统状况</span>
                        </div>
                        <div class="panel-body">
                            <div class="col-md-4">
                                <div id="pastMeetingPanel" class="list-group">
                                    <p class="list-group-item">已过期</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div id="currentMeetingPanel" class="list-group">
                                    <p class="list-group-item">进行中</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div id="scheduledMeetingPanel" class="list-group">
                                    <p class="list-group-item">即将进行</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="panel" data-id="1" style="height: 350px;">
                        <div class="panel-heading">
                            <i class="icon icon-circle-blank"></i>
                            <span class="title">使用率最高的房间</span>
                        </div>
                        <div class="panel-body">
                            <div id="supplier" style="height: 300px; padding: 10px;">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="panel" data-id="1" style="height: 350px;">
                        <div class="panel-heading">
                            <i class="icon icon-line-chart"></i>
                            <span class="title">一周内签到率</span>
                        </div>
                        <div class="panel-body">
                            <div id="lineChart" style="height: 300px; padding: 10px;">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="panel" data-id="1" style="height: 350px;">
                        <div class="panel-heading">
                            <i class="icon icon-bar-chart-alt"></i>
                            <span class="title">一周内会议请求数</span>
                        </div>
                        <div class="panel-body">
                            <div id="barChart" style="height: 300px; padding: 10px;">
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <@script />
    <script>
    $('#treemapView').treemap()
    const pastMeetingPanel = document.getElementById("pastMeetingPanel")
    const currentMeetingPanel = document.getElementById("currentMeetingPanel")
    const scheduledMeetingPanel = document.getElementById("scheduledMeetingPanel")
    fetch('/meeting/today').then(response => response.json()).then(json => {
        if (200 === json.code) {
            const meetings = json.extras.meetings
            meetings.forEach(meeting => {
                const nodeA = document.createElement('a')
                nodeA.setAttribute('href', '/meetingPage?id=' + meeting.id)
                nodeA.setAttribute('class', 'list-group-item')
                const nodeH = document.createElement('h4')
                nodeH.setAttribute('class', 'list-group-item-heading')
                nodeH.innerText = meeting.name
                const nodeP = document.createElement('p')
                nodeP.setAttribute('class', 'list-group-item-text text-muted')
                nodeP.innerText = meeting.room.name
                nodeA.appendChild(nodeH)
                nodeA.appendChild(nodeP)
                switch (meeting.state) {
                    case 1:
                        scheduledMeetingPanel.appendChild(nodeA)
                        break
                    case 2:
                        currentMeetingPanel.appendChild(nodeA)
                        break
                    case 3:
                        pastMeetingPanel.appendChild(nodeA)
                        break
                }
            })
        } else {
            alert('数据获取异常，请检查后台日志')
        }
    })
    fetch('/room/most').then(response => response.json()).then(json => {
        echarts.init(document.getElementById('supplier')).setOption({
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data: json.extras.count.map(item => item.name)
            },
            series: [{
                name: '总占用比',
                type: 'pie',
                radius: ['50%', '70%'],
                avoidLabelOverlap: false,
                label: {
                    normal: {
                        show: false,
                        position: 'center'
                    },
                    emphasis: {
                        show: true,
                        textStyle: {
                            fontSize: '30',
                            fontWeight: 'bold'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data: json.extras.count,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }]
        })
    })

    fetch('/meeting/registerRate').then(response => response.json()).then(json => {
        let rates = json.extras.rate
        let rateList = [0, 0, 0, 0, 0, 0, 0]
        rates.forEach(rate => rateList[rate.name - 1] = rate.value)
        echarts.init(document.getElementById('lineChart')).setOption({
            tooltip: {
                trigger: 'item',
                formatter: "{b} : {c}%"
            },
            xAxis: {
                type: 'category',
                data: ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: rateList,
                type: 'line'
            }]
        })
    })

    fetch('/meeting/count/week').then(response => response.json()).then(json => {
        let counts = json.extras.count
        let countList = [0, 0, 0, 0, 0, 0, 0]
        counts.forEach(count => countList[count.name - 1] = count.value)
        echarts.init(document.getElementById('barChart')).setOption({
            xAxis: {
                type: 'category',
                data: ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                label: {
                    normal: {
                        show: true,
                        position: 'inside'
                    }
                },
                data: countList,
                type: 'bar'
            }]
        })
    })


    </script>
</body>

</html>