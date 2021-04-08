class ThanxMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def thanx_mail
   @user = params[:user]
   mail(to: @user.email, subject: 'welcome to bookers2! Thenkx for your registration.')
  end
end
