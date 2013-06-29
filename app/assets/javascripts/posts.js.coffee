# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

countChecked = ->
  n = $("input:checked").length
	if n > 2
	  # $("div").text n + ((if n is 1 then " is" else " are")) + " checked!"
		# make div tht pops up the credit modal
		$("#dialog-form").dialog "open"
	else
		#make modal disappear
		$("#dialog-form").dialog "close"

countChecked()
$("input[type=checkbox].checkbox").on "click", countChecked

jQuery ->
  $("#post_tag_tokens").tokenInput "/tags.json",
    queryParam: "t"
    theme: "facebook"
    prePopulate: $("#post_tag_tokens").data("load")
  $("ul.token-input-list-facebook").addClass("input-block-level")
  $("ul.token-input-list-facebook").addClass("inline")
  $("ul.token-input-list-facebook").addClass("negative-padding")

$(document).ready ->
	$("#post_tier_id}").change ->
		$("input.cash-box").prop "disabled", not $("input.cash-box").prop("disabled")
	$("input.cash-box").change ->
		$("#post_tier_id").prop "disabled", not $("#post_tier_id").prop("disabled")
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

