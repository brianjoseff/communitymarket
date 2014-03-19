ajaxReload = ->
	$(".loading_indicator").show()
	$.ajax
    url: "/"
    type: "GET"
    dataType: "script"
    data:
      categorize: $(".post-sort").val()
    success: (data) ->
      $(".loading_indicator").hide()
      return

    error: (data) ->
      $(".loading_indicator").hide()
      return
 
$ ->
	$(".post-sort").on "change", ajaxReload



# $ ->
#   $(".post-sort").on "change", ->
#     $("#loading_indicator").show()
#     $.ajax
#       url: "/"
#       type: "GET"
#       dataType: "script"
#       data:
#         categorize: $(".post-sort").val()
# 	    success: (data) ->
# 	      $("#loading_indicator").hide()
# 	      return
# 
# 	    error: (data) ->
# 	      $("#loading_indicator").hide()
# 	      return
# 	

$ ->
	$("form.contact-me-submit").submit ->
	  $('input[type=submit].contact-me-submit').attr('disabled', 'disabled')
	
	
jQuery ($) ->
  
  #    var debug = $("#debug");

  flipText = (newText) ->
    (if flipUp is true then ($("#new-text").text(newText)
    $("#old-text").hide("drop",
      direction: "down"
    , 300)
    $("#new-text").show("drop",
      direction: "up"
    , 300)
    ) else ($("#old-text").text(newText)
    $("#old-text").show("drop",
      direction: "up"
    , 300)
    $("#new-text").hide("drop",
      direction: "down"
    , 300)
    ))
    flipUp = not flipUp # Alternating flipping direction
  window.ingredients = ["Sell","Lend", "Give", "Get"]
  interval = 2e3 # 2 seconds
  flipUp = true
  index = 0
  maxIndex = window.ingredients.length - 1
  setInterval (->
    nextText = window.ingredients[index]
    
    #        debug.append("<p>"+window.ingredients[index]+"</p>");
    flipText nextText
    index = (if (index is maxIndex) then 0 else index + 1)
  ), interval


# jQuery ->
#   Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
#   transaction.setupForm()
# 
# transaction =
#   setupForm: ->
#     $('#new_transaction').submit ->
#       $('input[type=submit]').attr('disabled', true)
#       if $('input#credit_card_number').length
#         transaction.processCard()
#         false
#       else
#         true
#   
#   processCard: ->
#     card =
#       number: $('#card_number').val()
#       cvc: $('#card_code').val()
#       exp_month: $('#card_month').val()
#       exp_year: $('#card_year').val()
# 			# exp_month: $('#card_month').options[this.selectedIndex].value()
# 			# exp_year: $('#card_year').options[this.selectedIndex].value()
#     Stripe.createToken(card, transaction.handleStripeResponse)
#   
#   handleStripeResponse: (status, response) ->
#     if status == 200
#       $('#transaction_stripe_card_token').val(response.id)
#       $('#new_transaction')[0].submit()
#     else
#       $('#stripe_error').text(response.error.message)
#       $('input[type=submit]').attr('disabled', false)
# 
# $ ()->
#   $("form.new_user").on "ajax:success", (event, data, status, xhr) ->
#     $("form.new_user")[0].reset()
#     $('#sign_up_modal').modal('hide')
#     $('#error_explanation').hide()
# 
#   $("form.new_user").on "ajax:error", (event, xhr, status, error) ->
#     errors = jQuery.parseJSON(xhr.responseText)
#     errorcount = errors.length
#     $('#error_explanation').empty()
#     if errorcount > 1
#       $('#error_explanation').append('<div class="alert alert-error">Il form contiene ' + errorcount + ' errori.</div>')
#     else
#       $('#error_explanation').append('<div class="alert alert-error">Il form contiene 1 errore.</div>')
#     $('#error_explanation').append('<ul>')
#     for e in errors
#       $('#error_explanation').append('<li>' + e + '</li>')
#     $('#error_explanation').append('</ul>')
#     $('#error_explanation').show()