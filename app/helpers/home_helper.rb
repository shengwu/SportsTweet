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
    photo = Photo.find(:all, :order => "favorite_count").last
    url = photo.media
    text = photo.text
    [url,text,photo.favorite_count]
  end

  def get_pictures()
    url=[]
    text=[]
    iter = 0
    count = Photo.count -1
    photo_array = Photo.find(:all, :order => "favorite_count")[(count-4)...(count)]#get last four photo tweets
    4.times do
      photo = photo_array[iter]
      url.append(photo.media)
      text.append(photo.text)
      iter += 1
    end
    [url,text]
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

  def top_words()
    words_hash = Hash.new(0)
    Tweet.all.each do |tweet|
      word_array = tweet.text.split(/\W+/)
      word_array.each do |word|
        words_hash[word]+=1
      end
    end

    words_hash = words_hash.sort_by{|k,v| v}
    count = words_hash.count-1
    words_hash[(count-10)..-1]
  end
end


