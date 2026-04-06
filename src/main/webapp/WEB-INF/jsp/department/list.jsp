<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">部门管理</div>
        <div class="section-subtitle">维护组织结构、负责人和部门描述</div>
    </div>
    <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
        <button class="btn btn-primary" type="button" onclick="openDepartmentModal()">新增部门</button>
    </c:if>
</div>

<c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
<div class="modal fade" id="departmentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title">新增部门</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="departmentForm" onsubmit="saveDepartment();return false;">
                <div class="modal-body">
                    <input type="hidden" name="id" id="deptId">
                    <div class="form-group">
                        <label>部门名称</label>
                        <input name="deptName" class="form-control" required>
                    </div>
                    <div class="form-group mb-0">
                        <label>部门描述</label>
                        <input name="description" class="form-control">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">保存部门</button>
                </div>
            </form>
        </div>
    </div>
</div>
</c:if>

<div class="table-wrap">
<table id="departmentTable" class="table bg-white mb-0">
    <thead><tr><th>ID</th><th>部门名称</th><th>负责人ID</th><th>说明</th><th>状态</th><c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><th>操作</th></c:if></tr></thead>
    <tbody>
    <c:forEach items="${departments}" var="item">
        <tr>
            <td>${item.id}</td><td>${item.deptName}</td><td>${item.leaderId}</td><td>${item.description}</td><td>
                <c:choose>
                    <c:when test="${item.status == 1}">启用</c:when>
                    <c:when test="${item.status == 0}">停用</c:when>
                    <c:otherwise>未知状态(${item.status})</c:otherwise>
                </c:choose>
            </td>
            <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><td><button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteDepartment('${item.id}')">删除</button></td></c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="departmentPager" class="mt-3"></div>
<script>
    function openDepartmentModal() {
        $('#departmentForm')[0].reset();
        $('#deptId').val('');
        $('#departmentModal').modal('show');
    }
    function saveDepartment() {
        $.post('${pageContext.request.contextPath}/department/save', $('#departmentForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#departmentModal').modal('hide');
                location.reload();
            }
        });
    }
    function deleteDepartment(id) {
        $.post('${pageContext.request.contextPath}/department/delete', {id: id}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    initTablePagination('departmentTable', 'departmentPager', 8);
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
