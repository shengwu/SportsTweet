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

  @stopwords = ['play','new','said','rt','game','coach','1','2','3','4','5','6','7','8','9','0','http','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','nba','a', 'about', 'above', 'above', 'across', 'after', 'afterwards', 'again', 'against', 'all', 'almost', 'alone', 'along', 'already', 'also','although','always','am','among', 'amongst', 'amoungst', 'amount',  'an', 'and', 'another', 'any','anyhow','anyone','anything','anyway', 'anywhere', 'are', 'around', 'as',  'at', 'back','be','became', 'because','become','becomes', 'becoming', 'been', 'before', 'beforehand', 'behind', 'being', 'below', 'beside', 'besides', 'between', 'beyond', 'bill', 'both', 'bottom','but', 'by', 'call', 'can', 'cannot', 'cant', 'co', 'con', 'could', 'couldnt', 'cry', 'de', 'describe', 'detail', 'do', 'done', 'down', 'due', 'during', 'each', 'eg', 'eight', 'either', 'eleven','else', 'elsewhere', 'empty', 'enough', 'etc', 'even', 'ever', 'every', 'everyone', 'everything', 'everywhere', 'except', 'few', 'fifteen', 'fify', 'fill', 'find', 'fire', 'first', 'five', 'for', 'former', 'formerly', 'forty', 'found', 'four', 'from', 'front', 'full', 'further', 'get', 'give', 'go', 'had', 'has', 'hasnt', 'have', 'he', 'hence', 'her', 'here', 'hereafter', 'hereby', 'herein', 'hereupon', 'hers', 'herself', 'him', 'himself', 'his', 'how', 'however', 'hundred', 'ie', 'if', 'in', 'inc', 'indeed', 'interest', 'into', 'is', 'it', 'its', 'itself', 'keep', 'last', 'latter', 'latterly', 'least', 'less', 'ltd', 'made', 'many', 'may', 'me', 'meanwhile', 'might', 'mill', 'mine', 'more', 'moreover', 'most', 'mostly', 'move', 'much', 'must', 'my', 'myself', 'name', 'namely', 'neither', 'never', 'nevertheless', 'next', 'nine', 'no', 'nobody', 'none', 'noone', 'nor', 'not', 'nothing', 'now', 'nowhere', 'of', 'off', 'often', 'on', 'once', 'one', 'only', 'onto', 'or', 'other', 'others', 'otherwise', 'our', 'ours', 'ourselves', 'out', 'over', 'own','part', 'per', 'perhaps', 'please', 'put', 'rather', 're', 'same', 'see', 'seem', 'seemed', 'seeming', 'seems', 'serious', 'several', 'she', 'should', 'show', 'side', 'since', 'sincere', 'six', 'sixty', 'so', 'some', 'somehow', 'someone', 'something', 'sometime', 'sometimes', 'somewhere', 'still', 'such', 'system', 'take', 'ten', 'than', 'that', 'the', 'their', 'them', 'themselves', 'then', 'thence', 'there', 'thereafter', 'thereby', 'therefore', 'therein', 'thereupon', 'these', 'they', 'thickv', 'thin', 'third', 'this', 'those', 'though', 'three', 'through', 'throughout', 'thru', 'thus', 'to', 'together', 'too', 'top', 'toward', 'towards', 'twelve', 'twenty', 'two', 'un', 'under', 'until', 'up', 'upon', 'us', 'very', 'via', 'was', 'we', 'well', 'were', 'what', 'whatever', 'when', 'whence', 'whenever', 'where', 'whereafter', 'whereas', 'whereby', 'wherein', 'whereupon', 'wherever', 'whether', 'which', 'whither', 'who', 'whoever', 'whole', 'whom', 'whose', 'why', 'will', 'with', 'within', 'without', 'would', 'yet', 'you', 'your', 'yours', 'yourself', 'yourselves', 'the']
  def top_words()
    words_hash = Hash.new(0)
    Tweet.all.each do |tweet|
      tweet = tweet.text.downcase
      word_array = tweet.split(/\W+/)
      word_array.each do |word|
        if @stopwords.include?(word)
          next
        end
        words_hash[word]+=1
      end
    end

    words_hash = words_hash.sort_by{|k,v| v}
    count = words_hash.count-1
    words_hash[(count-15)..-1]
  end 
end


