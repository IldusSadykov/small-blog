class UserMailer < ActionMailer::Base
  def payment_failed(user_id, message)
    @user = User.find(user_id)
    mail to: @user.email,
      from: "admin@example.com",
      subject: "Payment failed!"
  end
end
