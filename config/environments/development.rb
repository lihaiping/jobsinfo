JobsInfo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.server_host = ""

  config.weixin_app_id = "wxbba232f31eef54aa"

  config.weixin_app_secret = "ffe6cfa7c842758e54836387f14fb695"

  config.weixin_token = "852bdb7fa7364bc2d97ed25049158d09"

  config.weixin_send_path = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="

  config.subscribe_content =  "您好，欢迎关注 Jobs Info！"
end
