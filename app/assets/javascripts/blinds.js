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

    var initialize = function() {
        // Cache jQuery objects
        $.each($('.blind'), function(i, s) { sections.push($(s)); });

        // Events
        $(document).on('click', '.blind-banner h1', function(e) { headerClickCallback(this, e); });
        $(document).on('mousewheel', '.blind', function(e) { mousewheelCallback(this, e); });
        $(window).on('resize', function(e) { resizeCallback(this, e); });

        // Calculate initial sizes
        $(window).trigger('resize');

        // Fade out loading overlay
        if (fnFadeIn) fnFadeIn(this);
        // Initial animation
        setTimeout(function() { sections[0].find('.blind-banner h1').click(); }, fadeDuration * 2);
    };

    function calculateHeights() {
        // Calculate collapsed height from CSS
        var $div = $('<div class="blind collapsed"></div>').hide().appendTo('body');
        hCollapsed = $div.css('height');
        $div.remove();
        // Calculate expanded height based on size of wrapper minus collapsed divs
        hExpanded = parseInt($('.blinds-wrapper').css('height')) - ((sections.length - 1) * parseInt(hCollapsed)) + 'px';
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
            section.addClass('expanded');
            section.removeClass('collapsed');
            section.find('.blind-content').fadeIn(fadeDuration);
        }
        else {
            section.removeClass('expanded');
            section.addClass('collapsed');
            section.find('.blind-content').fadeOut(fadeDuration);
        }
    };

    function toggleSplashHeader(section, expanded) {
        if (expanded) {
            section.find('.blind-banner h1').fadeOut(fadeDuration);
            section.find('.blind-banner span').fadeIn(fadeDuration);
        }
        else {
            section.find('.blind-banner h1').fadeIn(fadeDuration);
            section.find('.blind-banner span').fadeOut(fadeDuration);
        }
    };

    function expand(i) {
        for (var j = 0; j < sections.length; j++) if (j !== i) collapse(j);
        resize(sections[i], hExpanded, fadeDuration, true);
    };

    function collapse(i) {
        resize(sections[i], hCollapsed, fadeDuration, false);
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
                var sectionIndex = section.parent().find('.blind').index(e.currentTarget);
                sections[++sectionIndex].find('.blind-banner h1').click();
                scrolledToBottom = false;
            } else {
                scrolledToBottom = true;
            }
        }
        // scrolled to top of div
        if (section.scrollTop() == 0) {
            // scrolling up
            if (scrolledToTop && direction === 'up') {
                var sectionIndex = section.parent().find('.blind').index(e.currentTarget);
                sections[--sectionIndex].find('.blind-banner h1').click();
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
        expand($('.blind').index($(sender).closest('.blind')));
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