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

TweetStream::Client.new.track('lebron', 'basketball') do |status|
  puts "#{status.text}"
  message = {'channel' => '/tweets', 'data' => status.text}
  Net::HTTP.post_form(uri, :message => message.to_json);
end
