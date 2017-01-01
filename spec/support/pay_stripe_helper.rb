module PayStripeHelpers
  def pay_stripe(card_number)
    sleep(5)
    within_frame("stripe_checkout_app") do
      find("input[type='email']").set("user@example.com")
      find("input[placeholder='Card number']").set(card_number)
      find("input[placeholder='MM / YY']").set "5 / 18"
      find("input[placeholder='CVC']").set "123"
      find("button[type='submit']").trigger("click")
    end
  end
end

RSpec.configure do |config|
  config.include PayStripeHelpers, type: :feature
end
