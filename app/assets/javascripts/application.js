//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3
//= require blinds

window.onload = function() {
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
            $('.blind.expanded').height(hExpanded);
        }
    });
}
