require File.join(File.expand_path(File.dirname(__FILE__)),
                  '../config/environment')
require 'rubygems'
require 'tweetstream'
require 'net/http'
require 'uri'
require 'json'

TweetStream.configure do |config|
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

if ENV.has_key?("FAYE_SERVER")
  uri = URI.parse(ENV['FAYE_SERVER'])
else
  uri = URI.parse("http://sportstweet-faye.herokuapp.com/faye")
end

TweetStream::Client.new.track('nba') do |tweet|
  # Only accept English language tweets
  if tweet.lang == "en"
    # Check for mentions of top teams and players in tweet
    top_teams = CachedResult.where(:name => "top_teams")[0].result.map{|team| team[0]}
    top_players = CachedResult.where(:name => "top_players")[0].result.map{|player| player[0]}
    mentions = Hash.new(0)
    top_teams.each do |team|
      fragments = team.downcase.split
      city = fragments[0..-2].join(' ')
      name = fragments.last
      if tweet.text.downcase.include? city or tweet.text.downcase.include? name
        mentions[team] += 1
      end
    end
    top_players.each do |player|
      if tweet.text.downcase.include? player.downcase
        mentions[player] += 1
      end
    end

    # Post tweet to the message handler
    message = {
      'channel' => '/tweets', 
      'data' => {
        'text' => Obscenity.sanitize(tweet.text),
        'user_id' => tweet.user.id, 
        'screen_name' => tweet.user.screen_name,
        'mentions' => mentions
      }
    }
    Net::HTTP.post_form(uri, :message => message.to_json);

    # Save tweet to the database
    if tweet.media != [] and Obscenity.profane?(tweet.text) == false
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
      print "X"
    end
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
    print "."
  end
end
