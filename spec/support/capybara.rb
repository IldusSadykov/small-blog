require "capybara/poltergeist"

Capybara.register_driver :poltergeist do |app|
  options = {
    phantomjs_options: ["--ssl-protocol=any", "--ignore-ssl-errors=yes"],
    inspector: false,
    js_errors: true,
    timeout: 240
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.configure do |config|
  config.match = :prefer_exact
  config.javascript_driver = :poltergeist
  config.asset_host = "http://#{ENV.fetch('HOST')}"
end
