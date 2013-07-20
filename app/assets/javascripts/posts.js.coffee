# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# $(document).ready ->
# 	$('#new_post').enableClientSideValidations();
# 	# $('#new_pos').ClientSideValidations.callbacks.element.pass = function(element, callback, eventData)
# $ ->	
# 	clientSideValidations.callbacks.element.pass = ($element, callback) ->
# 		console.log "Element passed", $element
# 		# Allow clientSideValidations to do it's thing.
# 		callback()
# 		$element.parent().find(".message").effect "fade", {}, 2000, callback
# 		$element.animate
# 		  backgroundColor: "#f0f0f0"
# 		, 1000, callback
# 		# Add a success message to give the user an ego lift.
# 		$element.closest("div.control-group").addClass "text-success"
# 		
# 		$message = $("<span class=\"message\">Great job!</span>")
# 		$element.after $message
	
$ ->	
  $("#post_title").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "title is required."
$ ->
  $("#post_description").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "Description is required."
$ ->
  $("#post_email").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "Email is required."
$ ->
	$("#post_email").validate
		expression: "if(VAL.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)) return true; else return false;"
		message: "Email format yo. check it: 'blah@blah.com'"
# $ ->
#   $("#password ").validate
# 		expression: "if(VAL.length > 6) return true; else return false"
# 		message: "Password should be longer than 6 characters. Rookie."
    
  # $("#car_year").validate
  #   expression: "if(VAL != '') return true; else return false;"
  #   message: "Year is required."
  #   
  # $("#car_year").validate
  #   expression: "if(VAL.match(/^\\d\\d\\d\\d$/)) return true; else return false;"
  #   message: "Invalid format."
$ ->
	$("input[type=checkbox]#post_cash").click ->
			$('.cash-field-cloak').toggle "slide", 1
				direction: "right"






# $("input[type=checkbox].group-box").on "click", countChecked
# countChecked= ->
# 	n = $("form#new_post").find("input.group-box:checked").length
#   #n = $("input:checked").length ? $("input:checked").length : 0
# 	if n > 2
# 	  # $("div").text n + ((if n is 1 then " is" else " are")) + " checked!"
# 		# make div tht pops up the credit modal
# 		#$("#dialog-form").dialog "open"
# 		alert "pay up"
# 	else
# 		#make modal disappear
# 		alert "you're good"
# 		#$("#dialog-form").dialog "close"
# 	








jQuery ->
  $("#post_tag_tokens").tokenInput "/tags.json",
    queryParam: "t"
    theme: "facebook"
    prePopulate: $("#post_tag_tokens").data("load")
  $("ul.token-input-list-facebook").addClass("input-block-level")
  $("ul.token-input-list-facebook").addClass("inline")
  $("ul.token-input-list-facebook").addClass("negative-padding")


	$("#post_tier_id").change ->
		$("input.cash-box").prop "disabled", not $("input.cash-box").prop("disabled")
	$("input#post_cash").change ->
		$("#post_tier_id").prop "disabled", not $("#post_tier_id").prop("disabled")
		$('input#post_cash').append "<p>$</p>"
		$('div#tier_explanation_wrapper').toggle "slide",
			direction: "top"
			, 800
		$('.cash-field-cloak').toggle "slide", 1
			direction: "right"
jQuery ->	
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	transaction.setupForm()

transaction =
	setupForm: ->
		$("#new_post").submit ->
			$('input[type=submit]').attr('disabled', true)
			if $("form#new_post").find("input.group-box:checked").length > 2 && $('#card_number').length
				transaction.processCard()
				false
			else
				true

	processCard: ->
		card =
			number: $('#card_number').val()
			cvc: $('#card_code').val()
			exp_month: $('#card_month').val()
			exp_year: $('#card_year').val()
		Stripe.createToken(card, transaction.handleStripeResponse)

	handleStripeResponse: (status, response) ->
		if status == 200
			$('#post_stripe_card_token').val(response.id)
			$('#new_post')[0].submit()
		else
			alert(response.error.message)
			$('input[type=submit]').attr('disabled', false)
$(document).ready ->
	$(".group-box").click ->		
		if $("form#new_post").find("input.group-box:checked").length > 2
			$("div#post-credit-fields").toggle "slide",
				direction: "right"
				, 100
		  $("#card_number").validate
		    expression: "if(VAL != '') return true; else return false;"
		    message: "credit card is required if you want to notify more than two groups."

		else
			$("div#post-credit-fields").hide()



