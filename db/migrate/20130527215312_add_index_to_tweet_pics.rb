class AddIndexToTweetPics < ActiveRecord::Migration
  def change
  	add_index :tweet_pics,:id_str, :unique => true
  end
end
