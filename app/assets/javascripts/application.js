//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3



$.easing.def = "easeInOutCubic";
var hExpanded = '80%';
var fadeDuration = 750;



var sections = [];
var hCollapsed;

function setCollapsedHeaderHeights() {
    var wrapperHeight = parseInt($('.splash-wrapper').height());
    var collapsedHeight = (parseInt(hCollapsed) / 100) * wrapperHeight + 'px';
    $('.splash-banner__header').height(collapsedHeight);
}

function resize(element, height, duration) {
    element.animate({height: height}, duration);
}

function toggleSectionContent(section, expanded) {
    if (expanded) {
        section.addClass('expanded');
        section.find('.splash-banner__header').fadeOut(fadeDuration)
        section.find('.splash-banner__text').fadeIn(fadeDuration)
        section.find('.splash-content').fadeIn(fadeDuration)
    }
    else {
        section.removeClass('expanded')
        section.find('.splash-banner__header').fadeIn(fadeDuration)
        section.find('.splash-banner__text').fadeOut(fadeDuration)
        section.find('.splash-content').fadeOut(fadeDuration)
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

    // Calculate hCollapsed base on hExpanded
    hCollapsed = (100 - parseInt(hExpanded)) / (sections.length - 1) + '%'
    setCollapsedHeaderHeights();

    // Initial animation
    setTimeout(function () {
        sections[0].find('.splash-banner__header').click();
    }, fadeDuration * 2);

    // Fade out loading overlay
    $('#js-loading-overlay').fadeOut(fadeDuration)
}

window.onresize = function(event) {
    setCollapsedHeaderHeights();
}