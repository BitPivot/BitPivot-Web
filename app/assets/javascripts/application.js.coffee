#
#= require jquery
#= require jquery_ujs
#= require jquery.easing.1.3
#= require blinds

window.onload = ->
  $('body').removeClass 'transition-preload'
  b = new App.Blinds
    fadeDuration: 750,
    fnFadeIn: (blinds) ->
      $('#js-loading-overlay').fadeOut blinds.fadeDuration
  b.initialize()
