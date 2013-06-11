require "uri"

module HomeHelper
  def show_popular_teams()
    # Get all tweets and all team names
    tweets = Tweet.select("text").map{|tweet| tweet.text}
    team_names = Team.select("name").map{|team| team.name}
    teams = Hash[*team_names.zip([0]*team_names.length).flatten]

    # Counts mentions of NBA teams
    # e.g. "Miami Heat", counts tweets containing "miami" or "heat"
    tweets.each do |tweet|
      teams.each do |team, count|
        # Split name into city and team name
        fragments = team.downcase.split
        city = fragments[0..-2].join(' ')
        name = fragments.last
        if tweet.downcase.include? city or tweet.downcase.include? name
          teams[team] += 1
        end
      end
    end

    # Return the 10 most mentioned teams
    teams.sort_by{|_key, value| value}.reverse[0..9]
  end

  def show_popular_players()
    CachedResult.where(:name => "top_players")[0].result
  end

  def get_twelve_tweets()
    # Return twelve tweets to prepopulate the streaming tweet area
    Tweet.order("created_at DESC").limit(12)
  end

  def get_pictures()
    # Get the six most favorited tweets with photos
    Photo.order("favorite_count DESC").limit(6)
  end

  def elapsed_minutes()
    # Return age of oldest tweet in database
    oldest = Tweet.order("created_at").limit(1)[0].created_at
    seconds = Time.now - oldest
    (seconds/60).round()
  end

  def num_tweets()
    Tweet.count
  end

  def top_words()
    stopwords = ['gt','amp','2013','just','season','games','finals','like','basketball','win','2k13','','players','team','best','vs','play','new','said','rt','game','coach','1','2','3','4','5','6','7','8','9','0','http','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','nba','a', 'about', 'above', 'above', 'across', 'after', 'afterwards', 'again', 'against', 'all', 'almost', 'alone', 'along', 'already', 'also','although','always','am','among', 'amongst', 'amoungst', 'amount',  'an', 'and', 'another', 'any','anyhow','anyone','anything','anyway', 'anywhere', 'are', 'around', 'as',  'at', 'back','be','became', 'because','become','becomes', 'becoming', 'been', 'before', 'beforehand', 'behind', 'being', 'below', 'beside', 'besides', 'between', 'beyond', 'bill', 'both', 'bottom','but', 'by', 'call', 'can', 'cannot', 'cant', 'co', 'con', 'could', 'couldnt', 'cry', 'de', 'describe', 'detail', 'do', 'done', 'down', 'due', 'during', 'each', 'eg', 'eight', 'either', 'eleven','else', 'elsewhere', 'empty', 'enough', 'etc', 'even', 'ever', 'every', 'everyone', 'everything', 'everywhere', 'except', 'few', 'fifteen', 'fify', 'fill', 'find', 'fire', 'first', 'five', 'for', 'former', 'formerly', 'forty', 'found', 'four', 'from', 'front', 'full', 'further', 'get', 'give', 'go', 'had', 'has', 'hasnt', 'have', 'he', 'hence', 'her', 'here', 'hereafter', 'hereby', 'herein', 'hereupon', 'hers', 'herself', 'him', 'himself', 'his', 'how', 'however', 'hundred', 'ie', 'if', 'in', 'inc', 'indeed', 'interest', 'into', 'is', 'it', 'its', 'itself', 'keep', 'last', 'latter', 'latterly', 'least', 'less', 'ltd', 'made', 'many', 'may', 'me', 'meanwhile', 'might', 'mill', 'mine', 'more', 'moreover', 'most', 'mostly', 'move', 'much', 'must', 'my', 'myself', 'name', 'namely', 'neither', 'never', 'nevertheless', 'next', 'nine', 'no', 'nobody', 'none', 'noone', 'nor', 'not', 'nothing', 'now', 'nowhere', 'of', 'off', 'often', 'on', 'once', 'one', 'only', 'onto', 'or', 'other', 'others', 'otherwise', 'our', 'ours', 'ourselves', 'out', 'over', 'own','part', 'per', 'perhaps', 'please', 'put', 'rather', 're', 'same', 'see', 'seem', 'seemed', 'seeming', 'seems', 'serious', 'several', 'she', 'should', 'show', 'side', 'since', 'sincere', 'six', 'sixty', 'so', 'some', 'somehow', 'someone', 'something', 'sometime', 'sometimes', 'somewhere', 'still', 'such', 'system', 'take', 'ten', 'than', 'that', 'the', 'their', 'them', 'themselves', 'then', 'thence', 'there', 'thereafter', 'thereby', 'therefore', 'therein', 'thereupon', 'these', 'they', 'thickv', 'thin', 'third', 'this', 'those', 'though', 'three', 'through', 'throughout', 'thru', 'thus', 'to', 'together', 'too', 'top', 'toward', 'towards', 'twelve', 'twenty', 'two', 'un', 'under', 'until', 'up', 'upon', 'us', 'very', 'via', 'was', 'we', 'well', 'were', 'what', 'whatever', 'when', 'whence', 'whenever', 'where', 'whereafter', 'whereas', 'whereby', 'wherein', 'whereupon', 'wherever', 'whether', 'which', 'whither', 'who', 'whoever', 'whole', 'whom', 'whose', 'why', 'will', 'with', 'within', 'without', 'would', 'yet', 'you', 'your', 'yours', 'yourself', 'yourselves', 'the']
    words_hash = Hash.new(0)
    Tweet.all.each do |tweet|
      tweet = tweet.text.downcase
      word_array = tweet.split(/\W+/)
      word_array.each do |word|
        if stopwords.include?(word)
          next
        end
        words_hash[word]+=1
      end
    end
    words_hash.sort_by{|_key, value| value}.reverse[0..9]
  end 

  def white_list(include_word)
    hash = Hash.new(0)
    whitelist = ["seven","rim","backboard","fire","hot","jump","fadeaway","clock","hook","screen","buzzer","beater","zone","sixth","airball","fast","break","timeout","posterized","rip","fined","lawsuit","scandal","trade","best","worst","turnover","injure","injury","finish","choke","hair","fashion","headband","mask","three-pointer","percentage","high","low","career","perimeter","trade","young","old","salary","agent","stay","leave","ot","offense","defense","retiring","lost","won","ejected","clutch","mj","finals","achilles","180","360","retirement","retire","injury","return","out","flop","mvp","dunk", "slam", "alley", "alley-oop", "airball", "brick", "charge", "foul", "dirty", "ejected", "flagrant", "ref", "suck", "freethrow", "goaltend", "bench", "overtime", "travel", "steal", "three", "crossed", "crossover", "handle", "lead", "choke", "pass", "assist", "score"]
    Tweet.all.each do |tweet|
      tweet = tweet.text.downcase
      if tweet.include? include_word
        whitelist.each do |whitelisted_word|
          if tweet.include? whitelisted_word
            hash[whitelisted_word]+=1
          end
        end
      end
    end
    hash.sort_by{|k,v| v}.reverse[0..4]
  end

end


