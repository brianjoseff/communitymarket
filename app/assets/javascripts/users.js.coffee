# I removed all the '$ ->' and 'jQuery ->'.  $ -> compiles to $(document).ready and only one is needed.

$(document).ready ->

  $("form.form").submit ->
        $('input[type=submit]').attr('disabled', 'disabled')

  # Auto phone formatting on '/users/sign_up'
  $("#phone").mask('(000) 000-0000')


  $("#user_email").validate ->
    expression: "if(VAL != '') return true; else return false;"
    message: "email is required."

  # $("#user_password").validate
  #   expression: "if(VAL != '') return true; else return false;"
  #   message: "password is required."


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

	$(".sign-in-link").click ->
		$(".sign-up").toggle()
		$(".sign-in").toggle()
		$(".sign-in-link").toggle()
		$(".sign-up-link").show()

	$(".sign-up-link").click ->
		$(".sign-up").toggle()
		$(".sign-in").toggle()
		$(".sign-in-link").toggle()
		$(".sign-up-link").hide()

	$("#name_field").tooltip
		trigger: "hover"
		placement: "left"
		title: "OPTIONAL...your name is only visible to the other members of any private group you are in or if you invite someone to a group via our 'invitation form'"


	$(".destroy_region").tooltip
		trigger: "hover"
		placement: "top"
		title: "Permanently destroys post. Deactivate is recommeneded"

	$(".deactivate_region").tooltip
		trigger: "hover"
		placement: "top"
		title: "Recommended option. Makes your post invisible to everyone except you. Makes it easier for the item to be re-added to the market"


