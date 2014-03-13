class Information < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :type
	belongs_to :job
end
