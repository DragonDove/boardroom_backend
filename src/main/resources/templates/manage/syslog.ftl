<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>系统日志</title>
    <@style />
</head>

<body>

    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-heading p-10">
                <div class="col-md-4">
                    <h2>系统日志</h2>
                </div>
                <div class="col-md-4" style="text-align: center;">
                    当前系统时间： <br> <span id="currentTime" class="label label-badge label-info"></span>
                </div>
                <div class="col-md-4">
                    <button type="button" id="updateLogBtn" class="btn btn-info pull-right mt-3" style="min-width: 120px;">刷新</button>
                </div>
            </div>
                    <hr style="width: 95%" class="mt-1">
        <div class="card-content p-10 ml-5 mb-5">
            <textarea rows="28" class="form-control" style="font-family: consolas,serif; resize: none; background-color: #ffffff;" readonly="readonly" id="logArea" wrap="off">

            </textarea>
        </div>
        </div>

    </div>
    <@script />
    <script>
        let currentTime = document.getElementById('currentTime')
        let logArea = document.getElementById('logArea')
        let updateLogBtn = document.getElementById('updateLogBtn')
        function doUpdate() {
            fetch('/spring.log?' + Math.random()).then(function (res) {
                res.text().then(function (data) {
                    logArea.innerHTML = data
                })
            })
        }
        function countTime() {
            currentTime.innerHTML = new Date().toString()
        }
        updateLogBtn.addEventListener('click', doUpdate)
        countTime()
        doUpdate()
        setInterval(countTime, 1000)
        setInterval(doUpdate, 10000)
    </script>
</body>

</html>