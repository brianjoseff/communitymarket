# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# jQuery.ready ->
#   $('.js-s3_file_field').S3FileField
#     done: (e, data) -> console.log(data.result.url)

# $(document).ready ->
#   card = new Skeuocard($("#skeuocard"))
# 			
# primeSkeuocard = ->
# 	card = new Skeuocard($("#skeuocard"))
# 	card.bind "fieldFillStateWillChange.skeuocard", (e, _card, fieldName, newFillState) ->
# 		if card.isValid() == true
# 			alert "valid"
# 			$('input[type=submit]#upload_post').removeAttr('disabled')
# 
# $ ->
# 	$("input#premium").on "change", primeSkeuocard
# 
# $ ->
# 	$("form.form").submit ->
# 	  $('input[type=submit]').attr('disabled', 'disabled')
# $ ->
# 	$("#new_post").submit ->
# 	  $('input[type=submit]').attr('disabled', 'disabled')


#select hrly, disable other and lump
jQuery ->
	$("input.hrly").click ->
		#$("#other").prop "disabled", not $("#post_tier_id").prop("disabled") && $("input#post_price").val('')
		$("div#hrly_text").toggle()
		$("div#lump_text").hide()
		$("div#other_text").hide()
		
#select lump, disable hrly and other
jQuery ->
	$("input.lump").click ->
		#$("#other").prop "disabled", not $("#post_tier_id").prop("disabled") && $("input#post_price").val('')
		$("div#hrly_text").hide()
		$("div#lump_text").toggle()
		$("div#other_text").hide()

#select other, disable hrly and lump
jQuery ->
	$("input.other").click ->
		#$("#other").prop "disabled", not $("#post_tier_id").prop("disabled") && $("input#post_price").val('')
		$("div#hrly_text").hide()
		$("div#lump_text").hide()
		$("div#other_text").toggle()


# jQuery ->
# 	$("input.compensation").change ->
# 		$("#other").prop "disabled", not $("#post_tier_id").prop("disabled") && $("input#post_price").val('')
# 		alert "hello"
# 		$(this).child.toggle()

$ ->
	$("div.inactive-post a").replaceWith ->
	  $(this).contents()

## POST TAGS TOKEN INPUT
jQuery ->
  $("#post_tag_tokens").tokenInput "/tags.json",
    queryParam: "t"
    theme: "facebook"
    prePopulate: $("#post_tag_tokens").data("load")
		placeHolderText: 'furniture'
  $("ul.token-input-list-facebook").addClass("input-block-level")
  $("ul.token-input-list-facebook").addClass("inline")
  $("ul.token-input-list-facebook").addClass("negative-padding")


getGiftCard = ->
	
	y = $("#post_tier_id option:selected").val()
	x = parseInt(y)
	if x ==1
		$("span#gift_card_value").replaceWith("<span id='gift_card_value'>$2.50</span>")
		
	else if x==2
		
		$("span#gift_card_value").replaceWith("<span id='gift_card_value'>$6</span>")
		
	else if x==3
		$("span#gift_card_value").replaceWith("<span id='gift_card_value'>$12</span>")
			
	else if x==4
		$("span#gift_card_value").replaceWith("<span id='gift_card_value'>$30</span>")
		
	else if x==5
		$("span#gift_card_value").replaceWith("<span id='gift_card_value'>$60</span>")
		
	else if x==6
		$("span#gift_card_value").replaceWith("<span id='gift_card_value'>$110</span>")
		
		
$ ->
	$("#post_tier_id").on "change", getGiftCard
		
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
# 
# jQuery ->
#   $('#new_post').fileupload
#     dataType: "script"
#     add: (e, data) ->
#       types = /(\.|\/)(gif|jpe?g|png)$/i
#       file = data.files[0]
#       if types.test(file.type) || types.test(file.name)
#         data.context = $(tmpl("template-upload", file))
#         $('#new_post').append(data.context)
#         data.submit()
#       else
#         alert("#{file.name} is not a gif, jpeg, or png image file")
#     progress: (e, data) ->
#       if data.context
#         progress = parseInt(data.loaded / data.total * 100, 10)
#         data.context.find('.bar').css('width', progress + '%')



countChecked = ->
	n = $("input.group-box:checked").length
	if n > 2
		$("div#post_credit_fields").show()
		$("div#purchase_message").show()
	else
		$("div#post_credit_fields").hide()
		$("div#purchase_message").hide()	


$ ->
	$("input.group-box").on "click", countChecked



## DISABLE PRICE AREA WHEN FREE or REQUEST post type is chosen
checkType = ->
	n = $(this).data "id"
	# if n > 1
	# 	$("#price_field").val('')
	# 	$("div#get_paid_stuff").hide()
	# 			
	# else
	# 	$("div#get_paid_stuff").show()
	if n > 1 && n < 4
		$("#price_field").val('')
		$("div#get_paid_stuff").hide()
		$("div#compensation").hide()		
	else if n == 4 || n == 5
		$("#price_field").val('')
		$("div#get_paid_stuff").hide()
		$("div#compensation").show()
	else if n == 1
		$("div#get_paid_stuff").show()
		$("div#compensation").hide()
		
$ ->
	$("button.switch").on "click", checkType
	
	
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
######################################################################################
######################################################################################
######################################################################################


$ ->	
  $("#post_title").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "title is required."
# $ ->
#   $("#post_description").validate
#     expression: "if(VAL != '') return true; else return false;"
#     message: "Description is required."

# $ ->
#   $("#post_email").validate
#     expression: "if(VAL != '') return true; else return false;"
#     message: "Email is required."
# $ ->
# 	$("#post_email").validate
# 		expression: "if(VAL.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)) return true; else return false;"
# 		message: "Email format yo. check it: 'blah@blah.com'"
		

jQuery ->	
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	transaction.setupForm()

transaction =
	setupForm: ->
		$("#upload_post").click ->			
			#$('input[type=submit]').attr('disabled', true)
			# if $("form#new_post").find("input.group-box:checked").length > 2 && $('#card_number').length ||
			n = $("#card_number").val().length
			if n > 2				
				transaction.processCard()
				false
			else				
				$('#new_post')[0].submit()
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
		title: "Assign your post to a value tier. The instant someone clicks 'buy' on your post, an email with a coupon or giftcard will arrive in your inbox in lieu of normal payment."

## SHOW THE PRICE FIELD ON CASH BOX Check
jQuery ->
	$("input#post_cash").change ->
		$("#post_tier_id").prop "disabled", not $("#post_tier_id").prop("disabled") && $("input#post_price").val('')
		$("div.cash-field-cloak").toggle()		

## SHOW CREDIT CARD FIELDS ON PREMIUM CHECK BOX CLICK
jQuery ->
	$("input#premium").change ->
		# $("#card_number").validate
		# 	expression: "if(VAL != '') return true; else return false;"
		# 	    message: "credit card is required."
		# $("#post_tier_id").prop "disabled", not $("#post_tier_id").prop("disabled") && $("input#post_price").val('')
		x = $('input[type=submit]#upload_post').is(':disabled')
		
		if $('input[type=submit]#upload_post')
			if x==true
				$('input[type=submit]#upload_post').removeAttr('disabled')
			else
				$('input[type=submit]#upload_post').attr('disabled','disabled')
		$("div#post_credit_fields").toggle()
		$("div#purchase_message_premium").toggle()

# $ ->
# 	$("#card_number").validate
# 		expression: "if(VAL != '') return true; else return false;"
# 		message: "credit card is required."

#the function is getting called before the active button gets changed...so has old button id

		





# jQuery ->
# 	$("input#post_cash").change ->
# 		$("#post_tier_id").prop "disabled", not $("#post_tier_id").prop("disabled")
# 		$('input#post_cash').append "<p>$</p>"
# 		$('.cash-field-cloak').toggle "slide", 1
# 			direction: "right"
#$(document).ready ->

		

# ready = ->
#   $(".js-s3_file_field").each ->
#     id = $(this).attr('id')
#     $this = -> $("##{id}")
#     $progress = $(this).siblings('.progress').hide()
#     $meter = $progress.find('.meter')
#     $(this).S3FileField
#       add: (e, data) ->
#         $progress.show()
#         data.submit()
#       done: (e, data) ->
#         $progress.hide()
#         $this().attr(type: 'text', value: data.result.url, readonly: true)
#       fail: (e, data) ->
#         alert(data.failReason)
#       progress: (e, data) ->
#         progress = parseInt(data.loaded / data.total * 100, 10)
#         $meter.css(width: "#{progress}%")
# 
# $ ->
# 	ready
# $(document).on('page:load', ready)





