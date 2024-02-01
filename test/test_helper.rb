require 'minitest/autorun'
require 'active_support'
require 'webmock/minitest'
require 'shoulda'
require_relative '../lib/livestorm_api.rb'
require 'factory_bot_rails'

FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
FactoryBot.find_definitions