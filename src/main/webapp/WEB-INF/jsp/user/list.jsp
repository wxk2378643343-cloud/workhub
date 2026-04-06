<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">用户管理</div>
        <div class="section-subtitle">维护员工账号、角色和部门归属</div>
    </div>
    <button class="btn btn-primary" type="button" onclick="$('#userForm').toggle()">新增用户</button>
</div>
<form id="userForm" class="form-panel card card-body mb-3" style="display:none;" onsubmit="saveUser();return false;">
    <div class="form-row">
        <input type="hidden" name="id" id="userId">
        <div class="col"><input name="username" class="form-control" placeholder="登录账号"></div>
        <div class="col"><input name="password" class="form-control" placeholder="初始密码"></div>
        <div class="col"><input name="realName" class="form-control" placeholder="姓名"></div>
        <div class="col">
            <select name="deptId" class="form-control">
                <option value="">所属部门</option>
                <c:forEach items="${departments}" var="dept"><option value="${dept.id}">${dept.deptName}</option></c:forEach>
            </select>
        </div>
        <div class="col">
            <select name="roleCode" class="form-control">
                <option value="EMPLOYEE">普通员工</option>
                <option value="ADMIN">管理员</option>
            </select>
        </div>
        <div class="col"><button class="btn btn-primary btn-block">保存用户</button></div>
    </div>
</form>
<div class="table-wrap">
<table id="userTable" class="table bg-white mb-0">
    <thead><tr><th>ID</th><th>账号</th><th>姓名</th><th>部门</th><th>职位</th><th>角色</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${users}" var="item">
        <tr>
            <td>${item.id}</td>
            <td>${item.username}</td>
            <td>${item.realName}</td>
            <td>${item.deptName}</td>
            <td>${item.position}</td>
            <td>${item.roleCode}</td>
            <td>
                <button class="btn btn-sm btn-outline-secondary" onclick="resetPassword('${item.id}')">重置密码</button>
                <button class="btn btn-sm btn-outline-danger" onclick="deleteUser('${item.id}')">删除</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="userPager" class="mt-3"></div>
<script>
    function saveUser() {
        $.post('${pageContext.request.contextPath}/user/save', $('#userForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function deleteUser(id) {
        $.post('${pageContext.request.contextPath}/user/delete', {id: id}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function resetPassword(id) {
        $.post('${pageContext.request.contextPath}/user/password', {id: id, password: '123456'}, function (res) {
            alert(res.msg);
        });
    }
    initTablePagination('userTable', 'userPager', 8);
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
