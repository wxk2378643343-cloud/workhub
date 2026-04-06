<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">请假管理</div>
        <div class="section-subtitle">${canApprove ? '管理员和负责人可以审批所属员工请假单' : '提交个人请假申请并查看审批结果'}</div>
    </div>
    <button class="btn btn-primary" type="button" onclick="$('#leaveForm').toggle()">新增请假</button>
</div>
<form id="leaveForm" class="form-panel card card-body mb-3" style="display:none;" onsubmit="saveLeave();return false;">
    <div class="form-row">
        <div class="col"><input name="userId" class="form-control" placeholder="申请人ID" value="${sessionScope.loginUser.id}" readonly></div>
        <div class="col"><input name="leaveType" class="form-control" placeholder="请假类型"></div>
        <div class="col"><input name="days" class="form-control" placeholder="请假天数"></div>
        <div class="col"><input name="reason" class="form-control" placeholder="请假原因"></div>
        <div class="col d-none"><input name="status" class="form-control" value="0"></div>
        <div class="col"><button class="btn btn-primary btn-block">提交请假</button></div>
    </div>
</form>
<div class="table-wrap">
<table id="leaveTable" class="table bg-white mb-0">
    <thead><tr><th>ID</th><th>申请人</th><th>类型</th><th>天数</th><th>原因</th><th>状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.id}</td><td>${item.userName}</td><td>${item.leaveType}</td><td>${item.days}</td><td>${item.reason}</td><td>${item.status}</td>
            <td>
                <c:if test="${canApprove}">
                    <button class="btn btn-sm btn-success" onclick="approveLeave('${item.id}','${item.userId}',1)">通过</button>
                    <button class="btn btn-sm btn-warning" onclick="approveLeave('${item.id}','${item.userId}',2)">驳回</button>
                </c:if>
                <c:if test="${canApprove}">
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteLeave('${item.id}','${item.userId}')">删除</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="leavePager" class="mt-3"></div>
<script>
    function saveLeave() {
        $.post('${pageContext.request.contextPath}/leave/save', $('#leaveForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function approveLeave(id, userId, status) {
        $.post('${pageContext.request.contextPath}/leave/approve', {id: id, applicantUserId: userId, status: status}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function deleteLeave(id, userId) {
        $.post('${pageContext.request.contextPath}/leave/delete', {id: id, applicantUserId: userId}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    initTablePagination('leaveTable', 'leavePager', 8);
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
