<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">请假管理</div>
        <div class="section-subtitle">${canApprove ? '管理员和负责人可以审批请假申请' : '提交个人请假申请并查看审批结果'}</div>
    </div>
    <button class="btn btn-primary" type="button" onclick="openLeaveModal()">新增请假</button>
</div>

<div class="modal fade" id="leaveModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title">新增请假</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="leaveForm" onsubmit="saveLeave();return false;">
                <div class="modal-body">
                    <input type="hidden" name="userId" value="${sessionScope.loginUser.id}">
                    <input type="hidden" name="status" value="0">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>请假类型</label>
                            <select name="leaveType" class="form-control" required>
                                <option value="">请选择</option>
                                <option value="事假">事假</option>
                                <option value="病假">病假</option>
                                <option value="年假">年假</option>
                                <option value="调休">调休</option>
                                <option value="婚假">婚假</option>
                                <option value="产假">产假</option>
                                <option value="丧假">丧假</option>
                                <option value="其他">其他</option>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label>请假天数</label>
                            <input name="days" type="number" min="0.5" step="0.5" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group mb-0">
                        <label>请假原因</label>
                        <input name="reason" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交请假</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="table-wrap">
<table id="leaveTable" class="table bg-white mb-0">
    <thead>
    <tr>
        <th>ID</th>
        <th>申请人</th>
        <th>类型</th>
        <th>天数</th>
        <th>原因</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.id}</td>
            <td>${item.userName}</td>
            <td>${item.leaveType}</td>
            <td>${item.days}</td>
            <td>${item.reason}</td>
            <td>
                <c:choose>
                    <c:when test="${item.status == 0}">待审批</c:when>
                    <c:when test="${item.status == 1}">已通过</c:when>
                    <c:when test="${item.status == 2}">已驳回</c:when>
                    <c:otherwise>未知状态(${item.status})</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${canApprove}">
                    <button class="btn btn-sm btn-success" type="button" onclick="approveLeave('${item.id}','${item.userId}',1)">通过</button>
                    <button class="btn btn-sm btn-warning" type="button" onclick="approveLeave('${item.id}','${item.userId}',2)">驳回</button>
                    <button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteLeave('${item.id}','${item.userId}')">删除</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>

<div id="leavePager" class="mt-3"></div>

<script>
    function openLeaveModal() {
        $('#leaveForm')[0].reset();
        $('#leaveModal').modal('show');
    }

    function saveLeave() {
        $.post('${pageContext.request.contextPath}/leave/save', $('#leaveForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#leaveModal').modal('hide');
                location.reload();
            }
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
