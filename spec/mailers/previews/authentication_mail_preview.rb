# Preview all emails at
# http://localhost:3000/rails/mailers/authentication_mail
class AuthenticationMailPreview < ActionMailer::Preview
  def authentication_mail_mailer
    AuthenticationMailMailer.authentication_mail_mailer('destmock@mail.com',
                                                        'Preview Subject',
                                                        'freemails@mail.com',
                                                        'confirmationURL.com')
  end
end
