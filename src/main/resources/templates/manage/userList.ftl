<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>员工列表</title>
    <@style />
    <link rel="stylesheet" href="/webjars/zui/1.9.0/dist/lib/uploader/zui.uploader.css">
</head>

<body>
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-heading p-10">
            <h2 class="ml-5">员工列表</h2>
            <div class="pull-right mr-5">
                <button id="newRoomBtn" class="btn btn-primary" data-toggle="modal" data-target="#newUserModal">新增员工
                </button>
                <button id="photosUploadButton" class="btn btn-info"
                        data-toggle="modal" data-target="#photosUploadModal">批量更新照片</button>
            </div>
        </div>
        <hr style="width: 95%" class="mt-1">
        <div class="card-content p-10 ml-5 mb-5">
            <div id="userTable" class="datagrid">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="roomSearch"
                     style="margin-bottom: 10px; max-width: 300px">
                    <input id="inputSearchExample2" type="search" class="form-control search-input" placeholder="搜索">
                    <label for="inputSearchExample2" class="input-control-icon-left search-icon"><i
                                class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                </div>
                <div class="datagrid-container"></div>
                <div class="pager"></div>
            </div>
        </div>
    </div>
</div>


<!--批量上传照片对话框-->
<div class="modal fade" id="photosUploadModal">
    <div class="modal-dialog modal-lg">
        <div class="ml-5 modal-content" style="text-align: center;">
            <div id='photosUploader' class="uploader">
            <div class="uploader-message text-center">
                <div class="content"></div>
                <button type="button" class="close">×</button>
            </div>
            <div class="uploader-files file-list file-list-grid"></div>
            <div>
                <hr class="divider">
                <div class="uploader-status pull-right text-muted"></div>
                <button type="button" class="btn btn-link uploader-btn-browse"><i class="icon icon-plus"></i> 选择文件</button>
                <button type="button" class="btn btn-link uploader-btn-start"><i class="icon icon-cloud-upload"></i> 开始上传</button>
            </div>
        </div>
        </div>
    </div>
</div>
<!-- 新增员工对话框 -->
<div class="modal fade" id="newUserModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="p-10">
                <label for="newUsernameInput">用户名</label>
                <input id="newUsernameInput" type="text" class="form-control">
                <label for="newRealNameInput">姓名</label>
                <input id="newRealNameInput" type="text" class="form-control">
                <label for="newEmailInput">E-mail</label>
                <input id="newEmailInput" type="email" class="form-control">
                <label for="newPhoneInput">联系电话</label>
                <input id="newPhoneInput" type="text" class="form-control">
                <label for="newDepartmentSelect">部门</label>
                <select id="newDepartmentSelect" class="form-control">

                </select>
                <label for="newPasswordInput">初始密码</label>
                <input id="newPasswordInput" type="password" class="form-control">
                <div class="mt-3" style="text-align: right;">
                    <button id="newUserSubmitButton" class="btn btn-primary">提交</button>
                    <button class="btn" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 信息更新对话框 -->
<div class="modal fade" id="updateUserModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="p-10">
                <label for="updateIdInput">用户编号</label>
                <input type="text" id="updateIdInput" class="form-control" readonly>
                <label for="updateUsernameInput">用户名</label>
                <input id="updateUsernameInput" type="text" class="form-control">
                <label for="updateRealNameInput">姓名</label>
                <input id="updateRealNameInput" type="text" class="form-control">
                <label for="updateEmailInput">E-mail</label>
                <input id="updateEmailInput" type="email" class="form-control">
                <label for="updatePhoneInput">联系电话</label>
                <input id="updatePhoneInput" type="text" class="form-control">
                <label for="updateDepartmentSelect">部门</label>
                <select id="updateDepartmentSelect" class="form-control">

                </select>
                <div class="mt-3" style="text-align: right;">
                    <button id="updateUserSubmitButton" class="btn btn-primary">提交</button>
                    <button class="btn" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 删除确认对话框 -->
<div class="modal fade" id="deleteUserModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="p-10">
                <h3>确认删除吗？</h3>
            </div>
            <div class="p-2" style="text-align: center;">
                <button id="deleteUserButton" class="btn btn-danger">确定</button>
                <button class="btn" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工详细信息对话框 -->
<div class="modal fade" id="userInfoModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content" style="text-align: center;">
            <img id="userPhoto" src="/img/nonavatar.jpg" class="img-rounded" alt="userPhoto">

            <button id="photoUploadButton" class="btn btn-primary mb-5 mt-2">更新员工照片</button>
        </div>
    </div>
</div>

<!--上传照片对话框-->
<div class="modal fade" id="singleUploadModal">
    <div class="modal-dialog modal-sm">
        <div class="ml-5 modal-content" style="text-align: center;">
            <div id="singleUpload" class="uploader">
                <div class="uploader-actions">
                    <div class="uploader-status pull-right text-muted"></div>
                    <button type="button" class="btn btn-link uploader-btn-browse"><i class="icon icon-plus"></i> 选择文件</button>
                    <button type="button" class="btn btn-link uploader-btn-start"><i class="icon icon-cloud-upload"></i> 开始上传</button>
                </div>
            </div>
        </div>
    </div>
</div>

<@script />
<script src="/webjars/zui/1.9.0/dist/lib/uploader/zui.uploader.js"></script>
<script>
    const newUsernameInput = document.getElementById('newUsernameInput')
    const newRealNameInput = document.getElementById('newRealNameInput')
    const newEmailInput = document.getElementById('newEmailInput')
    const newPhoneInput = document.getElementById('newPhoneInput')
    const newDepartmentSelect = document.getElementById('newDepartmentSelect')
    const newPasswordInput = document.getElementById('newPasswordInput')
    const photoUploadButton = document.getElementById('photoUploadButton')
    const updateIdInput = document.getElementById('updateIdInput')
    const updateUsernameInput = document.getElementById('updateUsernameInput')
    const updateRealNameInput = document.getElementById('updateRealNameInput')
    const updateEmailInput = document.getElementById('updateEmailInput')
    const updatePhoneInput = document.getElementById('updatePhoneInput')
    const deleteUserButton = document.getElementById('deleteUserButton')
    const newUserSubmitButton = document.getElementById('newUserSubmitButton')
    const updateUserSubmitButton = document.getElementById('updateUserSubmitButton')
    const updateDepartmentSelect = document.getElementById('updateDepartmentSelect')
    const userPhoto = document.getElementById('userPhoto')
    let departments = []
    let users = []
    const uploader = $('#photosUploader')
    const table = $('#userTable')
    uploader.uploader({
        url: '/user/uploadPhotoChannel',
        filters: {
            mime_types: [
                {title: '图片', extensions: 'jpg,png'},
            ],
            prevent_duplicates: true,
            fileList: 'grid'
        },
        responseHandler: function (responseObject, file) {
            if (responseObject.response.code !== 200) {
                return responseObject.response.msg
            }
        }
    })

    fetch('/department/all').then(response => response.json()).then(json => {
        departments = json.extras.departments
        fetch('/user/all').then(response => response.json()).then(json => {
            users = json.extras.users
            users.forEach(user => {
                user.no = '<a href="javascript:;" uId="' + user.id + '" class = "userId">' + user.id + '</a>'
                user.departmentName = user.department.name
                user.conf = '<button uId="' + user.id.toString() + '" class="btn btn-sm btn-success updateBtn"><i class="icon icon-pencil"></i> 更新</button> ' +
                    '<button uId="' + user.id.toString() + '" class="btn btn-sm btn-danger removeBtn"><i class="icon icon-remove"></i> 删除</button>'
            })
            table.datagrid({
                dataSource: {
                    cols: [
                        {name: 'no', label: '员工编号'},
                        {name: 'username', label: '用户名'},
                        {name: 'realName', label: '姓名'},
                        {name: 'email', label: '邮箱'},
                        {name: 'phone', label: '联系电话'},
                        {name: 'departmentName', label: '部门'},
                        {name: 'conf', label: '操作'}
                    ],
                    array: users
                },
                configs: {
                    C1: {
                        html: true
                    },
                    C7: {
                        html: true
                    }
                },
                states: {
                    pager: {page: 1, recPerPage: 10}
                },
                height: 'page'
            })
        })
    }).then(function () {
        departments.forEach(department => {
            const newOption = document.createElement('option')
            newOption.value = department.id
            newOption.innerText = department.name
            newDepartmentSelect.appendChild(newOption)
            const updateOption = document.createElement('option')
            updateOption.value = department.id
            updateOption.innerText = department.name
            updateDepartmentSelect.appendChild(updateOption)
        })
    })

    table.on('click', '.userId', function () {
        users.forEach(user => {
            if (this.getAttribute('uId') === user.id.toString()) {
                userPhoto.setAttribute('src', user.photoPath ? '/' + user.photoPath + "?" + Math.random() : '/img/nonavatar.jpg')
                photoUploadButton.setAttribute('uId', user.id.toString())
                $('#userInfoModal').modal()
            }
        })
    })

    table.on('click', '.updateBtn', function () {
        fetch('/user?id=' + this.getAttribute('uId')).then(response => response.json()).then(json => {
            const user = json.extras.user
            updateIdInput.value = user.id
            updateUsernameInput.value = user.username
            updateRealNameInput.value = user.realName
            updateEmailInput.value = user.email
            updatePhoneInput.value = user.phone
            updateDepartmentSelect.value = user.department.id
        })
        $('#updateUserModal').modal()
    })
    table.on('click', '.removeBtn', function () {
        deleteUserButton.setAttribute('uId', this.getAttribute('uId'))
        $('#deleteUserModal').modal()
    })

    photoUploadButton.addEventListener('click', function () {
        let that = this
        $('#singleUpload').uploader({
            url: '/user/uploadPhoto?id=' + that.getAttribute('uId'),
            filters: {
                mime_types: [
                    {title: '图片', extensions: 'jpg,png'},
                ],
                prevent_duplicates: true,
                fileList: 'grid'
            },
            multi_selection: false,
            limitFilesCount: 1,
            onFileUploaded: function () {
                window.location.reload()
            },
            responseHandler: function (responseObject, file) {
                if (responseObject.response.code !== 200) {
                    return responseObject.response.msg
                }
            }
        })
        $('#singleUploadModal').modal()
    })

    newUserSubmitButton.addEventListener('click', function () {
        const username = newUsernameInput.value
        const realName = newRealNameInput.value
        const email = newEmailInput.value
        const phone = newPhoneInput.value
        const department = { id: newDepartmentSelect.value }
        const password = newPasswordInput.value
        const user = {
            username: username,
            realName: realName,
            email: email,
            phone: phone,
            password: password,
            department: department
        }
        fetch('/user', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(user)
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                alert('新增用户成功')
                window.location.reload()
            } else {
                alert(json.msg)
            }
        })

    })

    updateUserSubmitButton.addEventListener('click', function () {
        const id = updateIdInput.value
        const username = updateUsernameInput.value
        const realName = updateRealNameInput.value
        const email = updateEmailInput.value
        const phone = updatePhoneInput.value
        const department = { id: updateDepartmentSelect.value }
        const user = {
            id: id,
            username: username,
            realName: realName,
            email: email,
            phone: phone,
            department: department
        }
        fetch('/user', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(user)
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                alert('更新用户成功')
                window.location.reload()
            } else {
                alert(json.msg)
            }
        })
    })

    deleteUserButton.addEventListener('click', function () {
        fetch('/user?id=' + this.getAttribute('uId'), {
            method: 'DELETE'
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                alert('删除成功')
                window.location.reload()
            } else {
                alert(json.msg)
            }
        })
    })

</script>
</body>

</html>