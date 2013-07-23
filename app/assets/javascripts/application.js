//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3

$.easing.def = "easeInOutCubic";

var sections = [];
var hNormal = '33.33%';
var hExpanded = '80%';
var hCollapsed = '10%';
var fadeDuration = 750;

function resize(el, height, duration) {
    el.animate({height: height}, duration);
}

function overlay(section, bool) {
    var o = section.find('.overlay');
    if (bool) {
        o.fadeIn(fadeDuration);
        return;
    }
    o.fadeOut(fadeDuration);

}

function expand(i) {
    for (var ix = 0; ix < sections.length; ix++) {
        if (ix !== i) collapse(ix);
    }
    var s = sections[i];

    overlay(s, false);
    resize(s, hExpanded, fadeDuration);
    s.addClass('expanded');
}

function collapse(i) {
    console.log(sections);
    var s = sections[i];
    overlay(s, true);
    resize(s, hCollapsed, fadeDuration);
    s.addClass('collapsed');
    s.removeClass('normal expanded');
}

window.onload = function() {
    $.each($('section'), function (i, s) {
        sections.push($(s));
    });

    // Initial animation
    setTimeout(function () {
        sections[0].click();
    }, fadeDuration * 2);

    // Fade out loading overlay
    $('#js-loading-overlay').fadeOut(fadeDuration)
}

$(document).on('click', '.splash', function () {
    expand($(this).parent().find('.splash').index($(this)));
});
