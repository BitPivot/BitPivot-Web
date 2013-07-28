//
//= require head.core.0.99.min
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3
//= require blinds

window.onload = function() {
    $('body').removeClass('transition-preload');
    new Blinds({
        fadeDuration: 750,
        fnFadeIn: function(blinds) {
            $('#js-loading-overlay').fadeOut(blinds.fadeDuration)
        },
        fnScroll: function(blinds) {

        },
        fnHeaderClick: function(blinds) {

        },
        fnResize: function(hExpanded, hCollapsed) {

        }
    });
}
