class SendMailMailer < ApplicationMailer

  def send_mail(to_email, subject, email, message)
    @to_email = to_email
    @email = email
    @message = message
    mail(to: to_email, subject: subject)
  end

end
