//
//= require jquery
//= require jquery_ujs

$(document).on('click', 'section a', function () {
    var sections = $('#home_controller').find('section');
    $.each(sections, function (i, section) {
        var section = $(section);
        section.removeClass('expanded normal');
        section.addClass('collapsed');
    });

    var expanded = $(this).parent();
    expanded.removeClass('collapsed');
    expanded.addClass('expanded');
});