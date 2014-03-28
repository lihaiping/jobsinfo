#encoding: utf-8
require 'grape'
require 'reply'

module Api

	class Api < Grape::API
		format :txt

		helpers do

			def get_msg
				{
					:to_user => params[:xml][:ToUserName],
					:from_user => params[:xml][:FromUserName],
					:msg_type => params[:xml][:MsgType],
					:content => params[:xml][:Content],
					:event => params[:xml][:Event],
					:event_key => params[:xml][:EventKey]
				}
			end

			def routers
				{
					:click_subscribe => 'subscribe',
          				:click_unsubscribe => 'unsubscribe',
					:reply_? => 'help',
					:click_help => 'help',
					:reply_1 => 'internship_recruit',
					:click_internship_recruit => 'internship_recruit',
					:reply_2 => 'campus_recruit',
					:click_campus_recruit => 'campus_recruit',
					:reply_3 => 'social_recruit',
					:click_social_recruit => 'social_recruit',
					:reply_4 => 'audition_guide',
					:click_audition_guide => 'audition_guide',
					:reply_5 => 'resume_guide',
					:click_resume_guide => 'resume_guide',
					:reply_6 => 'jobs_subscription',
					:click_jobs_subscription => 'jobs_subscription',
					:default => 'default',
					:unknow => 'unknow'
				}
			end

			def mount_route
				if 'text' == @msg[:msg_type]
					# Common text message
					if @config.function_key.include?(@msg[:content])
						('reply_' + @msg[:content]).to_sym 
					else
						:reply_?
					end
				elsif 'event' == @msg[:msg_type]
					# Event
					@msg[:event] = @msg[:event].downcase
					case @msg[:event]
					when 'subscribe'
						:click_subscribe
					when 'unsubscribe'
						:click_unsubscribe
					when 'click'
						# Click menu
						if @config.menu_key.include?(@msg[:event_key])
							('click_' + @msg[:event_key].downcase).to_sym
						else
							# Unknow menu key
							:unknow
						end
					else
						# Other events such as scanning code, location report and view etc
						:default
					end
				else
					# Other common message such as image, voice, video, link and location
					:click_help
				end
			end

			def subscribe
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], @config.subscribe + @config.help)
			end

			def unsubscribe
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], 'unsubscribe')
			end

			def help
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], @config.help)
			end

			def internship_recruit
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], 'internship_recruit')
			end

			def campus_recruit
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], 'campus_recruit')
			end

			def social_recruit
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], 'social_recruit')
			end

			def audition_guide
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], 'audition_guide')
			end

			def resume_guide
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], 'resume_guide')
			end

			def jobs_subscription
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], 'jobs_subscription')
			end

			# Do nothing
			def default
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], 'default')
			end

			def unknow
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], @config.unknow)
			end

		end

		namespace :weixin_io do

			desc 'Check the signature.'
			# params do
			# 	requires :timestamp, type: String, desc: "Timestamp."
			# 	requires :nonce, type: String, desc: "Nonce."
			# 	requires :signature, type: String, desc: "Signature."
			# end
			before do
				@logger ||= Logger.new("#{Rails.root}/log/weixin_api.log")
				@config = JobsInfo::Application.config
				# error!('Unauthorized', 401) unless Weixin.authenticated?(@config.token, params[:timestamp], params[:nonce], params[:signature])
			end

			after do
				status(200)
			end

			desc 'Return the echostr when authenticated.'
			get do
				params[:echostr]
			end

			post do
				# Add xml content into params
				params[:xml] = Hash.from_xml(request.body.read)["xml"]
				message = "\nWeixin params xml:\n#{params[:xml]}\n"
				puts message
				@logger.info("#{message}\n")
				begin
					@msg = get_msg
					router = mount_route
					send routers[router]
				rescue Exception => exception
					# TODO
					message = "\nRescue exception:\n#{exception.class} (#{exception.message})\n"
					puts message
					@logger.fatal("#{message}\n")
				end

			end
		end

	end

end