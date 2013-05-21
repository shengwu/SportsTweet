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


# cursor = "-1"
# @followerIds = []
# while cursor != 0 do
# 	followers = Twitter.follower_ids('ESPNNBA',{:cursor=>cursor})
# 	cursor = followers.next_cursor
# 	puts "#{followers.ids}"
# 	@followerIds+= followers.ids
# 	sleep(2)
# end

cursor = "-1"
while cursor != 0 do
	followers = Twitter.follower_ids('SportsCenter',{:cursor=>cursor})
	cursor = followers.next_cursor
	array_of_followers=followers.ids
	# puts "#{array_of_followers}" 
	array_of_followers.each do |follower|
		f = Follower.create(:guid =>follower)
		# puts "#{follower}"
	end
	sleep(2)
end