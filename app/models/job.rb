class Job < ActiveRecord::Base
	belongs_to :industry
	has_many :information
	has_and_belongs_to_many :users, join_table: :subscriptions
end
