<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">物品管理</h3>
    <button class="btn btn-primary" type="button" onclick="openCreateModal()">新增物品</button>
</div>

<div class="table-wrap">
    <table class="table table-bordered bg-white mb-0" id="itemTable">
        <thead>
        <tr>
            <th>名称</th>
            <th>单位</th>
            <th>库存</th>
            <th>状态</th>
            <th>备注</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${records}" var="item">
            <tr>
                <td>${item.goodsName}</td>
                <td>${item.unit}</td>
                <td>${item.stock}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.status == 1}">启用</c:when>
                        <c:when test="${item.status == 0}">停用</c:when>
                        <c:otherwise>未知状态(${item.status})</c:otherwise>
                    </c:choose>
                </td>
                <td>${item.remark}</td>
                <td class="text-nowrap">
                    <button class="btn btn-sm btn-outline-primary"
                            type="button"
                            data-id="${item.id}"
                            data-goods-name="<c:out value='${item.goodsName}'/>"
                            data-unit="<c:out value='${item.unit}'/>"
                            data-stock="${item.stock}"
                            data-status="${item.status}"
                            data-remark="<c:out value='${item.remark}'/>"
                            onclick="openEditModal(this)">修改</button>
                    <button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteItem('${item.id}')">删除</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal fade" id="itemModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title" id="itemModalTitle">新增物品</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="itemForm" onsubmit="saveItem();return false;">
                <div class="modal-body">
                    <input type="hidden" name="id" id="itemId">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>物品名称</label>
                            <input name="goodsName" class="form-control" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label>单位</label>
                            <input name="unit" class="form-control" placeholder="如：个/盒/包">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>库存</label>
                            <input name="stock" type="number" min="0" class="form-control" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label>状态</label>
                            <select name="status" class="form-control">
                                <option value="1">启用</option>
                                <option value="0">停用</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group mb-0">
                        <label>备注</label>
                        <input name="remark" class="form-control">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function openCreateModal() {
        $('#itemModalTitle').text('新增物品');
        $('#itemForm')[0].reset();
        $('#itemId').val('');
        $('#itemForm select[name=status]').val('1');
        $('#itemModal').modal('show');
    }

    function openEditModal(btn) {
        var $btn = $(btn);
        $('#itemModalTitle').text('修改物品');
        $('#itemId').val($btn.data('id'));
        $('#itemForm input[name=goodsName]').val($btn.data('goodsName'));
        $('#itemForm input[name=unit]').val($btn.data('unit'));
        $('#itemForm input[name=stock]').val($btn.data('stock'));
        $('#itemForm select[name=status]').val(($btn.data('status') + '') || '1');
        $('#itemForm input[name=remark]').val($btn.data('remark'));
        $('#itemModal').modal('show');
    }

    function saveItem() {
        $.post('${pageContext.request.contextPath}/goods/item/save', $('#itemForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#itemModal').modal('hide');
                location.reload();
            }
        });
    }

    function deleteItem(id) {
        $.post('${pageContext.request.contextPath}/goods/item/delete', {id: id}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
</script>

<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
