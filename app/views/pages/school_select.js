// $("#school_image").html("<%= escape_javascript(image_tag(@school.image.url(:thumb), :alt => @school.name)) %>");
//change place holder text and background image too!
//also append it to People and Stuff logo?
if($("#school_select").val() == 1){
	$("#user_name").attr("placeholder", "Eleazar Wheelock");
	$("#user_email").attr("placeholder", "elly@dartmouth.edu");
	$('#headerwrap').css("background-image", 'url("assets/dartmouth-panorama2.jpg")');
}else{
	$("#user_name").attr("placeholder", "Puddles Duck");
	$("#user_email").attr("placeholder", "theduck@uoregon.edu");
	$('#headerwrap').css("background-image", 'url("assets/oregon-panorama2.jpg")');
}

