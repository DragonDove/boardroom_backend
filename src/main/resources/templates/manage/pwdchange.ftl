<#include "../template.ftl" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>后台密码修改</title>
	<@style />
</head>

<body>
    <div class="container p-10 mt-5">
    	<div class="card shadow-sm" style="width: 60%; margin-left: 20%;">
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
	<@script />
	<script>
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

	</script>
</body>

</html>