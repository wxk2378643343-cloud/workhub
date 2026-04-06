<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">会议室管理</h3>
    <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
        <button class="btn btn-primary" type="button" onclick="openCreateModal()">新增会议室</button>
    </c:if>
</div>

<div class="table-wrap">
    <table class="table table-bordered bg-white mb-0" id="roomTable">
        <thead>
        <tr>
            <th>名称</th>
            <th>容量</th>
            <th>地点</th>
            <th>设备</th>
            <th>状态</th>
            <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><th>操作</th></c:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${rooms}" var="item">
            <tr>
                <td>${item.roomName}</td>
                <td>${item.capacity}</td>
                <td>${item.location}</td>
                <td>${item.equipment}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.status == 1}">启用</c:when>
                        <c:when test="${item.status == 0}">停用</c:when>
                        <c:otherwise>未知状态(${item.status})</c:otherwise>
                    </c:choose>
                </td>
                <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
                    <td class="text-nowrap">
                        <button class="btn btn-sm btn-outline-primary"
                                type="button"
                                data-id="${item.id}"
                                data-room-name="<c:out value='${item.roomName}'/>"
                                data-capacity="${item.capacity}"
                                data-location="<c:out value='${item.location}'/>"
                                data-equipment="<c:out value='${item.equipment}'/>"
                                data-status="${item.status}"
                                onclick="openEditModal(this)">编辑</button>
                        <button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteRoom('${item.id}')">删除</button>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
<div class="modal fade" id="roomModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title" id="roomModalTitle">新增会议室</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="roomForm" onsubmit="saveRoom();return false;">
                <div class="modal-body">
                    <input type="hidden" name="id" id="roomId">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>会议室名称</label>
                            <input name="roomName" class="form-control" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label>容纳人数</label>
                            <input name="capacity" type="number" min="1" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>地点</label>
                            <input name="location" class="form-control" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label>设备</label>
                            <input name="equipment" class="form-control">
                        </div>
                    </div>
                    <div class="form-group mb-0">
                        <label>状态</label>
                        <select name="status" class="form-control">
                            <option value="1">启用</option>
                            <option value="0">停用</option>
                        </select>
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
</c:if>

<script>
    function openCreateModal() {
        $('#roomModalTitle').text('新增会议室');
        $('#roomForm')[0].reset();
        $('#roomId').val('');
        $('#roomForm select[name=status]').val('1');
        $('#roomModal').modal('show');
    }

    function openEditModal(btn) {
        var $btn = $(btn);
        $('#roomModalTitle').text('编辑会议室');
        $('#roomId').val($btn.data('id'));
        $('#roomForm input[name=roomName]').val($btn.data('roomName'));
        $('#roomForm input[name=capacity]').val($btn.data('capacity'));
        $('#roomForm input[name=location]').val($btn.data('location'));
        $('#roomForm input[name=equipment]').val($btn.data('equipment'));
        $('#roomForm select[name=status]').val(($btn.data('status') + '') || '1');
        $('#roomModal').modal('show');
    }

    function saveRoom() {
        $.post('${pageContext.request.contextPath}/meeting/room/save', $('#roomForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#roomModal').modal('hide');
                location.reload();
            }
        });
    }

    function deleteRoom(id) {
        $.post('${pageContext.request.contextPath}/meeting/room/delete', {id: id}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
</script>

<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
