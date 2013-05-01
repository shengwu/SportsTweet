class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.integer :favorite_count
      t.string :from_user_name
      t.string :created_at
      t.string :id_str
      t.integer :retweet_count
      t.text :hashtags
      t.text :media
      t.text :urls
      t.text :user_mentions
      t.text :place

      t.timestamps
    end
  end
end
