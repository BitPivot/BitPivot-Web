//
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3


$.easing.def = "easeInOutCubic";
var hExpanded = '80%';
var fadeDuration = 750;


var sections = [];
var hCollapsed;

var scrolledToTop = false;
var scrolledToBottom = false;
var expanding = false;

function setCollapsedHeaderHeights() {
    var wrapperHeight = parseInt($('.splash-wrapper').height());
    var collapsedHeight = (parseInt(hCollapsed) / 100) * wrapperHeight + 'px';
    $('.splash-banner__header').height(collapsedHeight);
}

function resize(section, height, duration, expanded) {
    expanding = true;

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
        section.find('.splash-banner__header').fadeOut(fadeDuration);
        section.find('.splash-banner__text').fadeIn(fadeDuration);
        section.find('.splash-content').fadeIn(fadeDuration);
    }
    else {
        section.removeClass('expanded')
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

    // Calculate hCollapsed base on hExpanded
    hCollapsed = (100 - parseInt(hExpanded)) / (sections.length - 1) + '%'
    setCollapsedHeaderHeights();

    // Initial animation
    setTimeout(function() {
        sections[0].find('.splash-banner__header').click();
    }, fadeDuration * 2);

    // Fade out loading overlay
    $('#js-loading-overlay').fadeOut(fadeDuration)

}

window.onresize = function(event) {
    setCollapsedHeaderHeights();
}