// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
    // Start slideshow
    $('#slides').slidesjs({
        width: 400,
        height: 400,
        pagination: false,
        generatePagination: false,
        play: {
            auto: true,
            interval: 2000,
            swap: true,
            pauseOnHover: true,
            restartDelay: 1000
        }
    });

    // Connect to a stream of tweets
    if (typeof Faye !== 'undefined') {
        var faye = new Faye.Client('http://localhost:9292/faye');
        faye.subscribe('/tweets', function(data) {
            var elem = '<div class="tweet" style="display: none;">' + data + '</div>';
            $('.tweets').prepend(elem);
            var tweets = $('.tweet');
            tweets.slideDown();
            if (tweets.length > 6) {
                $(tweets[tweets.length-1]).remove();
            }
        });
    } else {
        $('.tweets').prepend("<p>A connection could not be established with the server that handles streaming tweets.</p>");
    }
});
