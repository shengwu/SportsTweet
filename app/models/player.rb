class Player < ActiveRecord::Base
  belongs_to :team
  attr_accessible :aliases, :name, :id, :team, :team_id, :team_name
  serialize :aliases
end
