//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3

// Set jquery default animation easing
$.easing.def = "easeOutQuad";

var sections = [];
var hExpanded = '90%';
var hCollapsed = '5%';
var fadeDuration = 2000;

function resize(element, height, duration) {
    element.animate({height: height}, duration);
}

function expand(i) {
    var section = sections[i];
    for (var j = 0; j < sections.length; j++) {
        if (j !== i) collapse(j);
    }
    resize(section, hExpanded, fadeDuration);
    $(section.find('.overlay')).fadeOut(fadeDuration);
    section.addClass('expanded');
}

function collapse(i) {
    var section = sections[i];
    resize(section, hCollapsed, fadeDuration);
    section.addClass('collapsed');
    $(section.find('.overlay')).fadeIn(fadeDuration);
    section.removeClass('normal expanded');
}

$(document).ready(function () {
    // cache jquery objects
    $.each($('section'), function (i, section) {
        sections.push($(section));
    });

    // Initial animation
    setTimeout(function () {
        sections[0].click();
    }, 1000);
});

$(document).on('click', '.splash', function () {
    expand($(this).parent().find('.splash').index($(this)));
});
