

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