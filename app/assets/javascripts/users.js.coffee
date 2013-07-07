# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("#user_email").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "email is required."

  $("#user_password").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "password is required."

#sign up modal
$ ->
	$("#new_user_button").click ->
	  valuesToSubmit = $("#new_user").serialize()
	  $("#signup_modal").modal "hide"
	  $.ajax(
	    url: "/users/update_dom"
	    data: valuesToSubmit
	    type: "POST"
	  ).success (data, status) ->
			#update the DOM?
			

	# $('#nav')
	#    .on 'ajax:beforeSend', 'a.modal-open', (event, xhr, settings) ->
	#      true
	#    .on 'ajax:success', 'a.modal-open', (event, data, status, xhr) ->
	#      modal = $($(this).attr('data-target'))
	#      modal.html(data)
	#      # $.modal.enableChosen()
	#    .on 'ajax:error', '.a.modal-open', (event, xhr, status, error) ->
	#      modal = $($(this).attr('data-target'))
	#      $.modal.showErrorModal(status, error, modal)
	#    .on 'ajax:complete', '.a.modal-open', (event, xhr, status) ->
	#      true
	# 
	#  $('#signup_modal')
	#    .on 'ajax:success', '.simple_form', (event, data, status, xhr) ->
	#      modal = $(this)
	#      #$.modal.appendFeedback(modal, data)
	#      # if modal.find('.feedback .alert-error').size() > 0
	#      #   $.modal.replaceFeedback(modal)
	#      #   return true
	#      nav_id = '#nav'
	#      #modal.find('.feedback').remove().end().
	#      $.modal('hide')
	# 		 
	#    .on 'ajax:error', '.simple_form', (event, xhr, status, error) ->
	#      modal = $('#signup_modal')
	#      $.modal.showErrorModal(status, error, modal)
