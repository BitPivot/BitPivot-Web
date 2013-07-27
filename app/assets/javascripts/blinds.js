var Blinds = function(options) {

    var blinds = [];
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
        $.each($('.blind'), function(i, s) { blinds.push($(s)); });

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
        setTimeout(function() { blinds[0].find('header').click(); }, fadeDuration * 2);
    };

    function resize($blind, height, duration, expanded) {
        expanding = true;
        toggleBlind($blind, expanded);
        $blind.animate({scrollTop: 0}, {duration: fadeDuration, queue: false});
        $blind.animate({ height: height }, {
            duration: duration,
            complete: function() {
                expanding = false;
            },
            queue: false
        });
    };

    function toggleBlind($blind, expanded) {
        if (expanded) {
            $blind.addClass('expanded');
            $blind.find('.blind-content-area').fadeIn(fadeDuration);
        }
        else {
            $blind.removeClass('expanded');
            $blind.find('.blind-content-area').fadeOut(fadeDuration);
        }
    };


    /*
     * Event callbacks
     */
    function mousewheelCallback(sender, e) {
        if (expanding) return;

        var $blind = $(e.currentTarget);
        var $content = $($blind.find('.blind-content-area'));
        var iBlind = $('.blind').index($blind);
        var scrollTop = $content.scrollTop();
        var scrollHeight = $blind.find('.blind-content-area')[0].scrollHeight
        var scrollbarPresent = $content.scrollHeight > $content.height();
        var outerHeight = $content.outerHeight();
        var direction = e.originalEvent.wheelDelta >= 0 ? 'up' : 'down';

        // scrolled to bottom of blind
        if (scrollHeight - (scrollTop + 1) === outerHeight || scrollHeight - scrollTop === outerHeight) {
            // scrolling down
            if (scrolledToBottom && direction === 'down') {
                // not viewing bottom blind
                if (iBlind !== blinds.length - 1 || !scrollbarPresent)
                    // open blind below
                    blinds[iBlind + 1].find('header').click();
                scrolledToBottom = false;
            } else {
                scrolledToBottom = true;
            }
        }
        // scrolled to top of blind
        if (scrollTop === 0) {
            // scrolling up
            if (scrolledToTop && direction === 'up') {
                // not viewing top blind
                if (iBlind !== 0 || !scrollbarPresent)
                    // open blind above
                    blinds[iBlind - 1].find('header').click();
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
        hExpanded = parseInt($('.blinds-wrapper').css('height')) - ((blinds.length - 1) * parseInt(hCollapsed)) + 'px';

        if (fnResize) fnResize(hExpanded, hCollapsed); // Custom callback
    };

    function headerClickCallback(sender, e) {
        var index = headerIndex($(sender));

        for (var i = 0; i < blinds.length; i++) {
            var expanded = i === index;
            var height = expanded ? hExpanded : hCollapsed
            resize(blinds[i], height, fadeDuration, expanded);
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
