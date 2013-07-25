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

function resize(section, height, duration, expanded) {
    section.animate({ height: height }, {
        duration: duration,
        complete: function() {
            toggleSectionContent(section, expanded);
            expanding = false;
        }
    });
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
            sections[++sectionIndex].find('.splash-banner__header').click();
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
            sections[--sectionIndex].find('.splash-banner__header').click();
            scrolledToTop = false;
        } else {
            scrolledToTop = true;
        }
    }
}


window.onload = function() {
    $(document).on('click', '.splash-banner__header', function() {
        var parent = $(this).closest('.splash');
        expand($('.splash').index(parent));
    });

    $('.splash').bind('mousewheel', function(e) {
        handleSectionScroll(e);
    });

    // Cache jQuery objects
    $.each($('.splash'), function(i, s) {
        sections.push($(s));
    });

    calculateHeights();

    // Initial animation
    setTimeout(function() {
        sections[0].find('.splash-banner__header').click();
    }, fadeDuration * 2);

    // Fade out loading overlay
    $('#js-loading-overlay').fadeOut(fadeDuration)

}

window.onresize = function(event) {
    redrawExpanded();
}
