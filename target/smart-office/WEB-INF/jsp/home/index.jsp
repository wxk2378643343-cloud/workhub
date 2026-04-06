<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <div class="section-title mb-1">${loginUser.roleCode eq 'ADMIN' ? '管理员驾驶舱' : '员工工作台'}</div>
        <div class="section-subtitle">${loginUser.roleCode eq 'ADMIN' ? '查看企业整体运营和审批状态' : '处理今日待办并查看个人办公数据'}</div>
    </div>
    <span class="badge-soft">${loginUser.roleCode eq 'ADMIN' ? 'Admin View' : 'Employee View'}</span>
</div>
<div class="row">
    <div class="col-md-4 mb-3"><div class="stat-card stat-a"><div class="card-body"><div class="small">员工总数</div><h2 class="mb-0">${userCount}</h2></div></div></div>
    <div class="col-md-4 mb-3"><div class="stat-card stat-b"><div class="card-body"><div class="small">部门数量</div><h2 class="mb-0">${departmentCount}</h2></div></div></div>
    <div class="col-md-4 mb-3"><div class="stat-card stat-c"><div class="card-body"><div class="small">公告数量</div><h2 class="mb-0">${noticeCount}</h2></div></div></div>
    <div class="col-md-4 mb-3"><div class="stat-card stat-d"><div class="card-body"><div class="small">考勤记录</div><h2 class="mb-0">${attendanceCount}</h2></div></div></div>
    <div class="col-md-4 mb-3"><div class="stat-card stat-e"><div class="card-body"><div class="small">请假单</div><h2 class="mb-0">${leaveCount}</h2></div></div></div>
    <div class="col-md-4 mb-3"><div class="stat-card stat-f"><div class="card-body"><div class="small">会议预约</div><h2 class="mb-0">${meetingCount}</h2></div></div></div>
</div>
<div class="row mt-2">
    <div class="col-md-3 mb-3"><a class="quick-link" href="${pageContext.request.contextPath}/attendance/list"><div class="font-weight-bold mb-2">考勤打卡</div><div class="section-subtitle">查看今日考勤并快速上下班打卡</div></a></div>
    <div class="col-md-3 mb-3"><a class="quick-link" href="${pageContext.request.contextPath}/leave/list"><div class="font-weight-bold mb-2">请假审批</div><div class="section-subtitle">${loginUser.roleCode eq 'ADMIN' ? '集中处理员工请假申请' : '发起并跟踪个人请假单'}</div></a></div>
    <div class="col-md-3 mb-3"><a class="quick-link" href="${pageContext.request.contextPath}/report/list"><div class="font-weight-bold mb-2">工作报告</div><div class="section-subtitle">${loginUser.roleCode eq 'ADMIN' ? '查看团队日报周报月报' : '提交日报周报并查看审核结果'}</div></a></div>
    <div class="col-md-3 mb-3"><a class="quick-link" href="${pageContext.request.contextPath}/meeting/apply/list"><div class="font-weight-bold mb-2">会议预约</div><div class="section-subtitle">${loginUser.roleCode eq 'ADMIN' ? '统筹会议室资源与预约审核' : '发起会议申请并查看安排'}</div></a></div>
</div>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
