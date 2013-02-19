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
//= require chosen-jquery
//= require jquery.tokeninput
//= require bootstrap
//= require_tree .

function borrow()
    {
    if (document.getElementById('post_borrow').checked == true)
    {
    document.getElementById('post_tier_id').setAttribute('disabled','disabled');

    }      

    else
	{
	      document.getElementById('post_tier_id').removeAttribute('disabled');
	      }
    }
function cash()
    {
    if (document.getElementById('post_cash').checked == true)
    {
    document.getElementById('post_tier_id').setAttribute('disabled','disabled');

    }      

    else
	{
	      document.getElementById('post_tier_id').removeAttribute('disabled');
	      }
    }
function wanted()
    {
    if (document.getElementById('post_post_category_id_32').checked == true)
    {
    document.getElementById('post_tier_id').setAttribute('disabled','disabled');

    }      

    else
	{
	      document.getElementById('post_tier_id').removeAttribute('disabled');
	      }
    }
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
