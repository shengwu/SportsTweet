require "uri"

module HomeHelper
  def show_popular()
    tweets = Tweet.select("text")
    teams  = {"thunder" => 0,
    "rockets" => 0,
    "heat" => 0,
    "bucks" => 0,
    "clippers" => 0,
    "grizzlies" => 0,
    "nets" => 0,
    "bulls" => 0,
    "nuggets" => 0,
    "warriors" => 0,
    "pacers" => 0,
    "hawks" => 0,
    "spurs" => 0,
    "lakers" => 0,
    "knicks" => 0,
    "celtics" => 0}
    tweets.each do |tweet|
      teams.each do |team, count|
        if tweet.text.downcase.include? team
          teams[team] += 1
        end
      end
    end
    teams.sort_by{|_key, value| value}.reverse
  end

  def get_picture()
    picked_tweet_url=nil
    picked_tweet_text=nil
    favorites=-1

    Photo.all.entries.each do |photo|
        if photo.favorite_count > favorites
            picked_tweet_url= photo.media
            picked_tweet_text = photo.text
            favorites = photo.favorite_count
        end

    end
    picked_tweet_text.slice! picked_tweet_url
    [picked_tweet_url,picked_tweet_text,favorites]
  end

  def tweet_timeframe()
    oldest = Tweet.first.created_at
    newest = Tweet.last.created_at
    seconds = newest - oldest
    (seconds/60).round(1)  #return number of minutes
  end

  def tweet_count()
    Tweet.count
  end
end