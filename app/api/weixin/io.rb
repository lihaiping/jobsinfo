#encoding: utf-8
require 'grape'
require 'weixin_handler'

module Weixin

	class IO < Grape::API
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
					if @config.function.has_value?(@msg[:content] )
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
						@msg[:event_key] = @msg[:event_key].downcase
						if @config.function.has_key?(@msg[:event_key].to_sym)
							('click_' + @msg[:event_key]).to_sym
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
				user_info = @client.user.info(@msg[:from_user])
				if 1 == user_info['subscribe']
					user = User.find_or_initialize_by(openid: @msg[:from_user]) do |user|
						user.nickname = user_info['nickname']
						user.area = user_info['province'] + user_info['city']
						user.subscribe = 1
					end
					user.update_attributes(subscribe: 1) unless user.new_record?
					user.save
					Weixin.text_msg(@msg[:to_user], @msg[:from_user], @config.subscribe + @config.help)
				end
			end

			def unsubscribe
				user = User.find_by(openid: @msg[:from_user])
				user.update_attributes(subscribe: 0) unless user.nil?
			end

			def help
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], @config.help)
			end

			def recruit(id)
				# TODO add subscription filter
				records = Information.where(type_id: id).order("release_time DESC").limit(6)
				if 0< records.count
					items = []
					records.each do |record|
						title = record.company + "招聘" + record.job.name
						items << Weixin.item(title, '', record.image.url, record.link)
					end
					Weixin.news_msg(@msg[:to_user], @msg[:from_user], items)
				else
					Weixin.text_msg(@msg[:to_user], @msg[:from_user], @config.no_records)
				end			
			end

			def internship_recruit
				type = Type.find_by(keyword: @config.function[:internship_recruit])
				recruit(type.id)
			end

			def campus_recruit
				type = Type.find_by(keyword: @config.function[:campus_recruit])
				recruit(type.id)
			end

			def social_recruit
				# TODO add subscription filter
				type = Type.find_by(keyword: @config.function[:social_recruit])
				recruit(type.id)
			end

			def guide(id)
				# TODO add subscription filter
				records = Information.where(type_id: id).limit(3)	
				if 0< records.count
					items = []
					records.each do |record|
						items << Weixin.item(record.title, '', record.image.url, record.link)
					end
					Weixin.news_msg(@msg[:to_user], @msg[:from_user], items)
				else
					Weixin.text_msg(@msg[:to_user], @msg[:from_user], @config.no_records)
				end
			end

			def audition_guide
				type = Type.find_by(keyword: @config.function[:audition_guide])
				guide(type.id)
			end

			def resume_guide
				# TODO add subscription filter
				type = Type.find_by(keyword: @config.function[:resume_guide])
				guide(type.id)
			end

			def jobs_subscription
				content = @config.jobs_subscription + '<a href="www.google.com">' + '点此设置'+ '</a>'
				Weixin.text_msg(@msg[:to_user], @msg[:from_user], content)
			end

			# Do nothing
			def default
				
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
				error!('Forbidden', 401) unless Weixin.valid?(@config.token, params[:timestamp], params[:nonce], params[:signature])
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
				@client = Weixin::Client.new(@config.app_id, @config.app_secret)
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