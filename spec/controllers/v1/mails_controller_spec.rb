require 'rails_helper'
require 'byebug'

RSpec.describe V1::MailsController, type: :controller do

  describe "CREATE_MAILS #create_mails" do
    before do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    it "send mail" do
      post :create_mail,
        params: {
          to_email: 'mail@freesendmails.com',
          name: 'Email-Test', email: 'mail@freesendmails.com',
          message: 'This is test mail',
          subject: 'Test Mail Controller',
          url_success: 'https://www.freesendmails.com'
        }
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
