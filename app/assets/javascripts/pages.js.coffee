# # $(document).ready ->
# #
# #   # Style the buttons
# #   $("button, input:submit, input:button, a#jql, input:radio").button()
# #
# #   # Hook up form validation
# #   #$('#emailPost2').validate();
# #
# #   # Make the form a modal dialog and create a button
# #   $("#postModal").dialog
# #
# #     modal: true
# #     autoOpen: false
# #     title: "Enter your information"
# #     buttons:
# #       Post: ->
# #         $("#submit-post").submit()
# #         $(this).dialog "close"
# #
# #
# #   # Show the modal form when clicked.
# #   $("#create-post").click ->
# #     $("#postModal").dialog "open"
# 
# 
# 
# #the rotating text doodad
# $(document).ready ->
# 
#   #    var debug = $("#debug");
#   flipText = (newText) ->
#     (if flipUp is true then ($("#new-text").text(newText)
#     $("#old-text").hide("drop",
#       direction: "down"
#     , 300)
#     $("#new-text").show("drop",
#       direction: "up"
#     , 300)
#     ) else ($("#old-text").text(newText)
#     $("#old-text").show("drop",
#       direction: "up"
#     , 300)
#     $("#new-text").hide("drop",
#       direction: "down"
#     , 300)
#     ))
#     flipUp = not flipUp # Alternating flipping direction
#   window.ingredients = ["a couple spoons of sugar", "a dash of peppermint", "a shot of rum", "a couple raisins", "a cup of cocoa", "some white chocolate"]
#   interval = 2e3 # 2 seconds
#   flipUp = true
#   index = 0
#   maxIndex = window.ingredients.length - 1
#   setInterval (->
#     nextText = window.ingredients[index]
# 
#     #        debug.append("<p>"+window.ingredients[index]+"</p>");
#     flipText nextText
#     index = (if (index is maxIndex) then 0 else index + 1)
#   ), interval
