//
//= require head.core.0.99.min
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3
//= require partials/_blinds
//= require partials/_blog

window.onload = function() {
    $('body').removeClass('transition-preload');
    var b = new App.Blinds({
        fadeDuration: 750,
        fnFadeIn: function(blinds) {
            $('#js-loading-overlay').fadeOut(blinds.fadeDuration)
        }
    });

    b.initialize();
}
