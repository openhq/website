require 'hobbit'
require 'hobbit/contrib'
require 'rack/protection'
require 'rack/flash'
require 'dotenv'
require 'mailgun'

Dotenv.load

class App < Hobbit::Base
  include Hobbit::ErrorHandling
  include Hobbit::Render
  include Hobbit::Session
  use Rack::Session::Cookie, secret: ENV["SESSION_SECRET"]
  use Rack::Protection
  use Rack::Protection::AuthenticityToken
  use Rack::Flash, :accessorize => [:notice, :error]

  def flash
    env['x-rack.flash']
  end

  error Mailgun::Error do
    exception = env['hobbit.error']
    flash[:error] = exception.message
    response.redirect "/"
  end

  get '/' do
    render "home"
  end

  post '/newsletter' do
    subscriber = request.params["email"]
    mailgun = Mailgun(api_key: ENV["MAILGUN_API_KEY"])
    mailgun.list_members("newsletter@#{ENV["MAILGUN_DOMAIN"]}").add(subscriber)

    flash[:notice] = "Thanks for signing up! We’ll be in touch soon."
    response.redirect "/"
  end
end
