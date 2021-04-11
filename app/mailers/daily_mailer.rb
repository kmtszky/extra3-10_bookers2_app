class DailyMailer < ApplicationMailer
  def daily_send_mail(user)
    @user = user
    mail(to: @user.email, subject: '【Bookers2】daily mail !')
  end
end
