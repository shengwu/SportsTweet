require File.join(File.expand_path(File.dirname(__FILE__)),
                  '../config/environment')
require 'rubygems'
require 'twitter'


Twitter.configure do |config|
	config.consumer_key       = ENV['CONSUMER_KEY']
	config.consumer_secret    = ENV['CONSUMER_SECRET']
	config.oauth_token        = ENV['OAUTH_TOKEN']
	config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
	#config.auth_method        = :oauth
end

Tweet.all.entries.each do |tweet|
	if tweet.media != []
		id = Integer(tweet.id_str)
		puts id
		Tweet.where(:id_str => id_str).destroy_all
		updated_tweet = Twitter.status(id)
		puts updated_tweet

		t = Tweet.create(:created_at => updated_tweet.created_at,
		                   :favorite_count => updated_tweet.favorite_count,
		                   :from_user_name => updated_tweet.user.name,
		                   :hashtags => updated_tweet.hashtags,
		                   :id_str => updated_tweet.id.to_s,
		                   :media => updated_tweet.media, 
		                   :place => updated_tweet.place,
		                   :retweet_count => updated_tweet.retweet_count,
		                   :text => updated_tweet.text,
		                   :urls => updated_tweet.urls,
		                   :user_mentions => updated_tweet.user_mentions,
		                   :user_id => updated_tweet.user.id)
		sleep 1.0
	end
end