$ ->	
  $("#contact_email").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "email is required."

$ ->	
  $("#contact_body").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "body is required."

$ ->
	$("#contact_body").validate 
		expression: "if(/<>*/.test(VAL) == true) return false; else return true;"
		message: "No html tags. Please, do not spam me."


$ ->
	$("#contact_email").validate
		expression: "if(/@/.test(VAL) == true) return true; else return false;"
		message: "Email format yo. check it: blah@blah.com"
		
