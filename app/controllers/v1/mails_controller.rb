require 'validation_contract'

module V1
  class MailsController < ApplicationController
    def create_mail
      valition_contract = ValidationContract::Validations.new
      valition_contract.is_email(mail_params[:to_email], "This e-mail to_email is inválid")
      valition_contract.is_email(mail_params[:email], "This e-mail email is inválid")

      if !valition_contract.is_valid
        render json: {success: false, errors: valition_contract.erros}, status: 200
      else
        if V1::AuthUserService.new(mail_params[:to_email]).user_authenticated
          redirect_to V1::MailService.new(mail_params).send_and_redirect
        else
          redirect_to 'http://youtube.com'
        end
      end
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
