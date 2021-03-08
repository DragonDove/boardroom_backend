<#include "template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>我的消息</title>
    <@style />
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
            <h2 class="ml-5">我的消息</h2>
        </div>
        <hr style="width: 95%" class="mt-1">
        <div class="card-content p-10 ml-5 mb-5">
            <div class="p-10">
                <div class="row">
                    <div class="col-xs-3">
                        <ul class="nav nav-tabs nav-stacked">
                            <li class="active"><a href="javascript:" data-target="#unreadContent" data-toggle="tab">
                                    未读消息<span class="label label-badge label-success" style="display: inline;">${unreads?size}</span></a></li>
                            <li><a href="javascript:" data-target="#readContent" data-toggle="tab">全部消息</a></li>
                        </ul>
                    </div>
                    <div class="col-xs-9">
                        <div class="tab-content">
                            <div class="tab-pane fade active in" id="unreadContent">
                                <div id="unreadList" class="list-group">
                                    <#list unreads as unread>
                                        <a href="#unreadItem${unread.id?c}" class="list-group-item" data-toggle="collapse">
                                            <h4 class="list-group-item-heading">消息通知</h4>
                                            <p class="list-group-item-text text-muted">${unread.time}</p>
                                        </a>
                                        <div class="collapse in" id="unreadItem${unread.id?c}">
                                            <div class="bg-gray with-padding">
                                                <p>${unread.content}</p>
                                            </div>
                                        </div>
                                    </#list>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="readContent">
                                <div id="readList" class="list-group">
                                    <#list reminds as remind>
                                        <a href="#readItem${remind.id?c}" class="list-group-item" data-toggle="collapse">
                                            <h4 class="list-group-item-heading">消息通知</h4>
                                            <p class="list-group-item-text text-muted">${remind.time}</p>
                                        </a>
                                        <div class="collapse in" id="readItem${remind.id?c}">
                                            <div class="bg-gray with-padding">
                                                <p>${remind.content}</p>
                                            </div>
                                        </div>
                                    </#list>
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
    $('[data-toggle="popover"]').popover({ html: 'html', selector: '#showContent' })
</script>
</body>

</html>