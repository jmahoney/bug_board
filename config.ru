require 'dashing'

REDMINE_ENDPOINT = ENV['BUG_BOARD_REDMINE_ENDPOINT']
REDMINE_API_KEY = ENV['BUG_BOARD_REDMINE_API_KEY']
BUG_BOARD_AUTH_TOKEN = ENV['BUG_BOARD_BUG_BOARD_AUTH_TOKEN']
BUG_TRACKER=ENV['BUG_BOARD_BUG_TRACKER']
FEATURE_TRACKER=ENV['BUG_BOARD_FEATURE_TRACKER']
CR_TRACKER=ENV['BUG_BOARD_CR_TRACKER']
URGENT_PRIORITY=ENV['BUG_BOARD_URGENT_PRIORITY']
HIGH_PRIORITY=ENV['BUG_BOARD_HIGH_PRIORITY']
NEW_STATUS=ENV['BUG_BOARD_NEW_STATUS']
OPEN_STATUS=ENV['BUG_BOARD_OPEN_STATUS']
TRIAGED_FIELD=ENV['BUG_BOARD_TRIAGED_FIELD']

require 'redmine_weary'
RedmineWeary.configure do |config|
  config.endpoint = REDMINE_ENDPOINT
  config.api_key = REDMINE_API_KEY
end
require 'redmine_weary/client'


configure do
  set :auth_token, BUG_BOARD_AUTH_TOKEN

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application