<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>权限管理</title>
    <@style />
</head>
<body>
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="col-md-6 p-10">
            <div class="card-heading">
                <h2 class="ml-5">员工角色管理</h2>
            </div>
            <hr style="width: 95%" class="mt-1">
            <div class="card-content p-10 ml-5 mb-5">
                <div id="userRoleTable" class="datagrid">
                    <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="roomSearch"
                         style="margin-bottom: 10px; max-width: 300px">
                        <input id="inputSearchExample2" type="search" class="form-control search-input"
                               placeholder="搜索">
                        <label for="inputSearchExample2" class="input-control-icon-left search-icon"><i
                                    class="icon icon-search"></i></label>
                        <a href="#" class="input-control-icon-right search-clear-btn"><i
                                    class="icon icon-remove"></i></a>
                    </div>
                    <div class="datagrid-container"></div>
                    <div class="pager"></div>
                </div>
            </div>
        </div>
        <div class="col-md-6 p-10">
            <div class="card-heading">
                <h2 class="ml-5">角色权限管理</h2>
                <div class="pull-right mr-3" style="margin-top: -50px;">
                    <button id="newRoleBtn" class="btn btn-primary" data-toggle="modal" data-target="#newRoleModal"
                            style="margin-top: 15px;">新增角色
                    </button>
                </div>
            </div>
            <hr style="width: 95%" class="mt-1">
            <div class="card-content p-10 ml-5 mb-5">
                <div id="rolePermTable" class="datagrid">
                    <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="roomSearch"
                         style="margin-bottom: 10px; max-width: 300px">
                        <input id="inputSearchExample2" type="search" class="form-control search-input"
                               placeholder="搜索">
                        <label for="inputSearchExample2" class="input-control-icon-left search-icon"><i
                                    class="icon icon-search"></i></label>
                        <a href="#" class="input-control-icon-right search-clear-btn"><i
                                    class="icon icon-remove"></i></a>
                    </div>
                    <div class="datagrid-container"></div>
                    <div class="pager"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 新增角色对话框 -->
<div class="modal fade" id="newRoleModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="p-10">
                <label for="newRoleNameInput">角色名称</label>
                <input id="newRoleNameInput" type="text" class="form-control">
                <label for="newRolePermInput">角色权限</label>
                <#list permissions as permission>
                    <div class="switch">
                        <input id="role${permission.id}" type="checkbox" name="newRoleCheckbox"
                               value="${permission.id}">
                        <label for="role${permission.id}">${permission.name}</label>
                    </div>
                </#list>
                <div class="mt-3" style="text-align: right;">
                    <button id="newRoleSubmitButton" class="btn btn-primary">提交</button>
                    <button class="btn" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 角色更新对话框 -->
<div class="modal fade" id="updateRoleModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="p-10">
                <label for="updateRoleNameInput">角色名称</label>
                <input id="updateRoleNameInput" type="text" class="form-control" value="主管" disabled="">
                <label for="updateRolePermInput">角色权限</label>
                <#list permissions as permission>
                    <div class="switch">
                        <input id="role${permission.id}" type="checkbox" name="updateRoleCheckbox"
                               value="${permission.id}">
                        <label for="role${permission.id}">${permission.name}</label>
                    </div>
                </#list>
                <div class="mt-3" style="text-align: right;">
                    <button id="updateRoleSubmitButton" class="btn btn-primary">提交</button>
                    <button class="btn" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 更改角色对话框 -->
<div class="modal fade" id="changeRoleModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="p-10">
                <label for="changeRoleNoInput">员工编号</label>
                <input id="changeRoleNoInput" type="text" class="form-control" value="20170105" disabled="">
                <label for="changeRoleNameInput">员工姓名</label>
                <input id="changeRoleNameInput" type="text" class="form-control" value="张三" disabled="">
                <#list roles as role>
                    <div class="switch">
                        <input id="role${role.id}" type="checkbox" name="roleCheckbox" value="${role.id}">
                        <label for="role${role.id}">${role.name}</label>
                    </div>
                </#list>
                <div class="mt-3" style="text-align: right;">
                    <button id="userRoleUpdateButton" class="btn btn-primary">提交</button>
                    <button class="btn" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 删除确认对话框 -->
<div class="modal fade" id="deleteRoomModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="p-10">
                <h3>确认删除吗？</h3>
            </div>
            <div class="p-2" style="text-align: center;">
                <button class="btn btn-danger">确定</button>
                <button class="btn" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<@script />
<script>
    const userRoleTable = $('#userRoleTable')
    const rolePermTable = $('#rolePermTable')
    const userRoleUpdateButton = document.getElementById('userRoleUpdateButton')
    const changeRoleNoInput = document.getElementById('changeRoleNoInput')
    const changeRoleNameInput = document.getElementById('changeRoleNameInput')
    const roleCheckboxes = document.getElementsByName('roleCheckbox')
    const newRoleNameInput = document.getElementById('newRoleNameInput')
    const newRoleCheckboxes = document.getElementsByName('newRoleCheckbox')
    const updateRoleNameInput = document.getElementById('updateRoleNameInput')
    const updateRoleCheckboxes = document.getElementById('updateRoleCheckbox')
    const updateRoleSubmitButton = document.getElementById('updateRoleSubmitButton')
    const newRoleSubmitButton = document.getElementById('newRoleSubmitButton')
    userRoleTable.datagrid({
        dataSource: {
            cols: [
                {name: 'id', label: '员工编号'},
                {name: 'realName', label: '员工姓名'},
                {name: 'role', label: '员工角色'},
                {name: 'conf', label: '操作'}
            ],
            array: [
                <#list users as user>
                {
                    id: '${user.id}',
                    realName: '${user.realName}',
                    role: '<#list user.roles as role>${role.name} </#list>',
                    conf: '<button class="btn btn-sm btn-success roleChangeBtn" uId="${user.id}">' +
                        '<i class="icon icon-pencil"></i> 更改角色</button>'
                }<#if user_has_next>, </#if>
                </#list>
            ]
        },
        configs: {
            C4: {html: true}
        },
        states: {
            pager: {page: 1, recPerPage: 10}
        },
        height: 'page'
    })

    rolePermTable.datagrid({
        dataSource: {
            cols: [
                {name: 'id', label: '角色编号'},
                {name: 'name', label: '角色名称'},
                {name: 'perm', label: '权限'},
                {name: 'conf', label: '操作'}
            ],
            array: [
                <#list roles as role>
                {
                    id: '${role.id}',
                    name: '${role.name}',
                    perm: '<#list role.permissions as permission>${permission.name} </#list>',
                    conf: '<button rId="${role.id}" class="btn btn-sm btn-success updateBtn"><i class="icon icon-pencil"></i> 更改</button> ' +
                        '<button rId="${role.id}" class="btn btn-sm btn-danger removeBtn"><i class="icon icon-remove"></i> 删除</button>'
                }<#if role_has_next>, </#if>
                </#list>
            ]
        },
        configs: {
            C4: {html: true}
        },
        states: {
            pager: {page: 1, recPerPage: 10}
        },
        height: 'page'
    })

    rolePermTable.on('click', '.updateBtn', function () {
        updateRoleSubmitButton.setAttribute('rId', this.getAttribute('rId'))
        updateRoleNameInput.value = changeRoleNameInput.value = this.parentNode.previousElementSibling.previousElementSibling.innerText
        $('#updateRoleModal').modal()
    })
    rolePermTable.on('click', '.removeBtn', function () {

        $('#deleteRoomModal').modal()
    })
    userRoleTable.on('click', '.roleChangeBtn', function () {
        changeRoleNoInput.value = this.getAttribute('uId')
        userRoleUpdateButton.setAttribute('uId', this.getAttribute('uId'))
        changeRoleNameInput.value = this.parentNode.previousElementSibling.previousElementSibling.innerText
        $('#changeRoleModal').modal()
    })
    userRoleUpdateButton.addEventListener('click', function () {
        let userRoles = []
        for (let checkbox of roleCheckboxes) {
            if (checkbox.checked) {
                userRoles.push({id: checkbox.value})
            }
        }
        fetch('/user/roles?id=' + this.getAttribute('uId'), {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userRoles)
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                alert('修改成功')
                window.location.reload()
            } else {
                alert(json.msg)
            }
        })
    })
    updateRoleSubmitButton.addEventListener('click', function () {
        let rolePerms = []
        for (let checkbox of updateRoleCheckboxes) {
            if (checkbox.checked) {
                rolePerms.push({id: checkbox.value})
            }
        }
        fetch('/role/permissions?id=' + this.getAttribute('rId'), {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(rolePerms)
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                alert('修改成功')
                window.location.reload()
            } else {
                alert(json.msg)
            }
        })
    })
    newRoleSubmitButton.addEventListener('click', function () {
        let roleName = newRoleNameInput.value
        let rolePerms = []
        for (let checkbox of newRoleCheckboxes) {
            if (checkbox.checked) {
                rolePerms.push({id: checkbox.value})
            }
        }
        fetch('/role', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({name: roleName})
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                const roleId = json.extras.role.id
                fetch('/role/permissions?id=' + roleId, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(rolePerms)
                }).then(response => response.json()).then(json => {
                    if (200 === json.code) {
                        alert('新增成功')
                        window.location.reload()
                    } else {
                        alert(json.msg)
                    }
                })
            } else {
                alert(json.msg)
            }
        })
    })
</script>

</body>
</html>