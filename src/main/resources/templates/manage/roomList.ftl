<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>房间列表</title>
    <@style />
</head>

<body>
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-heading p-10">
                <h2 class="ml-5">房间列表</h2>
                <div class="pull-right mr-5">
                    <button id="newRoomBtn" class="btn btn-primary" data-toggle="modal" data-target="#newRoomModal">新增房间</button>
                </div>
            </div>
            <hr style="width: 95%" class="mt-1">
            <div class="card-content p-10 ml-5 mb-5">
                <div id="roomTable" class="datagrid">
                    <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="roomSearch" style="margin-bottom: 10px; max-width: 300px">
                        <input id="inputSearchExample2" type="search" class="form-control search-input" placeholder="搜索">
                        <label for="inputSearchExample2" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                        <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                    </div>
                    <div class="datagrid-container"></div>
                    <div class="pager"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- 新增房间对话框 -->
    <div class="modal fade" id="newRoomModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="p-10">
                    <label for="newRoomNameInput">房间名称</label>
                    <input id="newRoomNameInput" type="text" class="form-control">
                    <label for="newRoomCapacityInput">房间容量</label>
                    <input type="text" id="newRoomCapacityInput" class="form-control">
                    <label for="newRoomLocationInput">房间地点</label>
                    <input type="text" id="newRoomLocationInput" class="form-control">
                    <label for="newRoomAvailableInput">是否可用</label>
                    <select id="newRoomAvailableInput" class="form-control">
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <label for="newRoomMicrophoneAvailable">麦克风是否可用</label>
                    <select id="newRoomMicrophoneAvailable" class="form-control">
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <label for="newRoomProjectorAvailable">投影仪是否可用</label>
                    <select id="newRoomProjectorAvailable" class="form-control">
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <div class="mt-3" style="text-align: right;">
                    	<button id="newSubmitButton" class="btn btn-primary">提交</button>
                    	<button class="btn" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 信息更新对话框 -->
    <div class="modal fade" id="updateRoomModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="p-10">
                    <label for="updateRoomIdInput">房间编号</label>
                    <input id="updateRoomIdInput" type="text" class="form-control" disabled="">
                    <label for="updateRoomNameInput">房间名称</label>
                    <input id="updateRoomNameInput" type="text" class="form-control">
                    <label for="updateRoomCapacityInput">房间容量</label>
                    <input type="text" id="updateRoomCapacityInput" class="form-control">
                    <label for="updateRoomLocationInput">房间地点</label>
                    <input type="text" id="updateRoomLocationInput" class="form-control">
                    <label for="updateRoomAvailableInput">是否可用</label>
                    <select id="updateRoomAvailableInput" class="form-control">
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <label for="updateRoomMicrophoneAvailable">麦克风是否可用</label>
                    <select id="updateRoomMicrophoneAvailable" class="form-control">
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <label for="updateRoomProjectorAvailable">投影仪是否可用</label>
                    <select id="updateRoomProjectorAvailable" class="form-control">
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <div class="mt-3" style="text-align: right;">
                    	<button id="updateSubmitButton" class="btn btn-primary">提交</button>
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
    				<h3>删除房间将会删除相对应的会议，确认删除吗？</h3>
    			</div>
    			<div class="p-2" style="text-align: center;">
    				<button id="deleteSubmitButton" class="btn btn-danger">确定</button>
    				<button class="btn" data-dismiss="modal">取消</button>
    			</div>
    		</div>
    	</div>
    </div>
    <@script />
    <script>
    const table = $('#roomTable')
    const deleteSubmitButton = document.getElementById('deleteSubmitButton')
    const updateSubmitButton = document.getElementById('updateSubmitButton')
    const updateRoomId = document.getElementById('updateRoomIdInput')
    const updateRoomName = document.getElementById('updateRoomNameInput')
    const updateRoomCapacity = document.getElementById('updateRoomCapacityInput')
    const updateRoomLocation = document.getElementById('updateRoomLocationInput')
    const updateRoomAvailable = document.getElementById('updateRoomAvailableInput')
    const updateRoomMicrophoneAvailable = document.getElementById('updateRoomMicrophoneAvailable')
    const updateRoomProjectorAvailable = document.getElementById('updateRoomProjectorAvailable')
    const newSubmitButton = document.getElementById('newSubmitButton')
    const newRoomName = document.getElementById('newRoomNameInput')
    const newRoomCapacity = document.getElementById('newRoomCapacityInput')
    const newRoomLocation = document.getElementById('newRoomLocationInput')
    const newRoomAvailable = document.getElementById('newRoomAvailableInput')
    const newRoomMicrophoneAvailable = document.getElementById('newRoomMicrophoneAvailable')
    const newRoomProjectorAvailable = document.getElementById('newRoomProjectorAvailable')

    fetch('/room/all').then(response => response.json()).then(json => {
        let rooms = json.extras.rooms
        rooms.forEach(room => {
            room.name = '<a href="/manage/roomPage?id=' + room.id + '">' + room.name + '</a>'
            room.available = room.available ? '√' : '×'
            room.microphoneAvailable = room.microphoneAvailable ? '√' : '×'
            room.projectorAvailable = room.projectorAvailable ? '√' : '×'
            room.conf = '<button rId=' + room.id + ' class="btn btn-sm btn-success updateBtn"><i class="icon icon-pencil">' +
                '</i> 更新</button> <button rId=' + room.id + ' class="btn btn-sm btn-danger removeBtn">' +
                '<i class="icon icon-remove"></i> 删除</button>'
        })
        table.datagrid({
            dataSource: {
                cols: [
                    { name: 'id', label: '房间编号'},
                    { name: 'name', label: '房间名称'},
                    { name: 'capacity', label: '房间容量' },
                    { name: 'location', label: '地点' },
                    { name: 'available', label: '可用' },
                    { name: 'microphoneAvailable', label: '麦克风' },
                    { name: 'projectorAvailable', label: '投影仪' },
                    { name: 'conf', label: '操作' }
                ],
                array: rooms
            },
            configs: {
                C2: {
                    html: true
                },
                C8: {
                    html: true
                }
            },
            states: {
                pager: { page: 1, recPerPage: 10 }
            },
            height: 'page'
        })
    })

    table.on('click', '.updateBtn', function() {
        fetch('/room?id=' + $(this).attr('rId')).then(response => response.json()).then(json => {
            if (200 === json.code) {
                let room = json.extras.room
                updateRoomId.value = room.id
                updateRoomName.value = room.name
                updateRoomLocation.value = room.location
                updateRoomCapacity.value = room.capacity
                updateRoomAvailable.value = room.available
                updateRoomMicrophoneAvailable.value = room.microphoneAvailable
                updateRoomProjectorAvailable.value = room.projectorAvailable
                $('#updateRoomModal').modal()
            } else {
                alert(json.msg)
            }
        })
    })
    updateSubmitButton.addEventListener('click', function () {
        fetch('/room', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                id: updateRoomId.value,
                name: updateRoomName.value,
                available: updateRoomAvailable.value,
                capacity: updateRoomCapacity.value,
                location: updateRoomLocation.value,
                microphoneAvailable: updateRoomMicrophoneAvailable.value,
                projectorAvailable: updateRoomProjectorAvailable.value
            })
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                window.location.reload()
            } else {
                alert(json.msg)
            }
        })
    })
    deleteSubmitButton.addEventListener('click', function () {
        fetch('/room?id=' + this.getAttribute('rId'), {
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
    table.on('click', '.removeBtn', function () {
        deleteSubmitButton.setAttribute('rId', $(this).attr('rId'))
    	$('#deleteRoomModal').modal()
    })
    newSubmitButton.addEventListener('click', function () {
        fetch('/room', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                name: newRoomName.value,
                available: newRoomAvailable.value,
                capacity: newRoomCapacity.value,
                location: newRoomLocation.value,
                microphoneAvailable: newRoomMicrophoneAvailable.value,
                projectorAvailable: newRoomProjectorAvailable.value
            })
        }).then(response => response.json()).then(json => {
            if (200 === json.code) {
                alert('新增房间成功')
                window.location.reload()
            } else {
                alert(json.msg)
            }
        })
    })
    </script>
</body>

</html>