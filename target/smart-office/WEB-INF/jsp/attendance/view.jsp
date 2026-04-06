<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">考勤查看</div>
        <div class="section-subtitle">仅管理员和领导可查看</div>
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
            <th>异常说明</th>
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
                <td>${item.exceptionRemark}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
