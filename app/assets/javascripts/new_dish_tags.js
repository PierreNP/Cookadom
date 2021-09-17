document.addEventListener("DOMContentLoaded", (event) => {
    $('input[type=checkbox]').change(function(e) {
        if ($('input[type=checkbox]:checked').length > 3) {
            $(this).prop('checked', false);
            $('#checkbox_max').removeClass('d-none');
            $('#checkbox_max').addClass('text-danger', 'fw-bold');
        }
    })
});