module PayStripeHelpers
  # rubocop:disable AbcSize
  def pay_stripe(card_number)
    sleep(10)
    browser = page.driver.browser
    within_frame(find(".stripe_checkout_app", wait: 2)) do
    #ifram = browser.window_handles.last
    #browser.switch_to.window(ifram) do
      #puts browser.all(:xpath, '//input[@type="email"]')
      #browser.find_elements(:css, 'input[type="email"]')
      #puts "******#{page.driver.browser.all(:xpath, '//input[@type="email"]')[0]}"
      browser.all(:xpath, '//input[@type="email"]')[0].send_keys "user@example.com"
      browser.all(:xpath, '//input[@placeholder="Card number"]')[0].send_keys(card_number)
      browser.all(:xpath, '//input[@placeholder="MM / YY"]')[0].send_keys "5"
      browser.all(:xpath, '//input[@placeholder="MM / YY"]')[0].send_keys "18"
      browser.all(:xpath, '//input[@placeholder="CVC"]')[0].send_keys "123"
      find("button[type='submit']").click
    end
  end
  # rubocop:enable AbcSize
end

RSpec.configure do |config|
  config.include PayStripeHelpers, type: :feature
end
