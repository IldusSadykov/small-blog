module PayStripeHelpers
  def pay_stripe
    sleep(0.7)
    within_frame "stripe_checkout_app" do
      page.driver.browser.all(:xpath, '//input[@type="email"]')[0].send_keys "user@example.com"

      4.times { page.driver.browser.all(:xpath, '//input[@placeholder="Card number"]')[0].send_keys("4242") }

      page.driver.browser.all(:xpath, '//input[@placeholder="MM / YY"]')[0].send_keys "5"
      page.driver.browser.all(:xpath, '//input[@placeholder="MM / YY"]')[0].send_keys "18"
      page.driver.browser.all(:xpath, '//input[@placeholder="CVC"]')[0].send_keys "123"

      find("button[type='submit']").click
    end
  end
end

RSpec.configure do |config|
  config.include PayStripeHelpers, type: :feature
end
