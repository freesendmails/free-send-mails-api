module V1
  class MailService
    attr_reader :to_email, :name, :email, :message, :subject, :user_provided_url, :success_url, :error_url

    def initialize(params)
      @to_email = params[:to_email]
      @name = params[:name]
      @email = params[:email]
      @message = params[:message]
      @subject = params[:subject] || 'Email sent by - Free Send Mails'
      @user_provided_url = params[:url_success]

      @error_url = 'http://www.freesendmails.com/test-mail-error'
      @success_url = 'http://www.freesendmails.com/test-mail-success'
    end

    def send_and_redirect
      return error_url if validation_mail
      send_mail
      return redirect_to_success
    rescue StandardError
      return error_url
    end

    private

    def validation_mail
      [to_email, name, email, message].map(&:blank?).select { |blank| blank }.any?
    end

    def send_mail
      SendMailMailer.send_mail(to_email, subject, email, message).deliver_later
    end

    def redirect_to_success
      user_provided_url || success_url
    end
  end
end
