<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">物品申请</div>
        <div class="section-subtitle">
            ${canApprove ? '管理员和负责人可以审批物品申请' : '员工提交办公物资申请并查看审批状态'}
        </div>
    </div>
    <button class="btn btn-primary" type="button" onclick="openApplyModal()">新增申请</button>
</div>

<div class="modal fade" id="applyModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title">新增物品申请</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="goodsForm" onsubmit="saveGoods();return false;">
                <div class="modal-body">
                    <input type="hidden" name="userId" value="${sessionScope.loginUser.id}">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>物品名称</label>
                            <select name="goodsName" class="form-control" required>
                                <option value="">请选择物品</option>
                                <c:choose>
                                    <c:when test="${empty goodsItems}">
                                        <option value="" disabled>暂无物品，请先到物品管理新增</option>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${goodsItems}" var="g">
                                            <option value="${g.goodsName}">
                                                ${g.goodsName}<c:if test="${g.status != 1}">（停用）</c:if>
                                            </option>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label>数量</label>
                            <input name="quantity" type="number" min="1" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group mb-0">
                        <label>申请原因</label>
                        <input name="reason" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交申请</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="table-wrap">
<table id="goodsTable" class="table bg-white mb-0">
    <thead><tr><th>申请人</th><th>物品名称</th><th>数量</th><th>原因</th><th>状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.userName}</td>
            <td>${item.goodsName}</td>
            <td>${item.quantity}</td>
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
                    <button class="btn btn-sm btn-success" type="button" onclick="approveGoods('${item.id}','${item.userId}',1)">通过</button>
                    <button class="btn btn-sm btn-warning" type="button" onclick="approveGoods('${item.id}','${item.userId}',2)">驳回</button>
                    <button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteGoods('${item.id}','${item.userId}')">删除</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="goodsPager" class="mt-3"></div>

<script>
    function openApplyModal() {
        $('#goodsForm')[0].reset();
        $('#applyModal').modal('show');
    }

    function saveGoods() {
        $.post('${pageContext.request.contextPath}/goods/save', $('#goodsForm').serialize() + '&status=0', function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#applyModal').modal('hide');
                location.reload();
            }
        });
    }

    function approveGoods(id, userId, status) {
        $.post('${pageContext.request.contextPath}/goods/approve', {id: id, applicantUserId: userId, status: status, approverId: '${sessionScope.loginUser.id}'}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }

    function deleteGoods(id, userId) {
        $.post('${pageContext.request.contextPath}/goods/delete', {id: id, applicantUserId: userId}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }

    initTablePagination('goodsTable', 'goodsPager', 8);
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
