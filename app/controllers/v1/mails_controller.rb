module V1
  class MailsController < ApplicationController
    def create_mail
      redirect_to V1::MailService.new(mail_params).send_and_redirect
    end

    private

    def mail_params
      {
        to_email: params[:to],
        name: params[:_name],
        email: params[:_email],
        message: params[:_message],
        subject: params[:_subject],
        url_success: params[:_url_success]
      }
    end
  end
end
