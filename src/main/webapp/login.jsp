<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>智慧办公系统登录</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <style>
        body { background: linear-gradient(135deg, #f7f3e9, #d8e2dc); min-height: 100vh; }
        .login-box { width: 420px; margin: 100px auto; background: #fff; padding: 36px; border-radius: 18px; box-shadow: 0 20px 50px rgba(0,0,0,.1); }
        .login-title { font-size: 28px; font-weight: 700; color: #264653; margin-bottom: 24px; }
    </style>
</head>
<body>
<div class="login-box">
    <div class="login-title">企业级智慧办公系统</div>
    <div class="form-group">
        <label>用户名</label>
        <input type="text" id="username" class="form-control" value="admin">
    </div>
    <div class="form-group">
        <label>密码</label>
        <input type="password" id="password" class="form-control" value="123456">
    </div>
    <button class="btn btn-primary btn-block" onclick="login()">登录系统</button>
    <div id="msg" class="text-danger mt-3"></div>
</div>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script>
    function login() {
        $.post('${pageContext.request.contextPath}/auth/login', {
            username: $('#username').val(),
            password: $('#password').val()
        }, function (res) {
            if (res.code === 200) {
                location.href = '${pageContext.request.contextPath}' + res.data;
            } else {
                $('#msg').text(res.msg);
            }
        });
    }
</script>
</body>
</html>
