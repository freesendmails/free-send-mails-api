require 'rails_helper'

RSpec.describe V1::MailsController, type: :controller do
  describe "CREATE_MAILS #create_mails" do
    before do
      request.env['HTTP_ACCEPT'] = 'application/json'
    end

    context 'when the to field is invalid' do
      it do
        body_request = {
          to: 'invalid-email',
          _email: 'valid@email.com',
        }

        post :create_mail, params: body_request

        expect(response.status).to be(400)
      end
    end

    context 'when the _email field is invalid' do
      it do
        body_request = {
           to: 'valid@email.com',
          _email: 'invalid-email',
        }

        post :create_mail, params: body_request

        expect(response.status).to be(400)
      end
    end

    context 'when the user is not authenticated' do
      let(:auth_user_service) { instance_double('V1::AuthUserService', user_authenticated: false) }
      before do
        allow(V1::AuthUserService).to receive(:new).and_return(auth_user_service)
      end

      it 'redirects to authentication page' do
        body_request = {
          to: 'valid@email.com',
          _name: 'Test my name',
          _email: 'mail@freesendmails.com',
          _message: 'This is test mail',
        }

        post :create_mail, params: body_request

        expect(response).to redirect_to('http://www.freesendmails.com/authentication-user')
      end
    end

    context 'when the email is valid and user is authenticated' do
      let(:auth_user_service) { instance_double('V1::AuthUserService', user_authenticated: true) }
      let(:mail_service) { instance_double('V1::MailService', send_and_redirect: 'http://eveything-works') }

      before do
        allow(V1::AuthUserService).to receive(:new).and_return(auth_user_service)
        allow(V1::MailService).to receive(:new).and_return(mail_service)
      end

      it 'sends the e-mail' do
        body_request = {
          to: 'valid@email.com',
          _name: 'Test my name',
          _email: 'mail@freesendmails.com',
          _message: 'This is test mail',
        }

        post :create_mail, params: body_request

        expect(response).to redirect_to('http://eveything-works')
      end
    end
  end
end
