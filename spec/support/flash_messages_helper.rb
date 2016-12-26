module FlashMessagesHelpers
  def alert_box_text(type)
    find(".alert-box.#{type}", wait: 5)
  end
end

RSpec.configure do |config|
  config.include FlashMessagesHelpers, type: :feature
end
