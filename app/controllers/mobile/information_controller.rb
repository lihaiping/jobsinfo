class Mobile::InformationController < Mobile::ApplicationController

	def show
		@information = Information.find(params[:id])
	end
	
end
