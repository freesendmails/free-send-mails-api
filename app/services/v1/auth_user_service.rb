require 'base58'
require 'securerandom'

module V1
  class AuthUserService
    attr_reader :email

    def initialize(params)
      @email = params

      @error_url = 'http://www.freesendmails.com/authentication-user-error'
      @success_url = 'http://www.freesendmails.com/authentication-user-success'
      @success_url_authenticated = 'http://www.freesendmails.com/authentication-user-success-authenticated'
    end

    def user_authenticated
      if get_document_firebase.success?
        return exist_user_authenticated(get_document_firebase.body)
      else
        return @error_url
      end
    end

    def authentication
      @token = Base58.encode(SecureRandom.uuid.delete('-').to_i(16))
      response = new_instance_firebase.push("users_authenticated", {
        :email => @email,
        :confirmated => false,
        :created => Date.today,
        :priority => 1,
        :token => @token
      })
      if response.success?
        authentication_mail_mailer(@token)
        return @success_url
      else
        return @error_url
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
                return @success_url_authenticated
              else
                return @error_url
              end
            end
          end
        end

        return @error_url
      end

      def authentication_mail_mailer token
        AuthenticationMailMailer.authentication_mail_mailer('mail@freesendmails.com',
          "Confirmation E-mail",
          @email, "https://localhost:3000/v1/authentication/#{token}").deliver_later
      end

      def get_document_firebase
        return new_instance_firebase.get("users_authenticated")
      end

      def update_document_firebase id, response
        response["confirmated"] = true
        return new_instance_firebase.update("users_authenticated/#{id}", response)
      end

      def new_instance_firebase
        return Firebase::Client.new(ENV["SECRET_URL_FIRE_BASE"], ENV["SECRET_KEY_FIRE_BASE"])
      end
  end
end
