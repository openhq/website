source "https://rubygems.org"

ruby "2.5.1"

gem "rack"
gem "hobbit"
gem "tilt"
gem "erubis"
gem "hobbit-contrib", require: "hobbit/contrib"
gem "rack-protection"
gem "rack-flash3"
gem "dotenv"
gem "sass"
gem "sprockets"
gem "sprockets-helpers"
gem "puma"

# Signing up to the newsletter
gem 'mailchimp-api', require: 'mailchimp'

group :test do
  gem "rspec"
  gem "rack-test"
  gem "rubocop"
end

group :development do
  gem 'capistrano',  '~> 3.4.0'
  gem 'capistrano-rails', '~> 1.1.3'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-passenger', '~> 0.1.1'
end
