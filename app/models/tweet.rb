class Tweet < ActiveRecord::Base
  attr_accessible :created_at, :favorite_count, :from_user_name, :hashtags, :id_str, :media, :place, :retweet_count, :text, :urls, :user_mentions
end
