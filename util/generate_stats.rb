require File.join(File.expand_path(File.dirname(__FILE__)),
                  '../config/environment')
require 'rubygems'
require 'tweetstream'
require 'net/http'
require 'uri'
require 'json'

def show_popular_players()
    # Get all tweets and all team names
    tweets = Tweet.select("text").map{|tweet| tweet.text}
    player_names = Player.select("name").map{|player| player.name}
    players = Hash[*player_names.zip([0]*player_names.length).flatten]

    # Counts mentions of NBA teams
    # e.g. "lebron james", counts tweets containing "lebron" AND "james"
    tweets.each do |tweet|
      players.each do |name, count|
        # Split name into first name and last name
        fragments = name.downcase.split
        first = fragments[0..-2].join(' ')
        last = fragments.last
        full = name.downcase.gsub(/\s+/, "")
        if (tweet.downcase.include? first and tweet.downcase.include? last) or tweet.downcase.include? full
          players[name] += 1
        end
      end

      if tweet.downcase.include? "lebron" or (tweet.downcase.include? "king" and tweet.downcase.include? "james") or tweet.downcase.include? "kingjames"
        players["LeBron James"]+=1
      end
      if tweet.downcase.include? "kidd" or tweet.downcase.include? "realjasonkidd"
        players["Jason Kidd"]+=1
      end
      if tweet.downcase.include? "kobe" or tweet.downcase.include? "mamba"
        players["Kobe Bryant"]+=1
      end
      if tweet.downcase.include? "dwight"
        players["Dwight Howard"]+=1
      end
      if tweet.downcase.include? "duncan"
        players["Tim Duncan"]+=1
      end
      if tweet.downcase.include? "jerryd"
        players["Jerryd Bayless"]+=1
      end
      if tweet.downcase.include? "parsons"
        players["Chandler Parsons"]+=1
      end
      if tweet.downcase.include? "rose" or tweet.downcase.include? "drose"
        players["Derrick Rose"]+=1
      end
      if tweet.downcase.include? "pierce"
        players["Paul Pierce"]+=1
      end
      if tweet.downcase.include? "dwade" or tweet.downcase.include? "wade"
        players["Dwyane Wade"]+=1
      end
      if tweet.downcase.include? "ginobili" or tweet.downcase.include? "manu"
        players["Manu Ginobili"]+=1
      end
      if tweet.downcase.include? "jlin" or tweet.downcase.include? "jlin7" or tweet.downcase.include? "linsanity"
        players["Jeremy Lin"]+=1
      end
      if tweet.downcase.include? "metta" or (tweet.downcase.include? "world" and tweet.downcase.include? "peace") or tweet.downcase.include? "artest"
        players["Metta World Peace"]+=1
      end
    end

    # Return the 10 most mentioned teams
    players.sort_by{|_key, value| value}.reverse[0..9]
  end


  begin
    item = CachedResult.find(:first, :conditions => ["name = top_players"])
    item.update_attributes(:result => show_popular_players())
  rescue Exception => e
    CachedResult.create(:name => 'top_players',:result => show_popular_players())
  end