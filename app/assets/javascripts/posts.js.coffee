# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# monify = ->
# 	if $("form#new_post").find("input.group-box:checked").length > 2
# 		$("div#post-credit-fields").show "slide",
# 			direction: "right"
# 			, 100
# 		$("#card_number").validate
# 	    expression: "if(VAL != '') return true; else return false;"
# 	    message: "credit card is required if you want to notify more than two groups."
# 	else
# 		$("div#post-credit-fields").hide

# $(document).ready ->
#   $checkboxes = $("input[type=\"checkbox\"].group-box")
#   $checkboxes.change ->
#     countCheckedCheckboxes = $checkboxes.filter(":checked").length
# 		if countCheckedCheckboxes > 2
# 			$("div#post-credit-fields").show "slide",
# 				direction: "right"
# 				, 100
# 			$("#card_number").validate
# 		    expression: "if(VAL != '') return true; else return false;"
# 		    message: "credit card is required if you want to notify more than two groups."
# 		else
# 			$("div#post-credit-fields").hide
countChecked = ->
	n = $("input.group-box:checked").length
	if n > 2
		$("div#post-credit-fields").show()
	else
		$("div#post-credit-fields").hide()
	


$ ->
	$("input.group-box").on "click", countChecked


$ ->
	$(".btn-group > .btn, .btn[data-toggle=\"button\"]").click ->
	  buttonClasses = ["btn-primary", "btn-danger", "btn-warning", "btn-success", "btn-info", "btn-inverse"]
	  $this = $(this)
	  if $(this).attr("class-toggle") isnt `undefined` and not $(this).hasClass("disabled")
	    btnGroup = $this.parent(".btn-group")
	    btnToggleClass = $this.attr("class-toggle")
	    btnCurrentClass = $this.hasAnyClass(buttonClasses)
	    if btnGroup.attr("data-toggle") is "buttons-radio"
	      return false  if $this.hasClass("active")
	      activeButton = btnGroup.find(".btn.active")
	      activeBtnClass = activeButton.hasAnyClass(buttonClasses)
	      activeButton.removeClass(activeBtnClass).addClass(activeButton.attr("class-toggle")).attr "class-toggle", activeBtnClass
	    $this.removeClass(btnCurrentClass).addClass(btnToggleClass).attr "class-toggle", btnCurrentClass

	$.fn.hasAnyClass = (classesToCheck) ->
	  i = 0

	  while i < classesToCheck.length
	    return classesToCheck[i]  if @hasClass(classesToCheck[i])
	    i++
	  false
# $ ->
# 	$("#zipcode_submit").click (e) -?
# 	e.preventDefault(e)
# 	$("#zipcode").val $(this).parent.data "search_param"

$ ->
	$(".switch").click (e) ->
		e.preventDefault()
		$("#post_cateogry_button_value").val $(this).data "id"
			
# $ ->
# 	$("input.group-box").change ->
# 	  monify()

# $ ->
# 	$("input.group-box").change ->		
# 		if $("form#new_post").find("input.group-box:checked").length > 2
# 			$("div#post-credit-fields").show "slide",
# 				direction: "right"
# 				, 100
# 		  $("#card_number").validate
# 		    expression: "if(VAL != '') return true; else return false;"
# 		    message: "credit card is required if you want to notify more than two groups."
# 		else
# 			$("div#post-credit-fields").hide
			
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



# $ ->
# 	$("input[type=checkbox]#post_cash").click ->
# 			$('.cash-field-cloak').toggle "slide", 1
# 				direction: "right"






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

## TOOL TIPS
$ ->
	$("#get_paid_stuff").tooltip
		trigger: "hover"
		placement: "left"
		title: "Assign your post to a value tier. The instant someone clicks 'buy' on your post, an email with a coupon or giftcard will arrive in your inbox."

## SHOW THE PRICE FIELD ON CASH BOX Check
jQuery ->
	$("input#post_cash").change ->
		$("#post_tier_id").prop "disabled", not $("#post_tier_id").prop("disabled") && $("input#post_price").val('')
		$("div.cash-field-cloak").toggle()		
		

## POST TAGS TOKEN INPUT
jQuery ->
  $("#post_tag_tokens").tokenInput "/tags.json",
    queryParam: "t"
    theme: "facebook"
    prePopulate: $("#post_tag_tokens").data("load")
  $("ul.token-input-list-facebook").addClass("input-block-level")
  $("ul.token-input-list-facebook").addClass("inline")
  $("ul.token-input-list-facebook").addClass("negative-padding")


# jQuery ->
# 	$("input#post_cash").change ->
# 		$("#post_tier_id").prop "disabled", not $("#post_tier_id").prop("disabled")
# 		$('input#post_cash').append "<p>$</p>"
# 		$('.cash-field-cloak').toggle "slide", 1
# 			direction: "right"
#$(document).ready ->

		
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






