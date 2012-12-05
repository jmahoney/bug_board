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
DEVELOPER_IDS=ENV['BUG_BOARD_DEVELOPER_IDS']
PROJECT_IDS=ENV['BUG_BOARD_PROJECT_IDS']
AUTH_USERNAME=ENV['BUG_BOARD_AUTH_USERNAME']
AUTH_PASSWORD=ENV['BUG_BOARD_AUTH_PASSWORD']

require 'redmine_weary'
RedmineWeary.configure do |config|
  config.endpoint = REDMINE_ENDPOINT
  config.api_key = REDMINE_API_KEY
end
require 'redmine_weary/client'


configure :production do
  use Rack::SSL
end

configure do
  set :auth_token, BUG_BOARD_AUTH_TOKEN

  helpers do
    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [AUTH_USERNAME, AUTH_PASSWORD]
    end
    
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
     
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Heyyyy")
        throw(:halt, [401, "Not authorized\n"])
      end
    end
    
    
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application