require 'base58'
require 'securerandom'

module V1
  class AuthUserService
    attr_reader :email

    def initialize(params)
      @email = params

      @error_url = 'http://www.freesendmails.com/test-mail-error'
      @success_url = 'http://www.freesendmails.com/test-mail-success'
    end

    def user_authenticated
      return exist_user_authenticated(JSON.parse(get_document_firebase.body.to_json)) if get_document_firebase.success?
    end

    def authentication
      @token = Base58.encode(SecureRandom.uuid.delete('-').to_i(16))
      firebase = Firebase::Client.new(Rails.application.secrets.secret_url_fire_base, Rails.application.secrets.secret_key_fire_base)
      response = firebase.push("users_authenticated", {
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
      return valideted_token_authentication(JSON.parse(get_document_firebase.body.to_json), token) if get_document_firebase.success?
    end

    private
      def exist_user_authenticated response
        if response != nil
          response.each do |resp|
            if resp[1]['email'] == @email
              return true
            end
          end
        end

        return false
      end

      def valideted_token_authentication response, token
        if response != nil
          response.each do |resp|
            byebug
            if resp[1]['token'] == token
              return true
            end
          end
        end

        return false
      end

      def authentication_mail_mailer token
        AuthenticationMailMailer.authentication_mail_mailer('mail@freesendmails.com',
          "Confirmation E-mail",
          @email, "https://localhost:3000/v1/authentication/#{token}").deliver_later
      end

      def get_document_firebase
        firebase = Firebase::Client.new(Rails.application.secrets.secret_url_fire_base, Rails.application.secrets.secret_key_fire_base)
        return firebase.get("users_authenticated")
      end
  end
end
