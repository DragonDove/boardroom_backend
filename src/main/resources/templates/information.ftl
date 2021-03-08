<#include "template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>用户信息</title>
    <@style />
</head>

<body>
<div class="container p-10 mt-5">
    <div class="row" style="width: 80%; margin-left: 10%;">
        <div class="col-md-6">
            <div class="card shadow-sm p-10">
                <div class="card-body text-center">
                    <img src="/${user.photoPath}" class="rounded-circle" width="216px" height="216px" alt="userPhoto">
                    <div class="mt-2">
                        <div class="badge badge-dark">userId</div>
                        <span>${user.id}</span>
                    </div>
                </div>
                <div class="card-body">
                    <label for="updateUsernameInput">用户名</label>
                    <input id="updateUsernameInput" type="text" class="form-control" readonly value="${user.username}">
                    <label for="updateRealNameInput">姓名</label>
                    <input id="updateRealNameInput" type="text" class="form-control" readonly value="${user.realName}">
                    <label for="updateEmailInput">E-mail</label>
                    <input id="updateEmailInput" type="email" class="form-control" value="${user.email}">
                    <label for="updatePhoneInput">联系电话</label>
                    <input id="updatePhoneInput" type="text" class="form-control" value="${user.phone}">
                    <label for="updateDepartmentSelect">部门</label>
                    <input id="updateDepartmentSelect" type="text" class="form-control" readonly value="${user.department.name}">
                </div>
                <div class="car-body text-center">
                    <button id="updateUserSubmitButton" class="btn btn-success">保存更改</button>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-heading p-10"><h2 class="ml-5">登录密码修改</h2></div>
                <hr style="width: 95%;" class="mt-1">
                <div class="card-content p-10 ml-5 mb-5 mr-5">
                    <p class="text-muted">新密码至少6位，包括数字、大小写英文字母</p>
                    <label for="oldPassword">旧密码：</label>
                    <input id="oldPassword" class="form-control" type="password" placeholder="请输入旧密码"/>
                    <label for="newPassword">新密码</label>
                    <input id="newPassword" class="form-control" type="password" placeholder="请输入新密码"/>
                    <label for="confirmPassword">确认密码</label>
                    <input id="confirmPassword" class="form-control" type="password" placeholder="请重复输入新密码"/>
                    <button id="confirmBtn" class="btn btn-block btn-danger mt-5">修改密码</button>
                </div>
            </div>

        </div>

    </div>
</div>
    <@script />
    <script>

        const updateEmailInput = document.getElementById('updateEmailInput')
        const updatePhoneInput = document.getElementById('updatePhoneInput')
        const updateUserSubmitButton = document.getElementById('updateUserSubmitButton')
        const updateDepartmentSelect = document.getElementById('updateDepartmentSelect')
        updateDepartmentSelect.value = ${user.department.id}
        const confirmBtn = document.getElementById('confirmBtn')
        confirmBtn.addEventListener('click', function () {
            let oldPassword = document.getElementById('oldPassword').value
            let newPassword = document.getElementById('newPassword').value
            let confirmPassword = document.getElementById('confirmPassword').value
            if (newPassword !== confirmPassword) {
                alert('请确保两次新密码输入相同')
                return
            }
            fetch('/user/password?oldPassword=' + oldPassword + '&newPassword=' + newPassword).then(response => response.json()).then(json => {
                if (200 === json.code) {
                    alert('密码修改成功')
                    window.location.href = '/manage'
                } else {
                    alert(json.msg)
                }
            })
        })

        updateUserSubmitButton.addEventListener('click', function () {
            const email = updateEmailInput.value
            const phone = updatePhoneInput.value
            const user = {
                id: ${user.id},
                username: ${user.username},
                realName: ${user.realName},
                email: email,
                phone: phone
            }
            fetch('/user', {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(user)
            }).then(response => response.json()).then(json => {
                if (200 === json.code) {
                    alert('保存成功')
                    window.location.reload()
                } else {
                    alert(json.msg)
                }
            })
        })

    </script>
</body>

</html>