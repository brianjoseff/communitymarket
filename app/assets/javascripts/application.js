// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.tokeninput
//= require bootstrap
//= require_tree .
//= require rails.validations

$(document).ready(function(){
	$('.form').enableClientSideValidations();
    $('.form').on('shown', function() {
      $(ClientSideValidations.selectors.forms).validate();
    });
};

$(document).ready(function(){
	//any radio button but "for sale" selected deactivates cash/tier fields and puts
	//grey transparent box over it
	$('radio_button#').click(function(){
		$('cash_check_box').hide();
		$('tier_select').hide();
		$('sale_objects').toggleClass('grey_overlay');
	})
});

//if a user checks the premium box, make the credit card fields visible
//if a user checks more than 2 groups to make it visible to then
//make the credit card fields visible as well
$(document).ready(function(){
	//count the number of group checkboxes checked
	$('')
	$('input.group:checkbox:checked').size();
	$('#premium_check_box').click(function(){
		var counter = $('form#posts').find('input.group_boxes:checked').length;
		$('credit_card_fields').show();
		$('sale_objects').toggleClass('grey_overlay');
	})
});

$(document).ready(function(){
	$('.group_box').mousedown(function(){
		$('div#post_credit_fields').toggle("slide", { direction: "right" }, 800);
		         return false;
	});
});

// click the buy button: various modals
$(document).ready(function() {
  var $buy_dialog = $('#buy_modal').dialog({ 
    autoOpen: false, 
    title: 'Edit',
    modal: true,
    draggable: false,
	buttons: {
	            "Save": function() {
	                    $("#new_transaction").submit(function(){
						    var valuesToSubmit = $(this).serialize();
						    $.ajax({
						        url: $(this).attr('action'), //sumbits it to the given url of the form
						        data: valuesToSubmit,
								type: 'POST',
						        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
						    }).success(function(json){
						        //act on result.
						    });
						    return false;
						});
	                    $('#buy_modal').dialog( "close" );
	            },
	            Cancel: function() {
	                $( this ).dialog( "close" );
	            }
	        }

	});
	// $('.buy-button').bind('ajax:before', function() {
	//         $(this).data('params', { post_id: 'post_feed_item.id', tier_id: 'post_feed_item.tier_id', price: 'post_feed_item.price' });
	//     });
	$('.buy-button').click(function(){
	    $buy_dialog.dialog('open');
  });
});


//FROM JQUERY UI DOCS...source code

// $(function() {
//     var email = $( "#email" ),
//       password = $( "#password" ),
//       allFields = $( [] ).add( email ).add( password ),
//       tips = $( ".validateTips" );
//  
//     function updateTips( t ) {
//       tips
//         .text( t )
//         .addClass( "ui-state-highlight" );
//       setTimeout(function() {
//         tips.removeClass( "ui-state-highlight", 1500 );
//       }, 500 );
//     }
//  
//     function checkLength( o, n, min, max ) {
//       if ( o.val().length > max || o.val().length < min ) {
//         o.addClass( "ui-state-error" );
//         updateTips( "Length of " + n + " must be between " +
//           min + " and " + max + "." );
//         return false;
//       } else {
//         return true;
//       }
//     }
//  
//     function checkRegexp( o, regexp, n ) {
//       if ( !( regexp.test( o.val() ) ) ) {
//         o.addClass( "ui-state-error" );
//         updateTips( n );
//         return false;
//       } else {
//         return true;
//       }
//     }
//  
//     $( "#buy_modal" ).dialog({
//       autoOpen: false,
//       height: 300,
//       width: 350,
//       modal: true,
//       buttons: {
//         "Create an account": function() {
//           var bValid = true;
//           allFields.removeClass( "ui-state-error" );
//  
//           bValid = bValid && checkLength( email, "email", 6, 80 );
//           bValid = bValid && checkLength( password, "password", 5, 16 );
//  
//           bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+$/i, "Username may consist of a-z, 0-9, underscores, begin with a letter." );
//           // From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
//           bValid = bValid && checkRegexp( email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "eg. ui@jquery.com" );
//           bValid = bValid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
//  
//           if ( bValid ) {
//				//change landing page somehow
//				//archive post
//             $( "#users tbody" ).append( "<tr>" +
//               "<td>" + name.val() + "</td>" +
//               "<td>" + email.val() + "</td>" +
//               "<td>" + password.val() + "</td>" +
//             "</tr>" );
//             $( this ).dialog( "close" );
//           }
//         },
//         Cancel: function() {
//           $( this ).dialog( "close" );
//         }
//       },
//       close: function() {
//         allFields.val( "" ).removeClass( "ui-state-error" );
//       }
//     });
//  
//     $( "#create-user" )
//       .button()
//       .click(function() {
//         $( "#dialog-form" ).dialog( "open" );
//       });
//   });


//FIRST ATTEMPT AT MODAL CREDIT CARD AND USER CREATION CHARGE
//non-user STRIPE credit card upload
//if password is present
////make new users and new customer
//else
////charge card
// $(document).ready(function(){
// var user;
// 
// jQuery(function() {
//   Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
//   return user.setupForm();
// });
// 
// user = {
//   setupForm: function() {
//     return $('#non_user_credit_form').submit(function() {
//       $('input[type=submit]').attr('disabled', true);
// 	  if($('password').length) {
// 		//create user
// 	}
// 	  	
//       if ($('#card_number').length) {
//         user.processCard();
//         return false;
//       } else {
//         return true;
//       }
//     });
//   },
//   processCard: function() {
//     var card;
//     card = {
//       number: $('#card_number').val(),
//       cvc: $('#card_code').val(),
//       expMonth: $('#card_month').val(),
//       expYear: $('#card_year').val()
//     };
//     return Stripe.createToken(card, user.handleStripeResponse);
//   },
//   handleStripeResponse: function(status, response) {
//     if (status === 200) {
//       $('#user_stripe_card_token').val(response.id);
//       return $('#non_user_credit_form')[0].submit();
//     } else {
//       alert(response.error.message);
//       $('#stripe_error').text(response.error.message);
//       return $('input[type=submit]').attr('disabled', false);
//     }
//   }
// };});
// 
//	//TAKE 2
// //below is take 2 &*&*&*&*&*&*&*&*&*&*&*&*&*&&*&*&*&*&
// 
// $(document).ready(function(){
// 	Stripe.setPublishableKey('YOUR_PUBLISHABLE_KEY');
// 
//    function stripeResponseHandler(status, response) {
//      if (response.error) {
//        // Show the errors on the form
//        $('.payment-errors').text(response.error.message);
//        $('.submit-button').prop('disabled', false);
//      } else {
//        var $form = $('#non_user_credit_form');
//        // token contains id, last4, and card type
//        var token = response.id;
//        // Insert the token into the form so it gets submitted to the server
//        $form.append($('<input type="hidden" name="stripeToken" />').val(token));
//        // and submit...changed from form.get(0).submit() to below
//        $form.[0].submit();
//      }
//    }
// 
//    $(function() {
//      $('#non_user_credit_form').submit(function(event) {
//        // Disable the submit button to prevent repeated clicks
//        $('.submit-button').prop('disabled', true);
// 
//        Stripe.createToken({
//          number: $('.card-number').val(),
//          cvc: $('.card-cvc').val(),
//          exp_month: $('.card-expiry-month').val(),
//          exp_year: $('.card-expiry-year').val()
//        }, stripeResponseHandler);
// 
//        // Prevent the form from submitting with the default action
//        return false;
//      });
//    });
// });

///FUUCK





// $(document).ready(function(){
//     $('#auth').dialog({
//         modal: true,
//         autoOpen: false,
//         title: "Enter your information",
//         buttons: {
//             "Sign In": function() {
//                 $('#sign_in').submit();
//                 $(this).dialog("close");
//             }
// 			"Sign up": function() {
// 				$('#sign_up').submit();
//                 $(this).dialog("close");
// 			}
//         }
//     });
// 
//     // Show the modal form when clicked.
//     $('.join-button').click(function() {
//         $("#auth").dialog('open');
//     });
// 	$('#sign_in').submit(function() {  
// 	    var valuesToSubmit = $(this).serialize();
// 	    $.ajax({
// 	        url: $(this).attr('action'), //sumbits it to the given url of the form
// 	        data: valuesToSubmit,
// 	        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
// 	    }).success(function(json){
// 	        //act on result.
// 	    });
// 	    return false; // prevents normal behaviour
// 	});
// 	$('#sign_up').submit(function() {  
// 	    var valuesToSubmit = $(this).serialize();
// 	    $.ajax({
// 	        url: $(this).attr('action'), //sumbits it to the given url of the form
// 	        data: valuesToSubmit,
// 	        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
// 	    }).success(function(json){
// 	        //act on result.
// 	    });
// 	    return false; // prevents normal behaviour
// 	});
// });





// $(document).ready(function() {
//     // Style the buttons
//     $("button, input:submit, input:button, a#jql, input:radio").button();
//     
//     // Hook up form validation
//     //$('#emailPost2').validate();
//     
//     // Make the form a modal dialog and create a button
//     $('#postModal').dialog({
//         modal: true,
//         autoOpen: false,
//         title: "Enter your information",
//         buttons: {
//             "Post": function() {
//                 $('#submit-post').submit();
//                 $(this).dialog("close");
//             }
//         }
//     });
// 
//     // Show the modal form when clicked.
//     $('#create-post').click(function() {
//         $("#postModal").dialog('open');
//     });
// 
// });

// $(document).ready(function() {
//   $('#create_article').click(function(e) {
//     var url = $(this).attr('href');
//     var dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
//       autoOpen: false,
//       width: 520,
//       modal: true,
//       open: function() {
//         return $(this).load(url + ' #content');
//       },
//       close: function() {
//         $('#dialog-form').remove();
//       }
//     });
//     dialog_form.dialog('open');
//     e.preventDefault();
//   });
// });
// function setPostForm(){
// 	$function() {
// 	  var title = $( "#title" ),
// 	    email = $( "#email" ),
// 	    description = $( "#description" ),
// 	    allFields = $( [] ).add( title ).add( email ).add( description ),
// 	    tips = $( ".validateTips" );
// 
// 	  function updateTips( t ) {
// 	    tips
// 	      .text( t )
// 	      .addClass( "ui-state-highlight" );
// 	    setTimeout(function() {
// 	      tips.removeClass( "ui-state-highlight", 1500 );
// 	    }, 500 );
// 	  }
// 
// 	  function checkLength( o, n, min, max ) {
// 	    if ( o.val().length > max || o.val().length < min ) {
// 	      o.addClass( "ui-state-error" );
// 	      updateTips( "Length of " + n + " must be between " +
// 	        min + " and " + max + "." );
// 	      return false;
// 	    } else {
// 	      return true;
// 	    }
// 	  }
// 
// 	  function checkRegexp( o, regexp, n ) {
// 	    if ( !( regexp.test( o.val() ) ) ) {
// 	      o.addClass( "ui-state-error" );
// 	      updateTips( n );
// 	      return false;
// 	    } else {
// 	      return true;
// 	    }
// 	  }
// 
// 	  $( "#dialog-form" )
// 		.load('/posts/new', {post_type: '#item_type_select'})
// 		.dialog({
// 	    autoOpen: false,
// 	    height: 300,
// 	    width: 350,
// 	    modal: true,
// 	    buttons: {
// 	      "Create new post": function() {
// 	        var bValid = true;
// 	        allFields.removeClass( "ui-state-error" );
// 
// 	        bValid = bValid && checkLength( title, "title", 3, 80 );
// 	        bValid = bValid && checkLength( email, "email", 6, 80 );
// 	        bValid = bValid && checkLength( description, "description", 5, 250 );
// 
// 	        bValid = bValid && checkRegexp( title, /^[a-z]([0-9a-z_])+$/i, "title may consist of a-z, 0-9, underscores, begin with a letter." );
// 	        // From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
// 	        bValid = bValid && checkRegexp( email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "eg. ui@jquery.com" );
// 	        // password regex:
// 			// bValid = bValid && checkRegexp( description, /^([0-9a-zA-Z])+$/, "description field only allow : a-z 0-9" );
// 			
// 			// adds new user/post to table
// 	        // if ( bValid ) {
// 	        // 	          $( "#users tbody" ).append( "<tr>" +
// 	        // 	            "<td>" + title.val() + "</td>" +
// 	        // 	            "<td>" + email.val() + "</td>" +
// 	        // 	            "<td>" + description.val() + "</td>" +
// 	        // 	          "</tr>" );
// 	        // 	          $( this ).dialog( "close" );
// 	        // 	        }
// 	        // 	      },
// 	        // 	      Cancel: function() {
// 	        // 	        $( this ).dialog( "close" );
// 	        // 	      }
// 	        // 	    },
// 	        // 	    close: function() {
// 	        // 	      allFields.val( "" ).removeClass( "ui-state-error" );
// 	        // 	    }
// 	  });
// 
// 	  $( "#create-post" )
// 	    .button()
// 	    .click(function() {
// 	      $( "#dialog-form" ).dialog( "open" );
// 	    });
// 	});
// }
