$(document).ready(function(){

    $('#buy_modal').on('shown', function() {
        $('#new_transaction').enableClientSideValidations();
        $('#post_id').val($(this).attr('data-postid'));
    });
    $('#sign_up_modal').on('shown', function() {
        $('#new_user').enableClientSideValidations();
        $("#user_email").validate({
          expression: "if(VAL != '') return true; else return false;",
          message: "email is required."
        });
        $("#user_password").validate({
          expression: "if(VAL != '') return true; else return false;",
          message: "password is required."
        });
        $('#user_id').val($(this).attr('data-userid'));
        $('.btn-primary').click(function(e) {
          $('.btn-primary').click(function(e) {
            e.preventDefault();
            var valuesToSubmit = $(this).serialize();
            $.ajax({
                type: 'POST',
                url: "/users",//$(this).attr('action'), //sumbits it to the given url of the form
                data: valuesToSubmit,
                dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
            }).success(function(json){
                $('#sign_up_modal').modal('hide');
            });
            return false;
            
          });
            
        });

    });
    // display validation errors for the "request invitation" form
    // if ($('.alert-error').length > 0) {
    //   $("#request-invite").modal('toggle');
    // }
    // 
    // // use AJAX to submit the "request invitation" form
    // $('#invitation_button').on('click', function() {
    //   var email = $('form #user_email').val();
    //   var dataString = 'user[email]='+ email;
    //   $.ajax({
    //     type: "POST",
    //     url: "/users",
    //     data: dataString,
    //     success: function(data) {
    //       $('#request-invite').html(data);
    //       loadSocial();
    //     }
    //   });
    //   return false;
    // });
    // $('#new_user').submit(function() {  
    //     var valuesToSubmit = $(this).serialize();
    //     $.ajax({
    //         type: 'POST',
    //         url: $(this).attr('action'), //sumbits it to the given url of the form
    //         data: valuesToSubmit,
    //         dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    //     }).success(function(json){
    //         //act on result.
    //         $('#sign_up_modal').modal('hide');
    //     });
    //     return false; // prevents normal behaviour
    // });

    
    // $( "#sign_up_modal" ).dialog({
    //                  autoOpen: false,
    //                  height: 400,
    //                  width: 350,
    //                  modal: true,
    //                  closeOnEscape: true,
    //                  resizable:false,
    //                  buttons: {
    //                      "Create an account": function() {
    //                              $("#form").submit();
    //                              $( this ).dialog( "close" );
    //                      },
    //                      Cancel: function() {
    //                          $( this ).dialog( "close" );
    //                      }
    //                  }
    //              });
    //     $('form').submit(function() {  
    //         var valuesToSubmit = $(this).serialize();
    //         $.ajax({
    //             url: $(this).attr('action'), //sumbits it to the given url of the form
    //             data: valuesToSubmit,
    //             type: 'POST',
    //             dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    //         }).success(function(json){
    //             //act on result.
    //         });
    //         return false; // prevents normal behaviour
    //     });
});

