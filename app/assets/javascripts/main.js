$(document).ready(function(){
    $('#buy_modal').on('shown', function() {
        $('#new_transaction').enableClientSideValidations();
        $('#post_id').val($(this).attr('data-postid'));
    });
});