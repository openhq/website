require 'sprockets'
require 'sprockets-helpers'

module AssetsHelper
  def self.included(target)
    sprockets = Sprockets::Environment.new
    sprockets.append_path 'assets/javascripts'
    sprockets.append_path 'assets/stylesheets'

    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix      = "/assets"
      config.digest      = true
      config.public_path = "/public"

      # Force to debug mode in development mode
      # Debug mode automatically sets
      # expand = true, digest = false, manifest = false
      config.debug       = true if ENV['RACK_ENV'] == "development"
    end

    target.send(:include, Sprockets::Helpers)

    target.send(:map, '/assets') do
      run sprockets
    end
  end
end
