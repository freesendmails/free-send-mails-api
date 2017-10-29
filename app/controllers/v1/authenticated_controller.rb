require 'validation_contract'

module V1
  class AuthenticatedController < ApplicationController
    def authentication
      email = authenticated_params[:email]
      valition_contract = ValidationContract::Validations.new
      valition_contract.email(email, "This e-mail #{email} is inválid")

      if !valition_contract.is_valid
        render json: { success: false, errors: valition_contract.erros }, status: 200
      elsif !V1::AuthUserService.new(email).user_authenticated
        redirect_to V1::AuthUserService.new(email).authentication
      else
        redirect_to 'http://www.freesendmails.com/authentication-user-error'
      end
    end

    def authentication_url
      token_authentication = params[:token_authentication]
      redirect_to V1::AuthUserService.new('').validation_token_authentication(token_authentication)
    end

    private

    def authenticated_params
      {
        email: params[:to]
      }
    end

  end
end
