# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#post_tag_tokens").tokenInput "/tags.json",
    queryParam: "t"
    theme: "facebook"
    prePopulate: $("#post_tag_tokens").data("load")

$(document).ready ->
	$("input.cash-box").change ->
		$('input.cash-box').append "<p>$</p>"
		$('div#tier_explanation_wrapper').toggle "slide",
			direction: "top"
		, 800
		$('.cash-field').toggle "slide",
			direction: "right"
		



$(document).ready ->
  $(".group-box").change ->
    $("div#modalCredit").toggle "slide",
      direction: "right"
    , 100
    false

