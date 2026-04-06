<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <div class="section-title mb-1">公告管理</div>
        <div class="section-subtitle">发布置顶公告并维护企业内部通知</div>
    </div>
    <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
        <button class="btn btn-primary" type="button" onclick="openNoticeModal()">新增公告</button>
    </c:if>
</div>

<c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}">
<div class="modal fade" id="noticeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius:16px; border:0;">
            <div class="modal-header">
                <h5 class="modal-title">新增公告</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="noticeForm" onsubmit="saveNotice();return false;">
                <div class="modal-body">
                    <div class="form-group">
                        <label>公告标题</label>
                        <input name="title" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>公告内容</label>
                        <textarea name="content" class="form-control" rows="4" required></textarea>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>是否置顶</label>
                            <select name="isTop" class="form-control">
                                <option value="0">否</option>
                                <option value="1">是</option>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label>状态</label>
                            <select name="status" class="form-control">
                                <option value="1">启用</option>
                                <option value="0">停用</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">发布公告</button>
                </div>
            </form>
        </div>
    </div>
</div>
</c:if>

<div class="table-wrap">
<table id="noticeTable" class="table bg-white mb-0">
    <thead><tr><th>标题</th><th>发布人</th><th>发布时间</th><th>置顶</th><c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><th>操作</th></c:if></tr></thead>
    <tbody>
    <c:forEach items="${notices}" var="item">
        <tr>
            <td>${item.title}</td><td>${item.publisherName}</td><td><fmt:formatDate value="${item.publishTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td><td>
                <c:choose>
                    <c:when test="${item.isTop == 1}">是</c:when>
                    <c:when test="${item.isTop == 0}">否</c:when>
                    <c:otherwise>未知(${item.isTop})</c:otherwise>
                </c:choose>
            </td>
            <c:if test="${sessionScope.loginUser.roleCode eq 'ADMIN'}"><td><button class="btn btn-sm btn-outline-danger" type="button" onclick="deleteNotice('${item.id}')">删除</button></td></c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<div id="noticePager" class="mt-3"></div>
<script>
    function openNoticeModal() {
        $('#noticeForm')[0].reset();
        $('#noticeForm select[name=isTop]').val('0');
        $('#noticeForm select[name=status]').val('1');
        $('#noticeModal').modal('show');
    }
    function saveNotice() {
        $.post('${pageContext.request.contextPath}/notice/save', $('#noticeForm').serialize(), function (res) {
            alert(res.msg);
            if (res.code === 200) {
                $('#noticeModal').modal('hide');
                location.reload();
            }
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
