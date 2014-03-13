class WeixinsController < ApplicationController
	
	def index
		render :text => params[:echostr]
	end

	def create
		if params[:xml][:MsgType] == "text"
      			render "echo", :formats => :xml
    		end
	end

end
