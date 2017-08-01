class V1::MailsController < ApplicationController

  def create_mail
    begin

      #to mail
      @to_email = params[:to]
      #name
      @name = params[:_name]
      #email
      @email = params[:_email]
      #message email
      @message = params[:_message]
      #subject
      @subject = params[:_subject] ? params[:_subject] : 'Email send by - Free Send Mails'
      #url sucess
      @url_success = params[:_url_success]

      #send mail
      SendMailMailer.send_mail(@to_email, @subject, @email, @message).deliver_later

      redirect_to @url_success

    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

end
