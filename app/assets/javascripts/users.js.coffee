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

$ ->
	$(".destroy_region").tooltip
		trigger: "hover"
		placement: "top"
		title: "permanently destroys post. Deactivate is recommeneded"
$ ->
	$(".deactivate_region").tooltip
		trigger: "hover"
		placement: "top"
		title: "Recommended option. Makes your post invisible to everyone except you. Makes it easier for the item to be readded to the market"
