require 'validation_contract'

module V1
  class AuthenticatedController < ApplicationController
    def authentication
      valition_contract = ValidationContract::Validations.new
      valition_contract.is_email(authenticated_params[:email], "This e-mail #{authenticated_params[:email]} is inválid")

      if !valition_contract.is_valid
        render json: {success: false, errors: valition_contract.erros}, status: 200
      else
        if !V1::AuthUserService.new(authenticated_params[:email]).user_authenticated
          redirect_to V1::AuthUserService.new(authenticated_params[:email]).authentication
        else
          redirect_to 'http://youtube.com'
        end
      end
    end

    private

    def authenticated_params
      {
        email: params[:to]
      }
    end
  end
end
