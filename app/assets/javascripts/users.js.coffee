# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$("form.form").submit ->
	  $('input[type=submit]').attr('disabled', 'disabled')

$(document).ready ->
  $("#user_email").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "email is required."

  $("#user_password").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "password is required."


jQuery ->
	$("#email_settings_link").click ->
		$("#email_settings").prop "disabled", not $("#email_settings").prop("disabled")
		$("div.email-settings-cloak").toggle()
#sign up modal
# $ ->
# 	$("#new_user_button").click ->
# 	  valuesToSubmit = $("#new_user").serialize()
# 	  $("#signup_modal").modal "hide"
# 	  $.ajax(
# 	    url: "/users"
# 	    data: valuesToSubmit
# 	    type: "POST"
# 	  ).success (data, status) ->
# 			#update the DOM?
# 			
# 		false
jQuery ->
	$(".sign-in-link").click ->
		$(".sign-up").toggle()
		$(".sign-in").toggle()
		$(".sign-in-link").toggle()
		$(".sign-up-link").show()
jQuery ->
	$(".sign-up-link").click ->
		$(".sign-up").toggle()
		$(".sign-in").toggle()
		$(".sign-in-link").toggle()
		$(".sign-up-link").hide()
$ ->
	$("#name_field").tooltip
		trigger: "hover"
		placement: "left"
		title: "OPTIONAL...your name is only visible to the other members of any private group you are in or if you invite someone to a group via our 'invitation form'"

$ ->
	$(".destroy_region").tooltip
		trigger: "hover"
		placement: "top"
		title: "Permanently destroys post. Deactivate is recommeneded"
$ ->
	$(".deactivate_region").tooltip
		trigger: "hover"
		placement: "top"
		title: "Recommended option. Makes your post invisible to everyone except you. Makes it easier for the item to be re-added to the market"
