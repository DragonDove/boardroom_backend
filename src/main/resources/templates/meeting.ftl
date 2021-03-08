<#include "template.ftl" />
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>会议详情</title>
    <@style />

</head>
<body>

<div class="container mt-5">
    <div class="card shadow-sm p-10">
        <div class="card-content">
            <h2 id="roomName">会议名称: ${meeting.name}</h2>
        </div>
        <div class="card-content">
            <div class="row">
                <h5 class="col">详细信息:</h5>
            </div>
        </div>
        <div class="card-body">
            <div class="cards">
                <div class="col-md-4 col-sm-6 col-lg-3">
                    <div class="card">
                        <img height="262.5px" width="262.5px" class="img-rounded" src="${"/" + meeting.leader.photoPath}" alt="">
                        <div class="card-heading"><strong>会议发起人：${meeting.leader.realName}</strong></div>
                        <div class="card-content text-muted">
                            联系电话：${meeting.leader.phone}
                            <p>email: ${meeting.leader.email!}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 col-sm-6 col-lg-9">
                    <div class="card">
                        <div class="p-10">
                            <div>会议编号：${meeting.id}</div>
                            <div>会议地点：${meeting.room.location}</div>
                            <div>房间名称：${meeting.room.name}</div>
                            <div>开始时间：${meeting.startTime}</div>
                            <div>结束时间：${meeting.endTime}</div>
                            <div>会议描述：<p>${meeting.description!}</p></div>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <h5>与会人员列表:</h5>
            <div class="cards">
                <#list meeting.userMeetings as userMeeting>
                    <div class="col-md-4 col-sm-6 col-lg-3">
                        <div class="card">
                            <#--  <img height="262.5px" width="262.5px" class="img-rounded" src="${"/" + userMeeting.user.photoPath!}" alt="">  -->
                            <div class="card-heading"><strong>姓名：${userMeeting.user.realName}</strong></div>
                            <div class="card-content text-muted">
                                联系电话：${userMeeting.user.phone}
                                <p>email: ${userMeeting.user.email!}</p>
                                签到状况：<#if userMeeting.registered>
                                <strong class="text-green">已签到</strong>
                            <#else>
                                <strong class="text-info">未签到</strong>
                                </#if>

                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        </div>
    </div>
    <div class="text-right">
        <a href="javascript: history.back(-1)" class="btn btn-info mt-2">返回</a>
    </div>
</div>


<@script />
<script>

</script>
</body>
</html>