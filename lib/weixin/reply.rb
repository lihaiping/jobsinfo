# -*- encoding : utf-8 -*-
# Base on the rack-weixin on https://github.com/wolfg1969/rack-weixin
require 'weixin/model'

module Weixin

	extend self

	def authenticated?(token, timestamp, nonce, signature)
		if token && timestamp && nonce && signature
			tmpStr = [token, timestamp, nonce].sort.join
			signature == Digest::SHA1.hexdigest(tmpStr)
		else
			false
		end
	end

	def text_msg(to, from, content)
		msg = TextReplyMessage.new
		msg.ToUserName = to
		msg.FromUserName = from
		msg.Content = content
		msg.to_xml
	end

	def music_msg(to, from, music)
		msg = MusicReplyMessage.new
		msg.ToUserName = to
		msg.FromUserName = from
		msg.Music = music
		msg.to_xml
	end

	def news_msg(to, from, items)
		msg = NewsReplyMessage.new
		msg.ToUserName = to
		msg.FromUserName = from
		msg.Articles = items
		msg.ArticleCount = items.count
		msg.to_xml
	end

	def music(title, desc, music_url, hq_music_url)	
		item = Music.new
		item.Title = title
		item.Description = desc
		item.MusicUrl  = music_url
		item.HQMusicUrl  = hq_music_url
	    	item
	end

	def item(title, desc, pic_url, link_url)
		item = Item.new
		item.Title = title
		item.Description = desc
		item.PicUrl = pic_url
		item.Url  = link_url
		item
	end

end
