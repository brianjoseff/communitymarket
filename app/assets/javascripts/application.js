// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require_self
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.tokeninput
//= require pages.js.coffee
//= require bootstrap
//= require groups.js.coffee
//= require posts.js.coffee
//= require transactions.js.coffee
//= require jquery.validate.js
//= require rails.validations.callbacks.js.coffee
//= require jquery.modal
//= require_tree .



function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".image-control-group").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}
// document.ready(function() {
//   var flipText, flipUp, index, interval, maxIndex;
//   flipText = function(newText) {
//     var flipUp;
//     if (flipUp === true) {
//       $("#new-text").text(newText);
//       $("#old-text").hide("drop", {
//         direction: "down"
//       }, 300);
//       $("#new-text").show("drop", {
//         direction: "up"
//       }, 300);
//     } else {
//       $("#old-text").text(newText);
//       $("#old-text").show("drop", {
//         direction: "up"
//       }, 300);
//       $("#new-text").hide("drop", {
//         direction: "down"
//       }, 300);
//     }
//     return flipUp = !flipUp;
//   };
//   window.ingredients = ["Lend", "Give", "Get"];
//   interval = 2e3;
//   flipUp = true;
//   index = 0;
//   maxIndex = window.ingredients.length - 1;
//   return setInterval((function() {
//     var nextText;
//     nextText = window.ingredients[index];
//     flipText(nextText);
//     return index = (index === maxIndex ? 0 : index + 1);
//   }), interval);
// });
