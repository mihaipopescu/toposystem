/*!
 * TopoSystem - Creative Theme
 * Modernized for Bootstrap 5 and contemporary JavaScript
 */

(function($) {
    "use strict";

    // Smooth page scrolling for anchor links
    $('a.page-scroll').on('click', function(event) {
        var $anchor = $(this);
        var target = $($anchor.attr('href'));
        
        if (target.length) {
            event.preventDefault();
            $('html, body').animate({
                scrollTop: (target.offset().top - 70)
            }, 1000);
        }
    });

    // Update navbar on scroll
    $(window).on('scroll', function() {
        var scrollTop = $(document).scrollTop();
        if (scrollTop > 100) {
            $('#mainNav').addClass('bg-dark');
        } else {
            $('#mainNav').removeClass('bg-dark');
        }
    });

    // Close responsive menu when link is clicked
    $('.navbar-collapse a:not(.dropdown-toggle)').on('click', function() {
        var toggle = document.querySelector('[type="button"][data-bs-toggle="collapse"]');
        if (toggle && toggle.offsetParent !== null) {
            toggle.click();
        }
    });

    // Initialize WOW.js for scroll animations
    if (typeof WOW !== 'undefined') {
        new WOW().init();
    }

})(jQuery);
