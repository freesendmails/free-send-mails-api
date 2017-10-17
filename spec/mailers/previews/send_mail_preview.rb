# Preview all emails at http://localhost:3000/rails/mailers/send_mail
class SendMailPreview < ActionMailer::Preview
  def send_mail
    SendMailMailer.send_mail('destmock@mail.com',
                             'Preview Subject',
                             'freemails@mail.com',
                             'This is the full message')
  end
end
