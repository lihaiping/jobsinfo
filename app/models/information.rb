class Information < ActiveRecord::Base
	belongs_to :type
	belongs_to :job
end
