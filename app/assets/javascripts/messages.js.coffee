# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(".modal-message-form").on $.modal.OPEN, (event, modal) ->
  $("#send_message").click ->
	  $('input[type=submit]').attr('disabled', 'disabled')

# $(document).ready ->
# 	$("#send_message").click ->
# 	  $('input[type=submit]').attr('disabled', 'disabled')
# jQuery->
#   $("#send_message").click ->
# 	  $('input[type=submit]').attr('disabled', 'disabled')


	
  