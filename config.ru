require 'dashing'

REDMINE_ENDPOINT = ENV['REDMINE_ENDPOINT']
REDMINE_API_KEY = ENV['REDMINE_API_KEY']
BUG_BOARD_AUTH_TOKEN = ENV['BUG_BOARD_AUTH_TOKEN']


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