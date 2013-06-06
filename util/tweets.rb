require File.join(File.expand_path(File.dirname(__FILE__)),
                  '../config/environment')
require 'rubygems'
require 'tweetstream'
require 'net/http'
require 'uri'
require 'json'
require 'timeout'

TweetStream.configure do |config|
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

uri = URI.parse(ENV['FAYE_SERVER'])

# Quit script after ten minutes
Timeout::timeout(600) {
TweetStream::Client.new.track('nba') do |tweet|
  # Only accept English language tweets
  if tweet.lang == "en"
    # Post tweet to the message handler
    message = {
      'channel' => '/tweets', 
      'data' => {
        'text' => Obscenity.sanitize(tweet.text),
        'user_id' => tweet.user.id, 
        'screen_name' => tweet.user.screen_name
      }
    }
    Net::HTTP.post_form(uri, :message => message.to_json);

    # Save tweet to the database
    if tweet.media != []
      if Obscenity.profane?(tweet.text) == false
        print "X"
        t = Photo.create(:created_at => tweet.created_at,
                       :favorite_count => tweet.favorite_count,
                       :from_user_name => tweet.user.name,
                       :hashtags => tweet.hashtags,
                       :id_str => tweet.id.to_s,
                       :media => tweet.media[0].media_url, 
                       :place => tweet.place,
                       :retweet_count => tweet.retweet_count,
                       :text => tweet.text,
                       :screen_name => tweet.user.screen_name,
                       :urls => tweet.urls,
                       :user_mentions => tweet.user_mentions,
                       :user_id => tweet.user.id)
      end
    end
    print "."
    t = Tweet.create(:created_at => tweet.created_at,
                   :favorite_count => tweet.favorite_count,
                   :from_user_name => tweet.user.name,
                   :hashtags => tweet.hashtags,
                   :id_str => tweet.id.to_s,
                   :media => tweet.media, 
                   :place => tweet.place,
                   :retweet_count => tweet.retweet_count,
                   :text => Obscenity.sanitize(tweet.text),
                   :screen_name => tweet.user.screen_name,
                   :urls => tweet.urls,
                   :user_mentions => tweet.user_mentions,
                   :user_id => tweet.user.id)
  end
end
}
