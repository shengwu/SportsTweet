SportsTweet
===========

SportsTweet is a app for sports journalists and fans looking to track what sports topics are being tweeted about most. It aggregates tweets to visually summarize the most popular topics for a given sport, including athletes, teams, games, or moments. For our work in the Innovation in Journalism and Tech class, we limited the scope to basketball.

## Running the application
From the root directory of this repo, run the following commands:  
`rails s`  
`rackup faye.ru -s thin -E production`  
`ruby util/tweets.rb`  
`ruby util/scrape.rb`  

## Updating the crontab
`whenever --update-crontab store`  
To clear,  
`whenever -c store`

## Importing team and player data
These commands import the `lib/assets/csv/nba_teams.csv` and `lib/assets/csv/nba_players.csv` files into the database. It takes a few seconds.  
`rake import_teams`  
`rake import_players`
