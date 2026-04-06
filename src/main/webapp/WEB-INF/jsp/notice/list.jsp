<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">公告管理</div>
        <div class="section-subtitle">发布置顶公告并维护企业内部通知</div>
    </div>
    <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
        <button class="btn btn-primary" type="button" onclick="$('#noticeForm').toggle()">新增公告</button>
    </c:if>
</div>
<c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
<form id="noticeForm" class="form-panel card card-body mb-3" style="display:none;" onsubmit="saveNotice();return false;">
    <div class="form-group"><input name="title" class="form-control" placeholder="公告标题"></div>
    <div class="form-group"><textarea name="content" class="form-control" rows="4" placeholder="公告内容"></textarea></div>
    <div class="form-row">
        <div class="col"><input name="isTop" class="form-control" value="0" placeholder="是否置顶"></div>
        <div class="col"><input name="status" class="form-control" value="1" placeholder="状态"></div>
        <div class="col"><button class="btn btn-primary btn-block">发布公告</button></div>
    </div>
</form>
</c:if>
<div class="table-wrap">
<table id="noticeTable" class="table bg-white mb-0">
    <thead><tr><th>标题</th><th>发布人</th><th>发布时间</th><th>置顶</th><c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><th>操作</th></c:if></tr></thead>
    <tbody>
    <c:forEach items="${notices}" var="item">
        <tr>
            <td>${item.title}</td><td>${item.publisherName}</td><td>${item.publishTime}</td><td>${item.isTop}</td>
            <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><td><button class="btn btn-sm btn-outline-danger" onclick="deleteNotice('${item.id}')">删除</button></td></c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="noticePager" class="mt-3"></div>
<script>
    function saveNotice() {
        $.post('${pageContext.request.contextPath}/notice/save', $('#noticeForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    function deleteNotice(id) {
        $.post('${pageContext.request.contextPath}/notice/delete', {id: id}, function (res) {
            alert(res.msg);
            if (res.code === 200) location.reload();
        });
    }
    initTablePagination('noticeTable', 'noticePager', 8);
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
