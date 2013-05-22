class Team < ActiveRecord::Base
  has_many :players, :dependent => :destroy
  attr_accessible :name
end
