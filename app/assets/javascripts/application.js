//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3


$.easing.def = "easeInOutCubic";
var fadeDuration = 750;


var sections = [];
var hExpanded;
var hCollapsed;

var expanding = false;
var scrolledToTop = null;
var scrolledToBottom = null;

function calculateHeights() {
    // Calculate collapsed height from CSS
    var $div = $('<div class="blind collapsed"></div>').hide().appendTo('body');
    hCollapsed = $div.css('height');
    $div.remove();

    // Calculate expanded height based on size of wrapper minus collapsed divs
    var hWrapper = parseInt($('.blinds-wrapper').css('height'));
    hExpanded = hWrapper - ((sections.length - 1) * parseInt(hCollapsed)) + 'px';
}

function redrawExpanded() {
    calculateHeights();
    $('.blind.expanded').height(hExpanded);
}

function resize(section, height, duration, expanded) {
    expanding = true;
    toggleBlindHeader(section, expanded);
    section.animate({scrollTop: 0}, {duration: fadeDuration, queue: false});
    section.animate({ height: height }, {
        duration: duration,
        complete: function() {
            toggleBlindClass(section, expanded);
            expanding = false;
        },
        queue: false
    });
}

function toggleBlindClass(section, expanded) {
    if (expanded) {
        section.addClass('expanded');
        section.removeClass('collapsed');
    }
    else {
        section.removeClass('expanded');
        section.addClass('collapsed');
    }
}

function toggleBlindHeader(section, expanded) {
    if (expanded) {
        section.find('.blind-banner h1').fadeOut(fadeDuration);
        section.find('.blind-banner span').fadeIn(fadeDuration);
        section.find('.blind-content').fadeIn(fadeDuration);
    }
    else {
        section.find('.blind-banner h1').fadeIn(fadeDuration);
        section.find('.blind-banner span').fadeOut(fadeDuration);
        section.find('.blind-content').fadeOut(fadeDuration);
    }
}

function expand(i) {
    for (var j = 0; j < sections.length; j++)
        if (j !== i) collapse(j);
    resize(sections[i], hExpanded, fadeDuration, true);
}

function collapse(i) {
    resize(sections[i], hCollapsed, fadeDuration, false);
}

function handleSectionScroll(e) {
    if (expanding) return;

    var section = $(e.currentTarget);

    var scrollTop = section.scrollTop();
    var scrollHeight = section[0].scrollHeight;
    var outerHeight = section.outerHeight();
    var direction = e.originalEvent.wheelDelta >= 0 ? 'up' : 'down';

    // scrolled to bottom of element
    if (scrollHeight - (scrollTop + 1) == outerHeight
        || scrollHeight - scrollTop == outerHeight) {
        // scrolling down
        if (scrolledToBottom && direction == 'down') {
            var sectionIndex = section.parent().find('section').index(e.currentTarget);
            sections[++sectionIndex].find('.blind-banner h1').click();
            scrolledToBottom = false;
        } else {
            scrolledToBottom = true;
        }
    }
    // scrolled to top of div
    if (section.scrollTop() == 0) {
        // scrolling up
        if (scrolledToTop && direction == 'up') {
            var sectionIndex = section.parent().find('section').index(e.currentTarget);
            sections[--sectionIndex].find('.blind-banner h1').click();
            scrolledToTop = false;
        } else {
            scrolledToTop = true;
        }
    }
}


window.onload = function() {
    $(document).on('click', '.blind-banner h1', function() {
        var parent = $(this).closest('.blind');
        expand($('.blind').index(parent));
    });

    $('.blind').bind('mousewheel', function(e) {
        handleSectionScroll(e);
    });

    // Cache jQuery objects
    $.each($('.blind'), function(i, s) {
        sections.push($(s));
    });

    calculateHeights();

    // Initial animation
    setTimeout(function() {
        sections[0].find('.blind-banner h1').click();
    }, fadeDuration * 2);

    // Fade out loading overlay
    $('#js-loading-overlay').fadeOut(fadeDuration)

}

window.onresize = function(event) {
    redrawExpanded();
}
