require 'rubygems'
require 'tweetstream'
require 'net/http'
require 'uri'

TweetStream.configure do |config|
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

TweetStream::Client.new.track('lebron', 'basketball') do |status|
  #puts "#{status.text}"
  cmd = "curl http://localhost:9292/faye -d 'message={\"channel\":\"/tweets\", \"data\":\"" + status.text + "\"}'"
  system(cmd)
end
