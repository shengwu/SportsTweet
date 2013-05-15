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
    count=0
    favorites=-1

    Tweet.all.entries.each do |tweet|
        if tweet.media != [] and tweet.favorite_count > favorites
            picked_tweet_url= tweet.media[0].media_url
            picked_tweet_text = tweet.text
            picked_tweet_text.slice! picked_tweet_url

            favorites = tweet.favorite_count
        end

        if count == 10000
            break
        end
        count+=1
    end
    [picked_tweet_url,picked_tweet_text]
  end
end