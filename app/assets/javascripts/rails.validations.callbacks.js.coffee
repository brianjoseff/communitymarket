# # clientSideValidations.validators.local["email_format"] = function(element, options) {
# #   if (!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
# #     return options.message;
# #   }
# # }
# 
# ClientSideValidations.callbacks.element.pass = (element, callback) ->
# 	# element.closest('.row').addClass('success')
# 	element.parent().removeClass('field-with-errors')
# 	element.parent().find('.message').html('<label>Get some</label>').addClass('success-label');
# 	element.parent().closest('.control-group').addClass('success')
# 	