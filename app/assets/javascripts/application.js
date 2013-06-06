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

// Function for using format strings
if (!String.prototype.format) {
  String.prototype.format = function() {
    var args = arguments;
    return this.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number]
        : match
      ;
    });
  };
}

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

    // Set image sizes
    $('.slide img').load(function() {
        var imgType = (this.width/this.height > 1) ? 'wide' : 'tall';
        $(this).addClass(imgType);
    });

    // Increment minute display each minute
    var incrementMinutes = function() {
        var minuteCounter = $('.elapsed_minutes');
        minuteCounter.text(parseInt(minuteCounter.text()) + 1);
        window.setTimeout(incrementMinutes, 60000);
    };
    window.setTimeout(incrementMinutes, 60000);

    // Connect to a stream of tweets
    var addIncomingTweet = function(data) {
        var elem = '<div class="tweet" style="display: none;">{0} &mdash; <a class="author" href="http://twitter.com/account/redirect_by_id?id={1}" target="_blank">@{2}</a></div>'.format(data.text, data.user_id, data.screen_name);
        $('.tweets').prepend(elem);
        var tweets = $('.tweet');
        tweets.slideDown();
        if (tweets.length > 12) {
            $(tweets[tweets.length-1]).remove();
        }

        // Increment counter
        var tweetCounter = $('.num_tweets');
        tweetCounter.text(parseInt(tweetCounter.text()) + 1);
    };
    if (typeof Faye !== 'undefined') {
        var faye = new Faye.Client('http://localhost:9292/faye');
        faye.subscribe('/tweets', addIncomingTweet);
    } else {
        $('.tweets').prepend("<p>A connection could not be established with the server that handles streaming tweets.</p>");
    }
});
