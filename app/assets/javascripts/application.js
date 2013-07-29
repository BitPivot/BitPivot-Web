//
//= require head.core.0.99.min
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3
//= require partials/_blinds
//= require partials/_blog

window.onload = function() {
    if (disableJavascript) return;

    $('body').removeClass('transition-preload');
    var blinds = new App.Blinds({
        fnFadeIn: function(blinds) {
            $('#js-loading-overlay').fadeOut(blinds.fadeDuration)
        }
    });

    blinds.initialize();
}
