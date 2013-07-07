# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	transaction.setupForm()

transaction =
	setupForm: ->
		$("#new_transaction").submit ->
			$('input[type=submit]').attr('disabled', true)
			transaction.processCard()
			valuesToSubmit = $("#new_transaction").serialize()
			$("#new_transaction_modal").modal "hide"
			$.ajax(
				url: "posts/"+$('#new_transaction_link').data('post_id')+"/transactions"
				data: valuesToSubmit
				type: "POST"
			).success (data, status) ->
				#update the DOM?

			false
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, transaction.handleStripeResponse)
  
	handleStripeResponse: (status, response) ->
		if status == 200
			alert 'hello'
			$('#transaction_stripe_card_token').val(response.id)
			# $('#new_transaction')[0].submit()
		else
			alert(response.error.message)		
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
