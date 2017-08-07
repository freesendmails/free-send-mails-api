class V1::MailService
  #set params
  def initialize(params)
    @to_email = params[:to_email]
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @subject = params[:subject] ? params[:subject] : 'Email send by - Free Send Mails'
    @url_success = params[:url_success]

    @redirect_to_error = 'http://www.freesendmails.com/test-mail-error'
    @redirect_to_success = 'http://www.freesendmails.com/test-mail-success'
  end

  #new_mail
  def new_mail
    begin
      if validation_mail
        return @redirect_to_error
      else
        send_mail
        return redirect_to_success
      end
    rescue Exception => errors
      return @redirect_to_error
    end
  end

  private

    #Validation of required fields
    def validation_mail
      return @to_email == "" || @name == "" || @email == "" || @message == ""
    end

    #Send mail
    def send_mail
      SendMailMailer.send_mail(@to_email, @subject, @email, @message).deliver_later
    end

    #redirect before send mail
    def redirect_to_success
      unless @url_success == nil
        @url_success = @redirect_to_success
      end

      return @url_success
    end
end
