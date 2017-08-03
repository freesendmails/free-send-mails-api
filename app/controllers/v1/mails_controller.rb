class V1::MailsController < ApplicationController

  def create_mail
    begin

      if params[:to] == "" || params[:_name] == "" || params[:_email] == "" || params[:_message] == ""
        redirect_to 'http://www.freesendmails.com/test-mail-error'
      else
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

        if @url_success != nil
          redirect_to @url_success
        else
          redirect_to 'http://www.freesendmails.com/test-mail-success'
        end
      end

    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

end
