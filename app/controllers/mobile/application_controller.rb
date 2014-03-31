class Mobile::ApplicationController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :prepare

	layout 'mobile'

	def prepare
		@config = JobsInfo::Application.config
	end
	
end
