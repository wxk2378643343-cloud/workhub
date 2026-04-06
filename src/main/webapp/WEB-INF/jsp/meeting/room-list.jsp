<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<h3 class="mb-3">会议室管理</h3>
<c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
<form id="roomForm" class="card card-body mb-3" onsubmit="saveRoom();return false;">
    <div class="form-row">
        <div class="col"><input name="roomName" class="form-control" placeholder="会议室名称"></div>
        <div class="col"><input name="capacity" class="form-control" placeholder="容纳人数"></div>
        <div class="col"><input name="location" class="form-control" placeholder="地点"></div>
        <div class="col"><button class="btn btn-primary btn-block">保存会议室</button></div>
    </div>
</form>
</c:if>
<table class="table table-bordered bg-white">
    <thead><tr><th>名称</th><th>容量</th><th>地点</th><th>设备</th><th>状态</th><c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><th>操作</th></c:if></tr></thead>
    <tbody>
    <c:forEach items="${rooms}" var="item">
        <tr>
            <td>${item.roomName}</td><td>${item.capacity}</td><td>${item.location}</td><td>${item.equipment}</td><td>${item.status}</td>
            <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><td><button class="btn btn-sm btn-outline-danger" onclick="deleteRoom('${item.id}')">删除</button></td></c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script>
    function saveRoom() {
        $.post('${pageContext.request.contextPath}/meeting/room/save', $('#roomForm').serialize() + '&status=1', function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
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
