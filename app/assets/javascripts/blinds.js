var Blinds = function(options) {

    var sections = [];
    var hExpanded = 0;
    var hCollapsed = 0;
    var expanding = false;
    var scrolledToTop = null;
    var scrolledToBottom = null;
    var fnFadeIn = options.fnFadeIn || null;
    var fnScroll = options.fnScroll || null;
    var fnResize = options.fnResize || null;
    var fadeDuration = options.fadeDuration || 1000;
    var fnHeaderClick = options.fnHeaderClick || null;

    var classBlind = options.classBlind || '.blind';
    var classBlindsWrapper = options.classBlindsWrapper || '.blinds-wrapper';
    var classBlindExpanded = options.classBlindExpanded || '.expanded';
    var classBlindCollapsed = options.classBlindCollapsed || '.collapsed';
    var classBlindBanner = options.classBlindBanner || '.blind-banner';
    var classBlindBannerHeader = '{0} {1}'.fmt(classBlindBanner, 'h1');
    var classBlindBannerText = '{0} {1}'.fmt(classBlindBanner, 'span');
    var classBlindContent = options.classBlindContent || '.blind-content';

    console.log(classBlindBannerHeader);

    var initialize = function() {
        // Cache jQuery objects
        $.each($(classBlind), function(i, s) { sections.push($(s)); });

        // Events
        $(document).on('click', classBlindBannerHeader, function(e) { headerClickCallback(this, e); });
        $(document).on('mousewheel', classBlind, function(e) { mousewheelCallback(this, e); });
        $(window).on('resize', function(e) { resizeCallback(this, e); });

        // Calculate initial sizes
        $(window).trigger('resize');

        // Fade out loading overlay
        if (fnFadeIn) fnFadeIn(this);
        // Initial animation
        setTimeout(function() { sections[0].find(classBlindBannerHeader).click(); }, fadeDuration * 2);
    };

    function calculateHeights() {
        // Calculate collapsed height from CSS
        var $div = $('<div class="{0} {1}"></div>'.fmt(classBlind, classBlindCollapsed).replace(/\./g, '')).hide().appendTo('body');
        hCollapsed = $div.css('height');
        $div.remove();
        // Calculate expanded height based on size of wrapper minus collapsed divs
        hExpanded = parseInt($(classBlindsWrapper).css('height')) - ((sections.length - 1) * parseInt(hCollapsed)) + 'px';
    };


    function resize(section, height, duration, expanded) {
        expanding = true;
        toggleSplashHeader(section, expanded);
        section.animate({scrollTop: 0}, {duration: fadeDuration, queue: false});
        section.animate({ height: height }, {
            duration: duration,
            complete: function() {
                toggleSplashClass(section, expanded);
                expanding = false;
            },
            queue: false
        });
    };

    function toggleSplashClass(section, expanded) {
        if (expanded) {
            section.addClass(classBlindExpanded.removeAll('\\.'));
            section.removeClass(classBlindCollapsed.removeAll('\\.'));
            fade('in', section, [classBlindBannerText, classBlindContent]);
        }
        else {
            section.removeClass(classBlindExpanded.removeAll('\\.'));
            section.addClass(classBlindCollapsed.removeAll('\\.'));
            fade('out', section, [classBlindBannerText, classBlindContent]);
        }
    };

    function toggleSplashHeader(section, expanded) {
        if (expanded) fade('out', section, [classBlindBannerHeader + ' img']);
        else fade('in', section, [classBlindBannerHeader + ' img']);
    };

    function expand(i) {
        for (var j = 0; j < sections.length; j++) if (j !== i) collapse(j);
        resize(sections[i], hExpanded, fadeDuration, true);
    };

    function collapse(i) {
        resize(sections[i], hCollapsed, fadeDuration, false);
    };

    // Fade an array of elements by their class names
    function fade(direction, section, elements, duration) {
        $.each(elements, function(i, e) {
            if (direction === 'in') {
                section.find(e).fadeIn(duration || fadeDuration);
            } else if (direction === 'out') {
                section.find(e).fadeOut(duration || fadeDuration);
            }
        });
    };


    /*
     * Event callbacks
     */

    function mousewheelCallback(sender, e) {
        if (expanding) return;

        var section = $(e.currentTarget);
        var scrollTop = section.scrollTop();
        var scrollHeight = section[0].scrollHeight;
        var outerHeight = section.outerHeight();
        var direction = e.originalEvent.wheelDelta >= 0 ? 'up' : 'down';

        // scrolled to bottom of element
        if (scrollHeight - (scrollTop + 1) == outerHeight || scrollHeight - scrollTop == outerHeight) {
            // scrolling down
            if (scrolledToBottom && direction === 'down') {
                var sectionIndex = section.parent().find(classBlind).index(e.currentTarget);
                sections[++sectionIndex].find(classBlindBannerHeader).click();
                scrolledToBottom = false;
            } else {
                scrolledToBottom = true;
            }
        }
        // scrolled to top of div
        if (section.scrollTop() == 0) {
            // scrolling up
            if (scrolledToTop && direction === 'up') {
                var sectionIndex = section.parent().find(classBlind).index(e.currentTarget);
                sections[--sectionIndex].find(classBlindBannerHeader).click();
                scrolledToTop = false;
            } else {
                scrolledToTop = true;
            }
        }
        if (fnScroll) fnScroll(this); // Custom callback
    };

    function resizeCallback(sender, e) {
        calculateHeights();
        if (fnResize) fnResize(hExpanded, hCollapsed); // Custom callback
    };

    function headerClickCallback(sender, e) {
        expand($(classBlind).index($(sender).closest(classBlind)));
        if (fnHeaderClick) fnHeaderClick(this); // Custom callback
    };


    // Go!
    initialize();
};

/*
 * Extensions
 */

// Set Jquery default easing
$.easing.def = "easeInOutCubic";

// For .NET-like string format
String.prototype.fmt = function() {
    var s = this;
    for (var i = 0; i < arguments.length; i++)
        s = s.replace('{' + i + '}', arguments[i]);
    return s;
};

String.prototype.removeAll = function(toRemove) {
    return this.replace(new RegExp(toRemove, 'g'), '');
};