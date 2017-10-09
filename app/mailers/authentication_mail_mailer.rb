class AuthenticationMailMailer < ApplicationMailer
  def authentication_mail_mailer(to_email, subject, email, url_confirm_email)
    @to_email = to_email
    @email = email
    @url_confirm_email = url_confirm_email
    mail(to: @email, subject: subject)
  end
end
