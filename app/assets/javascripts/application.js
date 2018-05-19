// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//  require activestorage


$('.load-spinner').bind('ajax:beforeSend', function () {
    $('#loader-2').show();
    $('body').addClass('page-loading-overlay');
});

$('.load-spinner').bind('ajax:complete', function () {
    $('#loader-2').hide();
    $('body').removeClass('page-loading-overlay');

});

// TODO: Move ALL Javascript script tags through-out the app to application.js
$(document).ready(function () {

    // hide spinner
    $(".loader").hide();


    // show spinner on AJAX start
    $(document).ajaxStart(function () {
        $(".loader").show();
    });

    // hide spinner on AJAX stop
    $(document).ajaxStop(function () {
        $(".loader").hide();
    });

});
window.onload = function () {
    var body = document.getElementsByTagName("BODY")[0];
    body.classList.add('page-body');
};

<!-- TODO:Add JS script to check if window size < (Small-pre-defined-size), add class "sidebar-collapsed" to close sidebar by default -->
function resizeWindow(window_width) {
    if ((window_width > 1200) && (window_width < 1680)) {
        console.log('Collapse Sidebar');
        if (!($('#sidebar').hasClass('collapsed'))) {
            $('#sidebar').addClass("collapsed");
        }
    }
    else if ((window_width > 1680)) {
        console.log('Show Sidebar');
        if (($('#sidebar').hasClass('collapsed'))) {
            $('#sidebar').removeClass("collapsed");
        }
    }
}

jQuery(document).ready(function ($) {
    resizeWindow($(window).width());
});

$(window).on('resize', function () {
    // resizeWindow( $(window).width());
});