<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">工作报告</div>
        <div class="section-subtitle">
            ${canApprove ? '管理员和负责人可以审核、删除工作报告' : '员工可以提交并查看自己的工作报告'}
        </div>
    </div>
    <button class="btn btn-primary" type="button" onclick="openReportModal()">新增报告</button>
</div>

<div class="modal fade" id="reportModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title">新增工作报告</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="reportForm" onsubmit="saveReport();return false;">
                <div class="modal-body">
                    <input type="hidden" name="userId" value="${sessionScope.loginUser.id}">
                    <div class="form-row mb-2">
                        <div class="col-md-4">
                            <select name="reportType" class="form-control" required>
                                <option value="">请选择类型</option>
                                <option value="日报">日报</option>
                                <option value="周报">周报</option>
                                <option value="月报">月报</option>
                            </select>
                        </div>
                        <div class="col-md-8">
                            <input name="title" class="form-control" placeholder="标题" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <textarea name="content" class="form-control" rows="4" placeholder="工作内容" required></textarea>
                    </div>
                    <div class="form-group mb-0">
                        <textarea name="plan" class="form-control" rows="3" placeholder="后续计划"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交报告</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="table-wrap">
<table id="reportTable" class="table bg-white mb-0">
    <thead><tr><th>提交人</th><th>类型</th><th>标题</th><th>状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.userName}</td>
            <td>${item.reportType}</td>
            <td>${item.title}</td>
            <td>
                <c:choose>
                    <c:when test="${item.status == 0}">待审核</c:when>
                    <c:when test="${item.status == 1}">已通过</c:when>
                    <c:when test="${item.status == 2}">已驳回</c:when>
                    <c:otherwise>未知状态(${item.status})</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${canApprove}">
                    <button class="btn btn-sm btn-success" type="button" onclick="approveReport('${item.id}','${item.userId}',1)">通过</button>
                    <button class="btn btn-sm btn-warning" type="button" onclick="approveReport('${item.id}','${item.userId}',2)">驳回</button>
                    <button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteReport('${item.id}','${item.userId}')">删除</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="reportPager" class="mt-3"></div>

<script>
    function openReportModal() {
        $('#reportForm')[0].reset();
        $('#reportModal').modal('show');
    }

    function saveReport() {
        $.post('${pageContext.request.contextPath}/report/save', $('#reportForm').serialize() + '&status=0', function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#reportModal').modal('hide');
                location.reload();
            }
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
