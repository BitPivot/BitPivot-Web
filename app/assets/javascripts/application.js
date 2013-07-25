//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3



$.easing.def = "easeInOutCubic";
var fadeDuration = 750;



var sections = [];
var hExpanded;
var hCollapsed;

function calculateHeights() {
    // Calculate collapsed height from CSS
    var $div = $('<div class="splash collapsed"></div>').hide().appendTo('body');
    hCollapsed = $div.css('height');
    $div.remove();

    // Calculate expanded height based on size of wrapper minus collapsed divs
    var hWrapper = parseInt($('.splash-wrapper').css('height'));
    hExpanded = hWrapper - ((sections.length - 1) * parseInt(hCollapsed)) + 'px';

    console.log('hCollapsed : ' + hCollapsed);
    console.log('hExpanded  : ' + hExpanded);
}

function redrawExpanded() {
    calculateHeights();
    $('.splash.expanded').height(hExpanded);
}

function resize(element, height, duration) {
    element.animate({height: height}, duration);
}

function toggleSectionContent(section, expanded) {
    if (expanded) {
        section.addClass('expanded');
        section.removeClass('collapsed');
        section.find('.splash-banner__header').fadeOut(fadeDuration);
        section.find('.splash-banner__text').fadeIn(fadeDuration);
        section.find('.splash-content').fadeIn(fadeDuration);
    }
    else {
        section.removeClass('expanded');
        section.addClass('collapsed');
        section.find('.splash-banner__header').fadeIn(fadeDuration);
        section.find('.splash-banner__text').fadeOut(fadeDuration);
        section.find('.splash-content').fadeOut(fadeDuration);
    }
}

function expand(i) {
    var section = sections[i];

    for (var j = 0; j < sections.length; j++) {
        if (j !== i) collapse(j);
    }

    resize(section, hExpanded, fadeDuration);
    toggleSectionContent(section, true);
}

function collapse(i) {
    var section = sections[i];
    resize(section, hCollapsed, fadeDuration);
    toggleSectionContent(section, false);
}

$(document).on('click', '.splash-banner__header', function () {
    var parent = $(this).closest('.splash');
    expand($('.splash').index(parent));
});



window.onload = function() {
    // Cache jQuery objects
    $.each($('.splash'), function (i, s) {
        sections.push($(s));
    });

    calculateHeights();

    // Initial animation
    setTimeout(function () {
        sections[0].find('.splash-banner__header').click();
    }, fadeDuration * 2);

    // Fade out loading overlay
    $('#js-loading-overlay').fadeOut(fadeDuration)
}

window.onresize = function(event) {
    redrawExpanded();
}