class Api::V1::MailsController < ApplicationController

  def create_mail
    begin   

      @to_email = params[:to]         
      @name = params[:_name]
      @email = params[:_email]
      @message = params[:_message]
      @url_success = params[:_url_success]
    
      #send mail
      UserMailer.welcome_email(@to_email).deliver_later
      
      redirect_to @url_success
      
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

end
