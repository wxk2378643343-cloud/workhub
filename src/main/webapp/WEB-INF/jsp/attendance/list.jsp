<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">考勤打卡</div>
        <div class="section-subtitle">${sessionScope.loginUser.roleCode eq 'ADMIN' ? '查看全员考勤和异常记录' : '完成上下班打卡并查看个人考勤历史'}</div>
    </div>
</div>
<c:if test="${sessionScope.loginUser.roleCode ne 'ADMIN'}">
<div class="row mb-3">
    <div class="col-md-8">
        <div class="page-card card">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <div class="font-weight-bold mb-2">今日打卡状态</div>
                    <div class="section-subtitle">上班：${todayRecord.checkInTime == null ? '未打卡' : todayRecord.checkInTime}</div>
                    <div class="section-subtitle">下班：${todayRecord.checkOutTime == null ? '未打卡' : todayRecord.checkOutTime}</div>
                    <div class="section-subtitle">状态：${todayRecord.dayStatus == null ? '待打卡' : todayRecord.dayStatus}</div>
                </div>
                <div>
                    <button class="btn btn-primary mr-2" onclick="checkIn()">上班打卡</button>
                    <button class="btn btn-outline-secondary" onclick="checkOut()">下班打卡</button>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>
<c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
<form id="attendanceForm" class="form-panel card card-body mb-3" onsubmit="saveAttendance();return false;">
    <div class="form-row">
        <div class="col"><input name="userId" class="form-control" placeholder="员工ID"></div>
        <div class="col"><input name="dayStatus" class="form-control" placeholder="状态"></div>
        <div class="col"><input name="exceptionRemark" class="form-control" placeholder="异常说明"></div>
        <div class="col"><button class="btn btn-primary btn-block">保存考勤</button></div>
    </div>
</form>
</c:if>
<div class="table-wrap">
<table class="table bg-white mb-0">
    <thead><tr><th>员工</th><th>日期</th><th>上班</th><th>下班</th><th>状态</th><c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><th>操作</th></c:if></tr></thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.userName}</td><td>${item.attendanceDate}</td><td>${item.checkInTime}</td><td>${item.checkOutTime}</td><td>${item.dayStatus}</td>
            <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><td><button class="btn btn-sm btn-outline-danger" onclick="deleteAttendance('${item.id}')">删除</button></td></c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<script>
    function saveAttendance() {
        $.post('${pageContext.request.contextPath}/attendance/save', $('#attendanceForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function deleteAttendance(id) {
        $.post('${pageContext.request.contextPath}/attendance/delete', {id: id}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function checkIn() {
        $.post('${pageContext.request.contextPath}/attendance/checkIn', function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function checkOut() {
        $.post('${pageContext.request.contextPath}/attendance/checkOut', function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
