//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3
//= require blinds

window.onload = function() {
    new Blinds({
        fadeDuration: 750,
        classBlind: '.splash',
        classBlindWrapper: '.splash-wrapper',
        classBlindBanner: '.splash-banner',
        classBlindBannerHeader: '.splash-banner__header',
        classBlindBannerText: '.splash-banner__text',
        classBlindContent:'.splash-content',
        fnFadeIn: function(blinds) {
            $('#js-loading-overlay').fadeOut(blinds.fadeDuration)
        },
        fnScroll: function(blinds) {

        },
        fnHeaderClick: function(blinds) {

        },
        fnResize: function(hExpanded, hCollapsed) {
            $('.splash.expanded').height(hExpanded);
        }
    });
}
