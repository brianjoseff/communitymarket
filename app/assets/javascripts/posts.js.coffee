# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("#post_tag_tokens").tokenInput "/tags.json",
    queryParam: "t"
    theme: "facebook"
    prePopulate: $("#post_tag_tokens").data("load")
  $("ul.token-input-list-facebook").addClass("input-block-level")
  $("ul.token-input-list-facebook").addClass("inline")
  $("ul.token-input-list-facebook").addClass("negative-padding")
$(document).ready ->
	$("input.cash-box").change ->
		$('input.cash-box').append "<p>$</p>"
		$('div#tier_explanation_wrapper').toggle "slide",
			direction: "top"
		, 800
		$('.cash-field-cloak').toggle "slide", 1
			direction: "right"
		



$(document).ready ->
  $(".group-box").change ->
    $("div#post-credit-fields").toggle "slide",
      direction: "right"
    , 100
    false

