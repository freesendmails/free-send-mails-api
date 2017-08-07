class V1::MailsController < ApplicationController

  #Process create new mail
  def create_mail
    #Using MailService, return url success or error
    redirect_to = MailService.new(to_email: params[:to],
      name: params[:_name],
      email: params[:_email],
      message: params[:_message],
      subject: params[:_subject],
      url_success: params[:_url_success]).new_mail
    redirect_to 'http://www.freesendmails.com/test-mail-success'
  end

end
