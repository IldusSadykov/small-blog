module PayStripeHelpers
  # rubocop:disable AbcSize
  def pay_stripe(card_number)
    sleep(0.7)
    within_frame "stripe_checkout_app" do
      page.driver.browser.all(:xpath, '//input[@type="email"]')[0].send_keys "user@example.com"

      page.driver.browser.all(:xpath, '//input[@placeholder="Card number"]')[0].send_keys(card_number)

      page.driver.browser.all(:xpath, '//input[@placeholder="MM / YY"]')[0].send_keys "5"
      page.driver.browser.all(:xpath, '//input[@placeholder="MM / YY"]')[0].send_keys "18"
      page.driver.browser.all(:xpath, '//input[@placeholder="CVC"]')[0].send_keys "123"

      find("button[type='submit']").click
    end
  end
  # rubocop:enable AbcSize
end

RSpec.configure do |config|
  config.include PayStripeHelpers, type: :feature
end
