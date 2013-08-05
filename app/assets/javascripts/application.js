//
//= require head.core.0.99.min
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3
//= require partials/_blinds

var blinds = new App.Blinds({
    fnFadeIn: function(blinds) {
        $('#js-loading-overlay').fadeOut(blinds.fadeDuration)
    }
});

window.onload = function() {
    $('body').removeClass('transition-preload');
    blinds.initialize();
}
