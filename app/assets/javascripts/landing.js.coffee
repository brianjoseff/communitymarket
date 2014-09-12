$ ->
	$("body").scrollspy
	  target: ".navbar-example"
	  offset: 100

	# $window.on "load", ->
	#   $body.scrollspy "refresh"
	#   return

	$("#navbar-main [href=#]").click (e) ->
	  e.preventDefault()
	  return