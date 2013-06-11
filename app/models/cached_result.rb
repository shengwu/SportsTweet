class CachedResult < ActiveRecord::Base
  attr_accessible :name, :result
  serialize :result
end
