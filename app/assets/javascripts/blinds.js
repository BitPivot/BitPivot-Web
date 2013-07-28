var Blinds = function(options) {

    var sections = [];
    var totalBlinds = 4;
    var hExpanded = 0;
    var hCollapsed = 0;
    var blockScroll = false;
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
        $(document).on('mousewheel', '.blind-content', function(e) { mousewheelCallback(this, e); });
        $(window).on('resize', function(e) { resizeCallback(this, e); });
        $(window).on('orientationchange', function(e) { resizeCallback(this, e); });

        // Calculate initial sizes
        $(window).trigger('resize');

        // Fade out loading overlay
        if (fnFadeIn) fnFadeIn(this);

        // Initial animation
        setTimeout(function() { sections[0].find('header').click(); }, fadeDuration * 2);
    };

    function resize(index, expanding, position) {
        var section = sections[index];
        blockScroll = true;
        //section.animate({scrollTop: 0}, {duration: fadeDuration, queue: false}); // TODO

        if (expanding) {
            section.removeClass('collapsed');
            section.addClass('expanded');
            section.css({
                top: index * hCollapsed,
                height: hExpanded
            });
        }
        else {
            section.removeClass('expanded');
            section.addClass('collapsed');
            switch (position) {
                case 'top':
                    section.css({
                        top: index * hCollapsed,
                        height: hCollapsed
                    });
                    break;

                case 'bottom':
                    section.css({
                        top: (--index * hCollapsed) + hExpanded,
                        height: hCollapsed
                    });
                    break;
            }
        }
        //section.animate({ height: height }, {
        //    duration: duration,
        //    complete: function() {
        //        blockScroll = false;
        //    },
        //    queue: false
        //});
    };



    /*
     * Event callbacks
     */
    function mousewheelCallback(sender, e) {
        if (blockScroll) return;

        var $blindContent = $(e.currentTarget);
        var section = $blindContent.closest('.blind');
        var scrollTop = section.scrollTop();
        var scrollHeight = section[0].scrollHeight;
        var scrollbarPresent = $blindContent.scrollHeight > $blindContent.height();
        var outerHeight = section.outerHeight();
        var direction = e.originalEvent.wheelDelta >= 0 ? 'up' : 'down';
        var i = $('.blind').index(section);

        // scrolled to bottom of element
        if (scrollHeight - (scrollTop + 1) === outerHeight || scrollHeight - scrollTop === outerHeight) {
            // scrolling down
            if (scrolledToBottom && direction === 'down') {
                // not viewing bottom section
                if (i !== totalBlinds - 1 || !scrollbarPresent)
                // open section below
                    sections[i+1].find('header').click();
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
                if (i !== 0 || !scrollbarPresent)
                // open section above
                    sections[i-1].find('header').click();
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
        hCollapsed = parseInt($div.css('height'));
        console.log(hCollapsed);
        $div.remove();

        // Calculate expanded height based on size of wrapper minus collapsed divs
        hExpanded = parseInt($('.blinds-wrapper').css('height')) - ((totalBlinds - 1) * hCollapsed);
        console.log(hExpanded);

        if (fnResize) fnResize(hExpanded, hCollapsed); // Custom callback
    };

    function headerClickCallback(sender, e) {
        var index = headerIndex($(sender));

        for (var i = 0; i < totalBlinds; i++) {
            var expanding = i === index;
            var position = i < index ? 'top' : 'bottom'
            resize(i, expanding, position);
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
