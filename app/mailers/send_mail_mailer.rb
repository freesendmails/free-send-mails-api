class SendMailMailer < ApplicationMailer

  def send_mail(to_email, subject)
    mail(to: to_email, subject: subject)
  end

end
