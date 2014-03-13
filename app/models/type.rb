class Type < ActiveRecord::Base
	has_many :information
	has_many :guides
end
