# Import csv files with NBA teams and players
require 'csv'
current_path = File.dirname(__FILE__)

task :import_players => :environment do
  nba_players = File.read(File.join(current_path, '..', 'assets', 'csv', 'nba_players.csv'))
  players_csv = CSV.parse(nba_players, :headers => true)
  players_csv.each do |row|
    Player.create!(row.to_hash)
  end
end

task :import_teams => :environment do
  nba_teams = File.read(File.join(current_path, '..', 'assets', 'csv', 'nba_teams.csv'))
  teams_csv = CSV.parse(nba_teams, :headers => true)
  teams_csv.each do |row|
    Team.create!(row.to_hash)
  end
end
