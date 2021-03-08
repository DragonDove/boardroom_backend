<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>反馈消息</title>
    <@style />
</head>

<body>
    <div class="container mt-5">
        <div class="p-10">
            <div class="row">
                <div class="col-xs-3">
                    <ul class="nav nav-tabs nav-stacked">
                        <li class="active"><a href="javascript:" data-target="#unreadContent" data-toggle="tab">
                        未读消息<span class="label label-badge label-success" style="display: inline;">3</span></a></li>
                        <li><a href="javascript:" data-target="#readContent" data-toggle="tab">已读消息</a></li>
                    </ul>
                </div>
                <div class="col-xs-9">
                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="unreadContent">
                            <div id="unreadList" class="list-group">
                                <a href="#unreadItem1" class="list-group-item" data-toggle="collapse">
                                    <h4 class="list-group-item-heading">20-202</h4>
                                    <p class="list-group-item-text text-muted">投影仪异常</p>
                                </a>
                                <div class="collapse in" id="unreadItem1">
                                    <div class="bg-gray with-padding">
                                        <p>申请人：李四</p>
                                        <p>时间：2018-12-23 19:00</p>
                                        <p>详情：投影仪打开后中心出现黑色光晕</p>
                                        <div>
                                            <button class="btn btn-success">标为已读</button>
                                        </div>
                                    </div>
                                </div>
                                <a href="#unreadItem2" class="list-group-item" data-toggle="collapse">
                                    <h4 class="list-group-item-heading">20-102</h4>
                                    <p class="list-group-item-text text-muted">座椅损坏</p>
                                </a>
                                <div class="collapse" id="unreadItem2">
                                    <div class="bg-gray with-padding">
                                        <p>申请人：王五</p>
                                        <p>时间：2018-12-23 19:00</p>
                                        <p>详情：第一排第二列的座椅断裂</p>
                                        <div>
                                            <button class="btn btn-success">标为已读</button>
                                        </div>
                                    </div>
                                </div>
                                <a href="#unreadItem3" class="list-group-item" data-toggle="collapse">
                                    <h4 class="list-group-item-heading">22-103</h4>
                                    <p class="list-group-item-text text-muted">电脑频繁蓝屏</p>
                                </a>
                                <div class="collapse" id="unreadItem3">
                                    <div class="bg-gray with-padding">
                                        <p>申请人：张三</p>
                                        <p>时间：2018-12-23 19:00 ~ 2018-12-23 21:00</p>
                                        <p>详情：电脑打开后就蓝屏，自动重启又蓝屏。</p>
                                        <div>
                                            <button class="btn btn-success">标为已读</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="readContent">
                            <div id="readList" class="list-group">
                                <a href="#readItem1" class="list-group-item" data-toggle="collapse">
                                    <h4 class="list-group-item-heading">20-202</h4>
                                    <p class="list-group-item-text text-muted">电脑频繁蓝屏</p>
                                </a>
                                <div class="collapse in" id="readItem1">
                                    <div class="bg-gray with-padding">
                                        <p>申请人：李四</p>
                                        <p>时间：2018-12-23 19:00</p>
                                        <p>详情：电脑打开后就蓝屏，自动重启又蓝屏。</p>
                                        <div>
                                            <button class="btn btn-danger">标为已处理</button>
                                        </div>
                                    </div>
                                </div>
                                <a href="#readItem2" class="list-group-item" data-toggle="collapse">
                                    <h4 class="list-group-item-heading">20-102</h4>
                                    <p class="list-group-item-text text-muted">座椅损坏</p>
                                </a>
                                <div class="collapse" id="readItem2">
                                    <div class="bg-gray with-padding">
                                        <p>申请人：王五</p>
                                        <p>时间：2018-12-23 19:00</p>
                                        <p>详情：第一排第二列的座椅断裂</p>
                                        <div>
                                            <button class="btn btn-danger">标为已处理</button>
                                        </div>
                                    </div>
                                </div>
                                <a href="#readItem3" class="list-group-item" data-toggle="collapse">
                                    <h4 class="list-group-item-heading">22-103</h4>
                                    <p class="list-group-item-text text-muted">投影仪异常</p>
                                </a>
                                <div class="collapse" id="readItem3">
                                    <div class="bg-gray with-padding">
                                        <p>申请人：李四</p>
                                        <p>时间：2018-12-23 19:00</p>
                                        <p>详情：投影仪打开后中心出现黑色光晕</p>
                                        <div>
                                            <button class="btn btn-danger">标为已处理</button>
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
    $('[data-toggle="popover"]').popover({ html: 'html', selector: '#showContent' })
    </script>
</body>

</html>