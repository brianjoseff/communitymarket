# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


# $ ->
# 	$("form.form").submit ->
# 	  $('input[type=submit]').attr('disabled', 'disabled')

## ENABLE THE PASSWORD FIELD ON PRIVATE BOX Check
jQuery ->
	$("input#private").change ->
		$("#private_group").prop "disabled", not $("#private_group").prop("disabled") && $("input#private").val('')
		
$ ->	
  $("#group_name").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "group name is required."
$ ->	
  $("#join_private_group").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "password is required."






jQuery ->
	$(".show-members-link").click ->
		$(".hide-link").toggle()
		$(".private-user-list").toggle()
		$(".show-members-link").toggle()
jQuery ->
	$(".hide-link").click ->
		$(".private-user-list").toggle()
		$(".hide-link").toggle()
		$(".show-members-link").toggle()