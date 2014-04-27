// !function ($) {
//  //=================================== scroll  ===================================//
// 
// $body.scrollspy({
//       target: '#navbar-main',
//       offset: navHeight
//     })
// 
//     $window.on('load', function () {
//       $body.scrollspy('refresh')
//     })
// 
//     $('#navbar-main [href=#]').click(function (e) {
//       e.preventDefault()
//     })
// });

// offsetHeight = 51
// $(".nav-collapse").scrollspy offset: offsetHeight
// $(".navbar li a").click (event) ->
//   scrollPos = $("body > .container").find($(this).attr("href")).offset().top - offsetHeight
//   $("body,html").animate
//     scrollTop: scrollPos
//   , 500, ->
//     $(".btn-navbar").click()
//     return
// 
//   false
//   
