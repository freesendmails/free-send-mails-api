require 'base58'
require 'securerandom'

module V1
  class AuthUserService
    attr_reader :email

    ERROR_URL = 'http://www.freesendmails.com/authentication-user-error'.freeze
    SUCCESS_URL = 'http://www.freesendmails.com/authentication-user-success'.freeze
    SUCCESS_URL_AUTHENTICATED = 'http://www.freesendmails.com/authentication-user-success-authenticated'.freeze

    def initialize(email)
      @email = email
    end

    def user_authenticated
      return ERROR_URL unless document_firebase.success?
      exist_user_authenticated(document_firebase.body)
    end

    def authentication
      token = Base58.encode(SecureRandom.uuid.delete('-').to_i(16))
      response = firebase_client.push('users_authenticated',
                                      email: email,
                                      confirmated: false,
                                      created: Date.today,
                                      priority: 1,
                                      token: token)

      return ERROR_URL unless response.success?

      authentication_mail_mailer(token)
      SUCCESS_URL
    end

    def validation_token_authentication(token)
      return false unless document_firebase.success?
      validated_token_authentication(document_firebase.body, token)
    end

    private

    def exist_user_authenticated(response)
      response&.each do |_, resp|
        return true if resp['email'] == email && resp['confirmated']
      end

      false
    end

    def validated_token_authentication(response, token)
      return ERROR_URL unless response

      response.each do |key, resp|
        if resp['token'] == token
          return SUCCESS_URL_AUTHENTICATED if update_document_firebase(key, resp).success?
          return ERROR_URL
        end
      end
    end

    def authentication_mail_mailer(token)
      AuthenticationMailMailer.authentication_mail_mailer(
        'mail@freesendmails.com',
        'Confirmation E-mail',
        email,
        "http://www.api.freesendmails.com/v1/authentication/#{token}"
      ).deliver_later
    end

    def document_firebase
      firebase_client.get('users_authenticated')
    end

    def update_document_firebase(id, response)
      response['confirmated'] = true
      firebase_client.update("users_authenticated/#{id}", response)
    end

    def firebase_client
      @firebase_client ||= Firebase::Client.new(
        Rails.application.secrets.secret_url_fire_base,
        Rails.application.secrets.secret_key_fire_base
      )
    end
  end
end
