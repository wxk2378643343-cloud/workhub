<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<h3 class="mb-3">个人中心</h3>
<div class="card mb-3">
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <p><strong>姓名：</strong>${user.realName}</p>
                <p><strong>账号：</strong>${user.username}</p>
                <p><strong>部门：</strong>${user.deptName}</p>
                <p><strong>职位：</strong>${user.position}</p>
            </div>
            <div class="col-md-6">
                <p><strong>手机号：</strong>${user.phone}</p>
                <p><strong>邮箱：</strong>${user.email}</p>
                <p><strong>角色：</strong>${user.roleCode}</p>
                <p><strong>状态：</strong>${user.status}</p>
            </div>
        </div>
    </div>
</div>
<div class="card">
    <div class="card-body">
        <h5 class="mb-3">修改密码</h5>
        <div class="form-row">
            <div class="col-md-4"><input type="password" id="newPassword" class="form-control" placeholder="输入新密码"></div>
            <div class="col-md-2"><button class="btn btn-primary btn-block" onclick="changePassword()">保存</button></div>
        </div>
    </div>
</div>
<script>
    function changePassword() {
        $.post('${pageContext.request.contextPath}/user/password', {id: '${user.id}', password: $('#newPassword').val()}, function(res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#newPassword').val('');
            }
        });
    }
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
