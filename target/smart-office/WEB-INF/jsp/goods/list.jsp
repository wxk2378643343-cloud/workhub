<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">物品申请</div>
        <div class="section-subtitle">${canApprove ? '管理员和负责人可以审批物品申请' : '员工提交办公物资申请并查看审批状态'}</div>
    </div>
    <button class="btn btn-primary" type="button" onclick="$('#goodsPanel').toggle()">新增申请</button>
</div>
<form id="goodsPanel" class="form-panel card card-body mb-3" style="display:none;" onsubmit="saveGoods();return false;">
    <div class="form-row">
        <div class="col"><input name="userId" class="form-control" placeholder="申请人ID" value="${sessionScope.loginUser.id}" readonly></div>
        <div class="col"><input name="goodsName" class="form-control" placeholder="物品名称"></div>
        <div class="col"><input name="quantity" class="form-control" placeholder="数量"></div>
        <div class="col"><input name="reason" class="form-control" placeholder="申请原因"></div>
        <div class="col"><button class="btn btn-primary btn-block">提交申请</button></div>
    </div>
</form>
<div class="table-wrap">
<table id="goodsTable" class="table bg-white mb-0">
    <thead><tr><th>申请人</th><th>物品</th><th>数量</th><th>原因</th><th>状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.userName}</td><td>${item.goodsName}</td><td>${item.quantity}</td><td>${item.reason}</td><td>${item.status}</td>
            <td>
                <c:if test="${canApprove}">
                    <button class="btn btn-sm btn-success" onclick="approveGoods('${item.id}','${item.userId}',1)">通过</button>
                    <button class="btn btn-sm btn-warning" onclick="approveGoods('${item.id}','${item.userId}',2)">驳回</button>
                </c:if>
                <c:if test="${canApprove}">
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteGoods('${item.id}','${item.userId}')">删除</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="goodsPager" class="mt-3"></div>
<script>
    function saveGoods() {
        $.post('${pageContext.request.contextPath}/goods/save', $('#goodsPanel').serialize() + '&status=0', function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
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
