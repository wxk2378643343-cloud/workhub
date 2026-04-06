<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">会议预约</h3>
    <button class="btn btn-primary" type="button" onclick="openMeetingModal()">新增预约</button>
</div>

<div class="modal fade" id="meetingModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title">新增会议预约</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="meetingForm" onsubmit="saveMeeting();return false;">
                <div class="modal-body">
                    <input type="hidden" name="userId" value="${sessionScope.loginUser.id}">
                    <div class="form-row mb-2">
                        <div class="col-md-4">
                            <label>申请人</label>
                            <input class="form-control" value="${sessionScope.loginUser.realName}" readonly>
                        </div>
                        <div class="col-md-4">
                            <label>会议室</label>
                            <select name="roomId" class="form-control">
                                <c:forEach items="${rooms}" var="room"><option value="${room.id}">${room.roomName}</option></c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label>会议主题</label>
                            <input name="subject" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>会议说明</label>
                        <textarea name="content" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="form-row mb-0">
                        <div class="col-md-4">
                            <label>开始时间</label>
                            <input type="datetime-local" name="startTime" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label>结束时间</label>
                            <input type="datetime-local" name="endTime" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label>参会人员</label>
                            <input name="participants" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交预约</button>
                </div>
            </form>
        </div>
    </div>
</div>

<table class="table table-bordered bg-white">
    <thead><tr><th>申请人</th><th>会议室</th><th>主题</th><th>时间</th><th>状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.userName}</td><td>${item.roomName}</td><td>${item.subject}</td><td><fmt:formatDate value="${item.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /> ~ <fmt:formatDate value="${item.endTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td><td>
                <c:choose>
                    <c:when test="${item.status == 0}">待审批</c:when>
                    <c:when test="${item.status == 1}">已通过</c:when>
                    <c:when test="${item.status == 2}">已驳回</c:when>
                    <c:otherwise>未知状态(${item.status})</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
                    <button class="btn btn-sm btn-success" type="button" onclick="approveMeeting('${item.id}',1)">通过</button>
                    <button class="btn btn-sm btn-warning" type="button" onclick="approveMeeting('${item.id}',2)">驳回</button>
                </c:if>
                <button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteMeeting('${item.id}')">删除</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script>
    function openMeetingModal() {
        $('#meetingForm')[0].reset();
        $('#meetingModal').modal('show');
    }

    function saveMeeting() {
        $.post('${pageContext.request.contextPath}/meeting/apply/save', $('#meetingForm').serialize() + '&status=0', function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#meetingModal').modal('hide');
                location.reload();
            }
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
