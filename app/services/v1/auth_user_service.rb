require 'base58'
require 'securerandom'

module V1
  class AuthUserService
    attr_reader :email

    ERROR_URL = 'http://www.freesendmails.com/authentication-user-error'
    SUCCESS_URL = 'http://www.freesendmails.com/authentication-user-success'
    SUCCESS_URL_AUTHENTICATED = 'http://www.freesendmails.com/authentication-user-success-authenticated'

    def initialize(email)
      @email = email
    end

    def user_authenticated
      if get_document_firebase.success?
        return exist_user_authenticated(get_document_firebase.body)
      else
        return ERROR_URL
      end
    end

    def authentication
      token = Base58.encode(SecureRandom.uuid.delete('-').to_i(16))
      response = firebase_client.push("users_authenticated", {
        :email => @email,
        :confirmated => false,
        :created => Date.today,
        :priority => 1,
        :token => token
      })
      if response.success?
        authentication_mail_mailer(token)
        return SUCCESS_URL
      else
        return ERROR_URL
      end
    end

    def validation_token_authentication token
      if get_document_firebase.success?
        return validated_token_authentication(get_document_firebase.body, token)
      else
        return false
      end
    end

    private
      def exist_user_authenticated response
        if response != nil
          response.each do |key, resp|
            if resp["email"] == @email && resp["confirmated"]
              return true
            end
          end
        end

        return false
      end

      def validated_token_authentication response, token
        if response != nil
          response.each do |key, resp|
            if resp["token"] == token
              if update_document_firebase(key, resp).success?
                return SUCCESS_URL_AUTHENTICATED
              else
                return ERROR_URL
              end
            end
          end
        end

        return ERROR_URL
      end

      def authentication_mail_mailer token
        AuthenticationMailMailer.authentication_mail_mailer('mail@freesendmails.com',
          "Confirmation E-mail",
          @email, "http://www.api.freesendmails.com/v1/authentication/#{token}").deliver_later
      end

      def get_document_firebase
        return firebase_client.get("users_authenticated")
      end

      def update_document_firebase id, response
        response["confirmated"] = true
        return firebase_client.update("users_authenticated/#{id}", response)
      end

      def firebase_client
        @firebase_client ||= Firebase::Client.new(Rails.application.secrets.secret_url_fire_base, Rails.application.secrets.secret_key_fire_base)
      end
  end
end
