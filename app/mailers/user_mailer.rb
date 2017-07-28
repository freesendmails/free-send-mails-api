class UserMailer < ApplicationMailer
  default from: 'ricardograssi91@gmail.com'
  
  def welcome_email(to_email)
    mail(to: to_email, subject: 'Welcome to My Awesome Site')
  end
end
