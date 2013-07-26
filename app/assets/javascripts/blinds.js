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
    var headerIndex = function($header) { return $('.blind').index($header.closest('.blind')); };

    var initialize = function() {
        // Cache jQuery objects
        $.each($('.blind'), function(i, s) { sections.push($(s)); });

        // Events
        $(document).on('click', '.blind header', function(e) { headerClickCallback(this, e); });
        $(document).on('mousewheel', '.blind', function(e) { mousewheelCallback(this, e); });
        $(window).on('resize', function(e) { resizeCallback(this, e); });
        $(window).on('orientationchange', function(e) { resizeCallback(this, e); });

        // Calculate initial sizes
        $(window).trigger('resize');

        // Fade out loading overlay
        if (fnFadeIn) fnFadeIn(this);
        // Initial animation
        setTimeout(function() { sections[0].find('header').click(); }, fadeDuration * 2);
    };

    function resize(section, height, duration, expanded) {
        expanding = true;
        toggleBlind(section, expanded);
        section.animate({scrollTop: 0}, {duration: fadeDuration, queue: false});
        section.animate({ height: height }, {
            duration: duration,
            complete: function() {
                expanding = false;
            },
            queue: false
        });
    };

    function toggleBlind(section, expanded) {
        if (expanded) {
            section.addClass('expanded');
            section.find('.blind-content').fadeIn(fadeDuration);
        }
        else {
            section.removeClass('expanded');
            section.find('.blind-content').fadeOut(fadeDuration);
        }
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
        var i = section.parent().find('.blind').index(e.currentTarget);

        // scrolled to bottom of element
        if (scrollHeight - (scrollTop + 1) === outerHeight || scrollHeight - scrollTop === outerHeight) {
            // scrolling down
            if (scrolledToBottom && direction === 'down') {
                // not viewing bottom section
                if (i !== sections.length - 1)
                // open section below
                    sections[++i].find('.blind header').click();
                scrolledToBottom = false;
            } else {
                scrolledToBottom = true;
            }
        }
        // scrolled to top of div
        if (section.scrollTop() === 0) {
            // scrolling up
            if (scrolledToTop && direction === 'up') {
                // not viewing top section
                if (i !== 0)
                // open section above
                    sections[--i].find('.blind header').click();
                scrolledToTop = false;
            } else {
                scrolledToTop = true;
            }
        }
        if (fnScroll) fnScroll(this); // Custom callback
    };

    function resizeCallback(sender, e) {
        // Calculate collapsed height from CSS
        var $div = $('<div class="blind collapsed"></div>').hide().appendTo('body');
        hCollapsed = $div.css('height');
        $div.remove();

        // Calculate expanded height based on size of wrapper minus collapsed divs
        hExpanded = parseInt($('.blinds-wrapper').css('height')) - ((sections.length - 1) * parseInt(hCollapsed)) + 'px';

        if (fnResize) fnResize(hExpanded, hCollapsed); // Custom callback
    };

    function headerClickCallback(sender, e) {
        var index = headerIndex($(sender));

        for (var i = 0; i < sections.length; i++) {
            var expanded = i === index;
            var height = expanded ? hExpanded : hCollapsed
            resize(sections[i], height, fadeDuration, expanded);
        }

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
