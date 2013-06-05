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
# first = Photo.first.id
# last = Photo.last.id
# (first..last).each do |id|
# 	puts "id:"+id.to_s
# 	twitter_id = Photo.find_by_id(id).id_str
# 	updated_tweet = Twitter.status(twitter_id)
# 	Photo.update(id,:favorite_count => updated_tweet.favorite_count)
# 	# sleep 1.0/3.0
# end
counter=0
Photo.all.each do |photo|
	updated_tweet = Twitter.status(photo.id_str)
	print updated_tweet.favorite_count
	print " "
	item = Photo.find(:first, :conditions => [ "id_str = ?", photo.id_str])
	item.update_attributes(:favorite_count => updated_tweet.favorite_count)
	counter+=1
end
puts "done updating "+counter.to_s+ " photo tweets"