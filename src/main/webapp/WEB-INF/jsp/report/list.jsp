<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">工作报告</div>
        <div class="section-subtitle">${canApprove ? '管理员和负责人可以审核、删除工作报告' : '员工可以提交并查看自己的工作报告'}</div>
    </div>
    <button class="btn btn-primary" type="button" onclick="$('#reportPanel').toggle()">新增报告</button>
</div>
<form id="reportPanel" class="form-panel card card-body mb-3" style="display:none;" onsubmit="saveReport();return false;">
    <div class="form-row mb-2">
        <div class="col"><input name="userId" class="form-control" placeholder="提交人ID" value="${sessionScope.loginUser.id}" readonly></div>
        <div class="col"><input name="reportType" class="form-control" placeholder="日报/周报/月报"></div>
        <div class="col"><input name="title" class="form-control" placeholder="标题"></div>
    </div>
    <div class="form-group"><textarea name="content" class="form-control" rows="4" placeholder="工作内容"></textarea></div>
    <div class="form-group"><textarea name="plan" class="form-control" rows="3" placeholder="后续计划"></textarea></div>
    <button class="btn btn-primary">提交报告</button>
</form>
<div class="table-wrap">
<table id="reportTable" class="table bg-white mb-0">
    <thead><tr><th>提交人</th><th>类型</th><th>标题</th><th>状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.userName}</td><td>${item.reportType}</td><td>${item.title}</td><td>${item.status}</td>
            <td>
                <c:if test="${canApprove}">
                    <button class="btn btn-sm btn-success" onclick="approveReport('${item.id}','${item.userId}',1)">通过</button>
                    <button class="btn btn-sm btn-warning" onclick="approveReport('${item.id}','${item.userId}',2)">驳回</button>
                </c:if>
                <c:if test="${canApprove}">
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteReport('${item.id}','${item.userId}')">删除</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="reportPager" class="mt-3"></div>
<script>
    function saveReport() {
        $.post('${pageContext.request.contextPath}/report/save', $('#reportPanel').serialize() + '&status=0', function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function approveReport(id, userId, status) {
        $.post('${pageContext.request.contextPath}/report/approve', {id: id, applicantUserId: userId, status: status, reviewerId: '${sessionScope.loginUser.id}'}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function deleteReport(id, userId) {
        $.post('${pageContext.request.contextPath}/report/delete', {id: id, applicantUserId: userId}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    initTablePagination('reportTable', 'reportPager', 8);
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
