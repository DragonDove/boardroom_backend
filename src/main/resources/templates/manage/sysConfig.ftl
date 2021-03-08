<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>系统信息</title>
    <@style />
</head>

<body>
    <div class="p-10">
        <div style="height: 289px;">
            <div class="col-md-8">
                <h3>系统基本信息</h3>
                <hr>
                <table class="table table-bordered" style="border-color: #0089d4">
                    <tr>
                        <td class="col-md-2">Tomcat版本</td>
                        <td class="col-md-4">8.5.35</td>
                        <td class="col-md-2">Spring Boot版本</td>
                        <td class="col-md-4">2.1.3.RELEASE</td>
                    </tr>
                    <tr>
                        <td class="col-md-2">运行目录</td>
                        <td class="col-md-4">/etc/tomcat/jarfiles/</td>
                        <td class="col-md-2">文件基本目录</td>
                        <td class="col-md-4">/var/filebase/</td>
                    </tr>
                    <tr>
                        <td class="col-md-2">当前ip</td>
                        <td class="col-md-4">127.0.0.1</td>
                        <td class="col-md-2">系统语言</td>
                        <td class="col-md-4">zh-CN</td>
                    </tr>
                    <tr>
                        <td class="col-md-2">当前负载</td>
                        <td id="currentLoad" class="col-md-4">32%</td>
                        <td class="col-md-2">编码</td>
                        <td class="col-md-4">UTF-8</td>
                    </tr>
                    <tr>
                        <td class="col-md-2">当前运行时长</td>
                        <td class="col-md-4">12天06时04分</td>
                        <td class="col-md-2">操作</td>
                        <td class="col-md-4">
                            <button class="btn btn-sm btn-danger">关闭系统</button>
                            <button class="btn btn-sm btn-danger">重启系统</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-4">
                <h3>最近登录</h3>
                <hr>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th class="col-md-4">IP地址</th>
                            <th class="col-md-8">登录时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>114.56.132.43</td>
                            <td>2019-06-16 10:37:38</td>
                        </tr>
                        <tr>
                            <td>122.23.3.178</td>
                            <td>2019-06-15 18:12:36</td>
                        </tr>
                        <tr>
                            <td>118.25.96.118</td>
                            <td>2019-06-15 15:38:24</td>
                        </tr>
                        <tr>
                            <td>127.0.0.1</td>
                            <td>2019-06-15 09:23:11</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="p-10">
            <h2>数据库信息</h2>
            <hr>
            <table class="table table-bordered">
                <tr>
                    <td>数据库程序</td>
                    <td>MariaDB</td>
                    <td>数据库版本</td>
                    <td>10.4</td>
                    <td>数据库大小</td>
                    <td>13.4M</td>
                    <td>数据量</td>
                    <td>2545 条</td>
                </tr>
                <tr>
                    <td>数据库地址</td>
                    <td>127.0.0.1</td>
                    <td>数据库端口</td>
                    <td>3306</td>
                    <td>数据库编码</td>
                    <td>UTF-8</td>
                    <td>最大连接数</td>
                    <td>134</td>
                </tr>
                <tr>
                    <td>数据库连接池</td>
                    <td>Hikari</td>
                    <td>连接池版本</td>
                    <td>2.7.8</td>
                    <td>连接掉线延迟</td>
                    <td>30000 ms</td>
                    <td>最大生命周期</td>
                    <td>1800000 ms</td>
                </tr>
            </table>
        </div>
    </div>
    <@script />
    <script>
        let currentLoad = document.getElementById('currentLoad')
        function changeLoad() {
            currentLoad.innerText = Math.round(Math.random() * 100).toString() + "%"
        }
        setInterval(changeLoad, 2000)
    </script>
</body>

</html>