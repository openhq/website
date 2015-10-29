$LOAD_PATH << File.expand_path('../', __FILE__)
require 'bundler'
Bundler.setup :default, ENV['RACK_ENV'].to_sym

require 'erubis'
require 'hobbit'
require 'hobbit/contrib'
require 'rack/protection'
require 'rack/flash'
require 'mailchimp'
require 'dotenv'
require_relative 'helpers/assets_helper'

# Loads environment variables fom .env file
Dotenv.load if ENV["RACK_ENV"] != "test"

class App < Hobbit::Base
  include Hobbit::ErrorHandling
  include Hobbit::Render
  include Hobbit::Session
  include AssetsHelper
  use Rack::Session::Cookie, secret: ENV["SESSION_SECRET"]
  use Rack::Protection
  use Rack::Protection::AuthenticityToken
  use Rack::Flash, accessorize: [:notice, :error]

  def flash
    env['x-rack.flash']
  end

  error Mailchimp::Error do
    exception = env['hobbit.error']
    flash[:error] = exception.message
    response.redirect "/"
  end

  # Temp until site is ready to go live
  get "/robots.txt" do
    response["Content-Type"] = "text/plain"
    "User-agent: *\nDisallow: /"
  end

  get '/' do
    render("home", {}, default_encoding: "UTF-8")
  end

  post '/newsletter' do
    subscriber = request.params["email"]
    mailchimp  = Mailchimp::API.new(ENV.fetch('MAILCHIMP_API_KEY'))
    list_id    = ENV.fetch('MAILCHIMP_LIST_ID')

    resp = mailchimp.lists.subscribe(list_id, email: subscriber)
    p resp

    flash[:notice] = "Thanks for signing up! We’ll be in touch soon."
    response.redirect "/"
  end
end
