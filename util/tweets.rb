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


uri = URI.parse("http://localhost:9292/faye")

TweetStream::Client.new.track('nba') do |tweet|
  if tweet.lang == "en"
    puts tweet.text
    puts ""
    message = {
      'channel' => '/tweets', 
      'data' => {
        'text' => Obscenity.sanitize(tweet.text),
        'user_id' => tweet.user.id, 
        'screen_name' => tweet.user.screen_name
      }
    }
    Net::HTTP.post_form(uri, :message => message.to_json);
  end
end

# count=0
# array_of_followers=Array.new(5000)
# Follower.all.entries.each do |follower|
#   array_of_followers.append(follower.guid)
#   count+=1
#   puts count
# 	if count == 4999
# 		break
# 	end
# end
# TweetStream::Client.new.follow(array_of_followers) do |status|
#   puts "#{status.text}"
#   message = {'channel' => '/tweets', 'data' => status.text}
#   Net::HTTP.post_form(uri, :message => message.to_json);
# end
