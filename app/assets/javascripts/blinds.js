

$.easing.def = "easeInOutCubic";

var Blinds = function(options) {

    var sections = [];
    var hExpanded = 0;
    var hCollapsed = 0;
    var expanding = false;
    var scrolledToTop = null;
    var scrolledToBottom = null;
    var fadeDuration = options.fadeDuration || 1000;

    var fnFadeIn = options.fnFadeIn || null;
    var fnScroll = options.fnScroll || null;
    var fnHeaderClick = options.fnHeaderClick || null;
    var fnResize = options.fnResize || null;

    this.initialize = function() {
        // Cache jQuery objects
        $.each($('.splash'), function(i, s) { sections.push($(s)); });

        // Events
        $(document).on('click', '.splash-banner__header', function(e) { headerClickCallback(this, e); });
        $(document).on('mousewheel', '.splash', function(e) { mousewheelCallback(this, e); });
        $(window).on('resize', function(e) { resizeCallback(this, e); });

        // Calculate initial sizes
        $(window).trigger('resize');

        // Fade out loading overlay
        if (fnFadeIn) fnFadeIn(this);
        // Initial animation
        setTimeout(function() { sections[0].find('.splash-banner__header').click(); }, fadeDuration * 2);
    }

    function calculateHeights() {
        // Calculate collapsed height from CSS
        var $div = $('<div class="splash collapsed"></div>').hide().appendTo('body');
        hCollapsed = $div.css('height');
        $div.remove();
        // Calculate expanded height based on size of wrapper minus collapsed divs
        hExpanded = parseInt($('.splash-wrapper').css('height')) - ((sections.length - 1) * parseInt(hCollapsed)) + 'px';
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
        if (expanded) section.addClass('expanded').removeClass('collapsed');
        else section.removeClass('expanded').addClass('collapsed');

        toggleSplashHeader();
    };

    function toggleSplashHeader(section, expanded) {
        if (expanded) {
            fade('out', section, ['.splash-banner img']);
            fade('in', section, ['.splash-banner__text', '.splash-content']);
        }
        else {
            fade('in', section, ['.splash-banner img']);
            fade('out', section, ['.splash-banner__text', '.splash-content']);
        }
    };

    function expand(i) {
        for (var j = 0; j < sections.length; j++) if (j !== i) collapse(j);
        resize(sections[i], hExpanded, fadeDuration, true);
    };

    function collapse(i) {
        resize(sections[i], hCollapsed, fadeDuration, false);
    };

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
            if (!scrolledToBottom && direction !== 'down') {
                scrolledToBottom = true;
                return;
            }
            var sectionIndex = section.parent().find('section').index(e.currentTarget);
            sections[++sectionIndex].find('.splash-banner__header').click();
            scrolledToBottom = false;
        }
        // scrolled to top of div
        if (section.scrollTop() == 0) {
            // scrolling up
            if (!scrolledToTop && direction !== 'up') {
                scrolledToTop = true;
                return;
            }
            var sectionIndex = section.parent().find('section').index(e.currentTarget);
            sections[--sectionIndex].find('.splash-banner__header').click();
            scrolledToTop = false;
        }
    };

    // Fade an array of elements by class
    function fade(direction, section, elements, duration) {
        $.each(elements, function(i, e) {
            if (direction === 'in') {
                section.find(e).fadeIn(duration || fadeDuration);
            } else if (direction === 'out') {
                section.find(e).fadeOut(duration || fadeDuration);
            }
        });
    }


    function mousewheelCallback(sender, e) {
        handleSectionScroll(e);
        if (fnScroll) fnScroll(this); // Custom callback
    }

    function headerClickCallback(sender, e) {
        expand($('.splash').index($(sender).closest('.splash')));
        if (fnHeaderClick) fnHeaderClick(this); // Custom callback
    }

    function resizeCallback(sender, e) {
        calculateHeights();
        if (fnResize) fnResize(this); // Custom callback
    }


    this.initialize();
}
