class UserMailer < ActionMailer::Base
  def payment_failed(user_id, message)
    @user = User.find(user_id)
    @message = message
    mail(
      to: @user.email,
      from: "admin@example.com",
      subject: "Your most recent invoice payment failed"
    )
  end
end
