# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

(->
  $.fn.jqueryLoad = $.fn.load
  $.fn.load = (url, params, callback) ->
    $this = $(this)
    cb = (if $.isFunction(params) then params else callback or $.noop)
    wrapped = (responseText, textStatus, XMLHttpRequest) ->
      cb responseText, textStatus, XMLHttpRequest
      $this.trigger "loaded"

    if $.isFunction(params)
      params = wrapped
    else
      callback = wrapped
    $this.jqueryLoad url, params, callback
    this
)()



jQuery ->	
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	transaction.setupForm()

transaction =
	setupForm: ->
		$("#new_transaction_button").click ->
			$('input[type=submit]').attr('disabled', true)
			if $('#card_number').length
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
			$('#transaction_stripe_card_token').val(response.id)
			$('#new_transaction')[0].submit()
		else
			alert(response.error.message)

# $ ->
# 	$("#transaction").on "loaded", () ->
# 		jQuery ->	
# 			Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
# 			transaction.setupForm()
# 	
# 		transaction =
# 			setupForm: ->
# 				$("#new_transaction_button").click ->
# 					$('input[type=submit]').attr('disabled', true)
# 					if $('#card_number').length
# 		        transaction.processCard()
# 		        false
# 		      else
# 		        true
# 
# 			processCard: ->
# 				card =
# 					number: $('#card_number').val()
# 					cvc: $('#card_code').val()
# 					exp_month: $('#card_month').val()
# 					exp_year: $('#card_year').val()
# 				Stripe.createToken(card, transaction.handleStripeResponse)
# 
# 			handleStripeResponse: (status, response) ->
# 				if status == 200
# 					$('#transaction_stripe_card_token').val(response.id)
# 					$('#new_transaction')[0].submit()
# 				else
# 					alert(response.error.message)




# jQuery ->
# 	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
# 	#alert "poop"
# 	$("#new_transaction_link").click ->
# 		# $("#transaction").modal('show')
# 		$("#transaction_modal").on "shown", ->
# 			alert "hello"
# 			transaction.setupForm()
# 
# transaction =
# 	setupForm: ->
# 		$("#new_transaction_button").click (event)->
# 			#event.preventDefault()
# 			$('input[type=submit]').attr('disabled', true)
# 			transaction.processCard()
# 			valuesToSubmit = $("#new_transaction").serialize()
# 			$("#new_transaction_modal").modal "hide"
# 			.ajax(
# 				url: "/posts"
# 				data: valuesToSubmit
# 				type: "POST"
# 			).success (data, status) ->
# 			
# 			false
# 
# 	processCard: ->
# 		card =
# 			number: $('#card_number').val()
# 			cvc: $('#card_code').val()
# 			exp_month: $('#card_month').val()
# 			exp_year: $('#card_year').val()
# 		Stripe.createToken(card, transaction.handleStripeResponse)
# 
# 	handleStripeResponse: (status, response) ->
# 		if status == 200
# 			$('#transaction_stripe_card_token').val(response.id)
# 			#$('#new_transaction')[0].submit()
# 		else
# 			alert(response.error.message)

# $ ->
#   $("#transaction form").submit ->
#     $("#transaction form input[type=\"submit\"]").attr "disabled", true
#     if $("#card_number").length
#       card =
#         number: $("#card_number").val()
#         cvc: $("#card_code").val()
#         expMonth: $("#card_month").val()
#         expYear: $("#card_year").val()
# 
#       Stripe.createToken card, (status, response) ->
#         if status is 200
#           $("#stripe_token").val response.id
#           $("#payment form")[0].submit()
#         else
#           alert response.error.message
#           $("#payment form input[type=\"submit\"]").attr "disabled", false
# 
#     false			
			
# $ ->
# 	$("#new_transaction_button").click ->
# 		$('input[type=submit]').attr('disabled', true)
# 		valuesToSubmit = $("#new_transaction").serialize()
# 		$("#new_transaction_modal").modal "hide"
# 		$.ajax(
# 			url: "/posts/"
# 			data: valuesToSubmit
# 			type: "POST"
# 		).success (data, status) ->
# 			#update the DOM?
# 
# 		false
#+$('#new_transaction_link').data('post_id')+"/transactions"					
# $ ->
# 	$("#new_transaction_button").click ->
# 	  valuesToSubmit = $("#new_transaction").serialize()
# 	  $("#new_transaction_modal").modal "hide"
# 	  $.ajax(
# 	    url: "posts/"+$('#new_transaction_link').data('post_id')+"/transactions"
# 	    data: valuesToSubmit
# 	    type: "POST"
# 	  ).success (data, status) ->
# 			#update the DOM?
# 		
# 	  false
#update a User with credit card information	
# $ ->
# 	$("#edit_transaction_button").click ->
# 	  valuesToSubmit = $("#edit_transaction").serialize()
# 	  $("#edit_transaction_modal").modal "hide"
# 	  $.ajax(
# 	    url: "/transactions/"+id
# 	    data: valuesToSubmit
# 	    type: "PUT"
# 	  ).success (data, status) ->
# 			#update the DOM?
# 
# 	  false
