<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/layout-top.jsp" %>
<h3 class="mb-3">数据统计</h3>
<div class="card">
    <div class="card-body">
        <div id="mainChart" style="height:420px;"></div>
    </div>
</div>
<script>
    $.get('${pageContext.request.contextPath}/stats/summary', function (res) {
        const chart = echarts.init(document.getElementById('mainChart'));
        const names = Object.keys(res.data);
        const values = Object.values(res.data);
        chart.setOption({
            color: ['#2a9d8f'],
            tooltip: {},
            xAxis: {type: 'category', data: names},
            yAxis: {type: 'value'},
            series: [{type: 'bar', data: values, barWidth: 48}]
        });
    });
</script>
<%@ include file="/WEB-INF/jsp/common/layout-bottom.jsp" %>
