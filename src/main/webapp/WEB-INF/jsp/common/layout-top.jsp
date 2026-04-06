<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>智慧办公系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.5.1/dist/echarts.min.js"></script>
    <style>
        :root {
            --sidebar-bg: #1f2d3d;
            --sidebar-accent: #1890ff;
            --page-bg: #eef2f6;
            --card-shadow: 0 10px 30px rgba(31,45,61,.08);
            --text-main: #243447;
        }
        body { background: var(--page-bg); color: var(--text-main); font-family: "Segoe UI", "PingFang SC", "Microsoft YaHei", sans-serif; }
        .app-shell { min-height: 100vh; }
        .sidebar { min-height: 100vh; background: linear-gradient(180deg, #223042, #17212b); color: #fff; }
        .brand-block { padding: 22px 20px; border-bottom: 1px solid rgba(255,255,255,.08); }
        .brand-title { font-size: 20px; font-weight: 700; letter-spacing: 1px; margin-bottom: 6px; }
        .brand-subtitle { font-size: 12px; color: rgba(255,255,255,.55); margin: 0; }
        .main-pane { padding: 28px 30px 36px; }
        .topbar { background: rgba(255,255,255,.72); border: 1px solid rgba(255,255,255,.7); box-shadow: var(--card-shadow); border-radius: 18px; padding: 14px 18px; margin-bottom: 24px; backdrop-filter: blur(12px); }
        .page-card { border: 0; border-radius: 18px; box-shadow: var(--card-shadow); }
        .page-card .card-body { padding: 22px; }
        .table-wrap, .form-panel { background: #fff; border-radius: 18px; box-shadow: var(--card-shadow); }
        .table-wrap { padding: 10px 16px 18px; }
        .table thead th { border-top: 0; color: #6b7a8c; font-weight: 600; font-size: 13px; }
        .table td, .table th { vertical-align: middle; }
        .section-title { font-size: 28px; font-weight: 700; margin-bottom: 18px; }
        .section-subtitle { color: #7b8794; font-size: 14px; }
        .stat-card { border: 0; border-radius: 18px; color: #fff; overflow: hidden; box-shadow: var(--card-shadow); }
        .stat-card .card-body { padding: 22px; }
        .stat-a { background: linear-gradient(135deg, #1890ff, #36cfc9); }
        .stat-b { background: linear-gradient(135deg, #13c2c2, #52c41a); }
        .stat-c { background: linear-gradient(135deg, #fa8c16, #faad14); }
        .stat-d { background: linear-gradient(135deg, #722ed1, #9254de); }
        .stat-e { background: linear-gradient(135deg, #eb2f96, #ff7875); }
        .stat-f { background: linear-gradient(135deg, #2f54eb, #597ef7); }
        .quick-link { display: block; background: #fff; border-radius: 16px; padding: 18px; box-shadow: var(--card-shadow); color: var(--text-main); text-decoration: none; height: 100%; }
        .quick-link:hover { text-decoration: none; color: var(--sidebar-accent); transform: translateY(-2px); transition: .2s ease; }
        .badge-soft { background: rgba(24,144,255,.12); color: #1677ff; border-radius: 999px; padding: 6px 10px; font-size: 12px; }
        .btn-primary { background: linear-gradient(135deg, #1677ff, #4096ff); border: 0; border-radius: 10px; }
        .btn-outline-danger, .btn-outline-secondary, .btn-success, .btn-warning { border-radius: 10px; }
        .form-control, .custom-select { border-radius: 10px; min-height: 42px; }
    </style>
</head>
<body>
<div class="container-fluid app-shell">
    <div class="row">
        <div class="col-md-2 p-0 sidebar">
            <div class="brand-block">
                <div class="brand-title">WorkHub</div>
                <p class="brand-subtitle">Smart Office Console</p>
            </div>
            <div class="p-3">
                <%@ include file="/WEB-INF/jsp/common/menu.jsp" %>
            </div>
        </div>
        <div class="col-md-10 main-pane">
            <div class="topbar d-flex justify-content-between align-items-center">
                <div>
                    <div class="font-weight-bold">企业级智慧办公系统</div>
                    <div class="section-subtitle">统一管理企业用户、审批、考勤、公告和会议业务</div>
                </div>
                <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">
                        ${sessionScope.loginUser.realName}
                        <span class="badge-soft ml-2">${sessionScope.loginUser.roleCode}</span>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">个人中心</a>
                        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">退出登录</a>
                    </div>
                </div>
            </div>
