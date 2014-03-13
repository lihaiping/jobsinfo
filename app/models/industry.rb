class Industry < ActiveRecord::Base
	has_many :guides
	has_many :jobs
end
