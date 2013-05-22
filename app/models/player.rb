class Player < ActiveRecord::Base
  belongs_to :team
  attr_accessible :aliases, :name
  serialize :aliases
end
