module V1
  class AuthUserService
    attr_reader :email

    def initialize(params)
      @email = params

      @error_url = 'http://www.freesendmails.com/test-mail-error'
      @success_url = 'http://www.freesendmails.com/test-mail-success'
    end

    def user_authenticated
      firebase = Firebase::Client.new(Rails.application.secrets.secret_url_fire_base, Rails.application.secrets.secret_key_fire_base)
      response = firebase.get("users_authenticated")
      return exist_user_authenticated(JSON.parse(response.body.to_json)) if response.success?
    end

    def authentication
      firebase = Firebase::Client.new(Rails.application.secrets.secret_url_fire_base, Rails.application.secrets.secret_key_fire_base)
      response = firebase.push("users_authenticated", { :email => @email, :confirmated => false, :created => Date.today, :priority => 1 })
      if response.success?
        authentication_mail_mailer
        return @success_url
      else
        return @error_url
      end
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

      def authentication_mail_mailer
        AuthenticationMailMailer.authentication_mail_mailer('mail@freesendmails.com', "Confirmation E-mail", @email, '123123').deliver_later
      end
  end
end
