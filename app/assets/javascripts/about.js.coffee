$ ->	
  $("#contact_email").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "email is required."
$ ->
	$("#contact_email").validate
		expression: "if(VAL.test(/@/) return true; else return false;"
		message: "Email format yo. check it: blah@blah.com"