        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function initTablePagination(tableId, pagerId, pageSize) {
        var $table = $('#' + tableId);
        var $rows = $table.find('tbody tr');
        if ($rows.length === 0) {
            $('#' + pagerId).html('');
            return;
        }
        var totalPages = Math.ceil($rows.length / pageSize);
        function render(page) {
            $rows.hide();
            $rows.slice((page - 1) * pageSize, page * pageSize).show();
            var html = '';
            html += '<nav><ul class="pagination justify-content-end mb-0">';
            html += '<li class="page-item ' + (page === 1 ? 'disabled' : '') + '"><a class="page-link" href="#" data-page="' + (page - 1) + '">上一页</a></li>';
            for (var i = 1; i <= totalPages; i++) {
                html += '<li class="page-item ' + (i === page ? 'active' : '') + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
            }
            html += '<li class="page-item ' + (page === totalPages ? 'disabled' : '') + '"><a class="page-link" href="#" data-page="' + (page + 1) + '">下一页</a></li>';
            html += '</ul></nav>';
            $('#' + pagerId).html(html);
            $('#' + pagerId + ' a.page-link').click(function (e) {
                e.preventDefault();
                var target = parseInt($(this).data('page'));
                if (!isNaN(target) && target >= 1 && target <= totalPages) {
                    render(target);
                }
            });
        }
        render(1);
    }
</script>
</body>
</html>
