module FeatureHelper
  def app
    App
  end
end

require 'rack/test'
RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :feature
  config.include FeatureHelper, type: :feature
end
