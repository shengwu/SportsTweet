class DropTweetPicsTable < ActiveRecord::Migration
  def up
  	drop_table :tweet_pics
  end

  def down
  end
end
