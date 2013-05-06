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
end
