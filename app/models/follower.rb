class Follower < ActiveRecord::Base
  attr_accessible :guid 
  validates_uniqueness_of :guid
end
