source "https://rubygems.org"

ruby "2.3.1"

gem "rails", "4.2.7.1"
gem "pg"

# assets
gem "autoprefixer-rails"
gem "coffee-rails"
gem "foundation-icons-sass-rails"
gem "foundation-rails", "~> 6.2.4.0"
gem "jquery-rails"
gem "sass-rails", "~> 5.0.0"
gem "skim", "~> 0.10.0"
gem "therubyracer", platforms: :ruby
gem "uglifier", ">= 2.7.2"

# views
gem "active_link_to"
gem "metamagic"
gem "simple_form"
gem "slim"

# all other gems
gem "decent_decoration"
gem "decent_exposure"
gem "devise"
gem "draper"
gem "flamegraph"
gem "google-analytics-rails"
gem "health_check"
gem "interactor"
gem "kaminari"
gem "memory_profiler"
gem "puma"
gem "pundit"
gem "rack-canonical-host"
gem "rack-mini-profiler", ">= 0.10.1", require: false
gem "responders"
gem "rollbar", "~> 2.13.2"
gem "seedbank"
gem "stackprof"
gem "friendly_id", "~> 5.1.0"
gem "active_model_serializers"
gem "geocoder"
gem "stripe"
gem "rake", "< 11.0"

group :staging, :production do
  gem "newrelic_rpm"
  gem "rails_stdout_logging"
  gem "dalli"
  gem "memcachier"
end

group :staging do
  gem "factory_girl_rails"
  gem "faker"
end

group :test do
  gem "capybara"
  gem "capybara-webkit"
  gem "selenium-webdriver"
  gem "codeclimate-test-reporter", require: false
  gem "database_cleaner"
  gem "email_spec"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "webmock", require: false
  gem "stripe-ruby-mock", "~> 2.3.1", require: "stripe_mock"
end

group :development, :test do
  gem "awesome_print"
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "byebug"
  gem "coffeelint"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "faker"
  gem "fuubar", "~> 2.0.0.rc1"
  gem "jasmine", "> 2.0"
  gem "jasmine-jquery-rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.0"
  gem "rubocop", "~> 0.43.0", require: false
  gem "rubocop-rspec", require: false
  gem "scss_lint", require: false
  gem "slim_lint", require: false
end

group :development do
  gem "bullet"
  gem "foreman", require: false
  gem "letter_opener"
  gem "quiet_assets"
  gem "rails-erd"
  gem "slim-rails"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console", "~> 2.0"
end
