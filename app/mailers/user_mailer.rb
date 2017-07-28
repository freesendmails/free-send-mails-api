class UserMailer < ApplicationMailer
  default from: 'ricardograssi91@gmail.com'
  
  def welcome_email(email)
    mail(to: email, subject: 'Welcome to My Awesome Site')
  end
end
