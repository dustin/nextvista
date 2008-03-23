# Settings specified here will take precedence over those in config/environment.rb

require 'syslog_logger'
require 'heywatch'

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
config.logger = SyslogLogger.new

UPLOAD_DIR='/data/web/purple-virts/media/nextvista/incoming'

BEANSTALK_SERVERS=%w(purple:11300)

unless ENV['HEYWATCH_USER'].blank?
   HeyWatch::Base::establish_connection! :login => ENV['HEYWATCH_USER'],
    :password => ENV['HEYWATCH_PASS']
end

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false
