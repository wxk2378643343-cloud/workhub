<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">部门管理</div>
        <div class="section-subtitle">维护组织结构、负责人和部门描述</div>
    </div>
    <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
        <button class="btn btn-primary" type="button" onclick="$('#departmentForm').toggle()">新增部门</button>
    </c:if>
</div>
<c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
<form id="departmentForm" class="form-panel card card-body mb-3" style="display:none;" onsubmit="saveDepartment();return false;">
    <div class="form-row">
        <input type="hidden" name="id" id="deptId">
        <div class="col"><input name="deptName" class="form-control" placeholder="部门名称"></div>
        <div class="col"><input name="description" class="form-control" placeholder="部门描述"></div>
        <div class="col"><button class="btn btn-primary btn-block">保存部门</button></div>
    </div>
</form>
</c:if>
<div class="table-wrap">
<table id="departmentTable" class="table bg-white mb-0">
    <thead><tr><th>ID</th><th>部门名称</th><th>负责人ID</th><th>说明</th><th>状态</th><c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><th>操作</th></c:if></tr></thead>
    <tbody>
    <c:forEach items="${departments}" var="item">
        <tr>
            <td>${item.id}</td><td>${item.deptName}</td><td>${item.leaderId}</td><td>${item.description}</td><td>${item.status}</td>
            <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><td><button class="btn btn-sm btn-outline-danger" onclick="deleteDepartment('${item.id}')">删除</button></td></c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="departmentPager" class="mt-3"></div>
<script>
    function saveDepartment() {
        $.post('${pageContext.request.contextPath}/department/save', $('#departmentForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
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
