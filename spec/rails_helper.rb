ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Nós adicionamos o FFaker aqui
require 'ffaker'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # habilita o Jbuilder nos testes
  config.render_views = true
  # Nós incluimos o Factory Girl Rails aqui
  config.include FactoryGirl::Syntax::Methods
  # Aqui nos colocamos os Helpers do Devise para nos ajudar na hora de passar o token
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
