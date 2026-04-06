<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<h3 class="mb-3">会议预约</h3>
<form id="meetingForm" class="card card-body mb-3" onsubmit="saveMeeting();return false;">
    <div class="form-row mb-2">
        <div class="col"><input name="userId" class="form-control" placeholder="申请人ID" value="${sessionScope.loginUser.roleCode eq 'ADMIN' ? '' : sessionScope.loginUser.id}" ${sessionScope.loginUser.roleCode eq 'ADMIN' ? '' : 'readonly'}></div>
        <div class="col">
            <select name="roomId" class="form-control">
                <c:forEach items="${rooms}" var="room"><option value="${room.id}">${room.roomName}</option></c:forEach>
            </select>
        </div>
        <div class="col"><input name="subject" class="form-control" placeholder="会议主题"></div>
    </div>
    <div class="form-group"><textarea name="content" class="form-control" rows="3" placeholder="会议说明"></textarea></div>
    <div class="form-row mb-3">
        <div class="col"><input type="datetime-local" name="startTime" class="form-control"></div>
        <div class="col"><input type="datetime-local" name="endTime" class="form-control"></div>
        <div class="col"><input name="participants" class="form-control" placeholder="参会人员"></div>
    </div>
    <button class="btn btn-primary">提交预约</button>
</form>
<table class="table table-bordered bg-white">
    <thead><tr><th>申请人</th><th>会议室</th><th>主题</th><th>时间</th><th>状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.userName}</td><td>${item.roomName}</td><td>${item.subject}</td><td>${item.startTime} ~ ${item.endTime}</td><td>${item.status}</td>
            <td>
                <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
                    <button class="btn btn-sm btn-success" onclick="approveMeeting('${item.id}',1)">通过</button>
                    <button class="btn btn-sm btn-warning" onclick="approveMeeting('${item.id}',2)">驳回</button>
                </c:if>
                <button class="btn btn-sm btn-outline-danger" onclick="deleteMeeting('${item.id}')">删除</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script>
    function saveMeeting() {
        $.post('${pageContext.request.contextPath}/meeting/apply/save', $('#meetingForm').serialize() + '&status=0', function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function approveMeeting(id, status) {
        $.post('${pageContext.request.contextPath}/meeting/apply/approve', {id: id, status: status}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function deleteMeeting(id) {
        $.post('${pageContext.request.contextPath}/meeting/apply/delete', {id: id}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
