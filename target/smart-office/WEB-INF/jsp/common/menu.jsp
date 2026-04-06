<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="list-group">
    <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/home/index">首页概览</a>
    <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
        <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/user/list">用户管理</a>
        <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/department/list">部门管理</a>
    </c:if>
    <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/notice/list">公告通知</a>
    <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/attendance/list">考勤打卡</a>
    <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/leave/list">请假管理</a>
    <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/report/list">工作报告</a>
    <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/goods/list">物品申请</a>
    <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
        <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/meeting/rooms">会议室管理</a>
    </c:if>
    <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/meeting/apply/list">会议预约</a>
    <a class="list-group-item list-group-item-action bg-transparent text-white border-0 rounded-lg mb-1" href="${pageContext.request.contextPath}/stats/index">数据统计</a>
</div>
