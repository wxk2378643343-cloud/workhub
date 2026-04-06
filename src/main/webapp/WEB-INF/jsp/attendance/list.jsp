<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">考勤打卡</div>
        <div class="section-subtitle">仅支持当前登录用户上下班打卡</div>
    </div>
</div>

<div class="row mb-3">
    <div class="col-md-8">
        <div class="page-card card">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <div class="font-weight-bold mb-2">今日打卡状态</div>
                    <div class="section-subtitle">
                        上班：
                        <c:choose>
                            <c:when test="${todayRecord != null && todayRecord.checkInTime != null}">
                                <fmt:formatDate value="${todayRecord.checkInTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </c:when>
                            <c:otherwise>未打卡</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="section-subtitle">
                        下班：
                        <c:choose>
                            <c:when test="${todayRecord != null && todayRecord.checkOutTime != null}">
                                <fmt:formatDate value="${todayRecord.checkOutTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </c:when>
                            <c:otherwise>未打卡</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="section-subtitle">状态：${todayRecord.dayStatus == null ? '待打卡' : todayRecord.dayStatus}</div>
                </div>
                <div>
                    <button class="btn btn-primary mr-2" type="button" onclick="checkIn()">上班打卡</button>
                    <button class="btn btn-outline-secondary" type="button" onclick="checkOut()">下班打卡</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="table-wrap">
<table class="table bg-white mb-0">
    <thead>
    <tr>
        <th>员工</th>
        <th>日期</th>
        <th>上班</th>
        <th>下班</th>
        <th>状态</th>
        <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><th>操作</th></c:if>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${records}" var="item">
        <tr>
            <td>${item.userName}</td>
            <td><fmt:formatDate value="${item.attendanceDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td><fmt:formatDate value="${item.checkInTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td><fmt:formatDate value="${item.checkOutTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>${item.dayStatus}</td>
            <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
                <td>
                    <button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteAttendance('${item.id}')">删除</button>
                </td>
            </c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>

<script>
    function handleResponse(res) {
        if (!res || typeof res.code === 'undefined') {
            alert('请求失败，请刷新页面后重试');
            return;
        }
        alert(res.msg || (res.code === 200 ? '操作成功' : '操作失败'));
        if (res.code === 200) {
            location.reload();
        }
    }

    function handleError(xhr) {
        var msg = '请求失败';
        if (xhr && xhr.status) {
            msg += '（HTTP ' + xhr.status + '）';
        }
        alert(msg);
    }

    function deleteAttendance(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/attendance/delete',
            type: 'POST',
            dataType: 'json',
            data: {id: id},
            success: handleResponse,
            error: handleError
        });
    }

    function checkIn() {
        $.ajax({
            url: '${pageContext.request.contextPath}/attendance/checkIn',
            type: 'POST',
            dataType: 'json',
            success: handleResponse,
            error: handleError
        });
    }

    function checkOut() {
        $.ajax({
            url: '${pageContext.request.contextPath}/attendance/checkOut',
            type: 'POST',
            dataType: 'json',
            success: handleResponse,
            error: handleError
        });
    }
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
