window.App = {}

App.Blinds = (options) ->
  blinds: []
  totalBlinds: 4 # TODO Move to global config
  hExpanded: 0
  hCollapsed: 0
  blockScroll: true
  scrolledToTop: null
  scrolledToBottom: null
  fnFadeIn: options.fnFadeIn or null
  fnScroll: options.fnScroll or null
  fnResize: options.fnResize or null
  fadeDuration: options.fadeDuration or 1000 # TODO Move to global config
  fnHeaderClick: options.fnHeaderClick or null
  headerIndex: ($header) ->
    $('.blind').index $header.closest '.blind'
  selectedSection: ->
    $ '.blind.expanded'

  resize: (index, expanding, position) ->
    self = this
    $section = @blinds[index]
    self.blockScroll = true

    setTimeout (->
      self.blockScroll = false
      null
    ), @fadeDuration

    # TODO Move to global config
    $section.animate {scrollTop: 0}, {duration: @fadeDuration, queue: false}

    if expanding
      $section.removeClass 'collapsed'
      $section.addClass 'expanded'
      $section.css
        top: index * @hCollapsed
        height: @hExpanded
    else
      $section.removeClass 'expanded'
      $section.addClass 'collapsed'
      switch position
        when 'top'
          $section.css
            top: index * @hCollapsed,
            height: @hCollapsed
        when 'bottom'
          $section.css
            top: (--index * @hCollapsed) + @hExpanded,
            height: @hCollapsed


  # Event callbacks
  mousewheelCallback: (sender, e) ->
    return if @blockScroll
    $blind = $ e.currentTarget
    blindIndex = $('.blind').index $blind
    contentElement = $blind.find('.blind-content-area')[0]
    $content = $ contentElement

    direction = if e.originalEvent.wheelDelta >= 0 then 'up' else 'down'
    scrollTop = $content.scrollTop()
    scrollHeight = contentElement.scrollHeight
    scrollbarPresent = scrollHeight > $content.height()
    outerHeight = $content.outerHeight()

    switch direction
      when 'up'
        if blindIndex != 0 # ensure not viewing first blind
          if @scrolledToTop or not scrollbarPresent
            @blinds[blindIndex - 1].find('header').click() # open blind above
            @scrolledToTop = false
          else
            @scrolledToTop = scrollTop is 0
      when 'down'
        if blindIndex != (@blinds.length - 1)  # ensure not viewing last blind
          if @scrolledToBottom or !scrollbarPresent
            @blinds[blindIndex + 1].find('header').click() # open blind below
            @scrolledToBottom = false
          else
            @scrolledToBottom = scrollHeight - (scrollTop + 1) is outerHeight\
                            or scrollHeight - scrollTop is outerHeight
    fnScroll this if @fnScroll  # Custom callback

  resizeCallback: (sender, e) ->
    # Calculate collapsed height from CSS
    $div = $('<div class="blind collapsed"></div>').hide().appendTo 'body'
    @hCollapsed = parseInt($div.height())
    $div.remove

    # Calculate expanded height based on size of wrapper minus collapsed divs
    @hExpanded = parseInt($('.blinds-wrapper').height() - (@totalBlinds - 1) * @hCollapsed)

    # Call click again on selected section to redraw
    section = this.selectedSection()
    section.find('header').click()

    fnResize(@hExpanded, @hCollapsed) if @fnResize # Custom callback

  headerClickCallback: (sender, e) ->
    index = @headerIndex($(sender))
    i = 0
    while i < @totalBlinds
      expanding = i is index
      position = (if i <= index then "top" else "bottom")
      @resize i, expanding, position
      i++
    fnHeaderClick this if @fnHeaderClick # Custom callback

  initialize: ->
    # Events
    self = this
    $(document).on 'click', '.blind header', (e) ->
      self.headerClickCallback this, (e)
    $(document).on 'mousewheel', '.blind', (e) ->
      self.mousewheelCallback this, e
    $(window).on 'resize', (e) ->
      self.resizeCallback this, e
    $(window).on 'orientationchange', (e) ->
      self.resizeCallback this, e

    # Cache jQuery objects
    $.each $('.blind'), (i, s) ->
      self.blinds.push $ s

    # Calculate initial sizes
    $(window).trigger 'resize'

    # Fade out loading overlay
    @fnFadeIn(this) if @fnFadeIn

    # Initial animation
    setTimeout (->
      self.blinds[0].find('header').click()), self.fadeDuration * 2


# Set Jquery default easing
$.easing.def = "easeInOutCubic"
