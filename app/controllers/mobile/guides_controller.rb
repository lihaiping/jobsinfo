class Mobile::GuidesController < Mobile::ApplicationController

	def show
		@guide = Guide.find(params[:id])
	end
end
