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