class Api::V1::MailsController < ApplicationController
  
  def create
    begin      
      @email = params[:email]
      UserMailer.welcome_email(@email).deliver_later

      render json: {success: params[:id]}, status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

end
