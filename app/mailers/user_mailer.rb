class UserMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to My App")
  end

  def send_to_all_users
    emails = User.pluck(:email)
    mail(to: emails, subject: "Hello from Mailcatcher")
  end
end
