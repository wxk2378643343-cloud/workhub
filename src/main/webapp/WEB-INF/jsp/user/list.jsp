<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">用户管理</div>
        <div class="section-subtitle">维护员工账号、角色和部门归属</div>
    </div>
    <button class="btn btn-primary" type="button" onclick="openUserModal()">新增用户</button>
</div>

<div class="modal fade" id="userModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title">新增用户</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="userForm" onsubmit="saveUser();return false;">
                <div class="modal-body">
                    <input type="hidden" name="id" id="userId">
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label>登录账号</label>
                            <input name="username" class="form-control" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label>初始密码</label>
                            <input name="password" class="form-control" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label>姓名</label>
                            <input name="realName" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>所属部门</label>
                            <select name="deptId" class="form-control">
                                <option value="">请选择部门</option>
                                <c:forEach items="${departments}" var="dept"><option value="${dept.id}">${dept.deptName}</option></c:forEach>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label>角色</label>
                            <select name="roleCode" class="form-control">
                                <option value="EMPLOYEE">普通员工</option>
                                <option value="ADMIN">管理员</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">保存用户</button>
                </div>
            </form>
        </div>
    </div>
</div>

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
                <button class="btn btn-sm btn-outline-secondary" type="button" onclick="resetPassword('${item.id}')">重置密码</button>
                <button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteUser('${item.id}')">删除</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="userPager" class="mt-3"></div>
<script>
    function openUserModal() {
        $('#userForm')[0].reset();
        $('#userId').val('');
        $('#userModal').modal('show');
    }
    function saveUser() {
        $.post('${pageContext.request.contextPath}/user/save', $('#userForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#userModal').modal('hide');
                location.reload();
            }
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
