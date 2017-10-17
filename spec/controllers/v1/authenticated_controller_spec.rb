require 'rails_helper'

RSpec.describe V1::AuthenticatedController, type: :controller do
  describe '#authentication' do

    context 'when the to email is invalid' do
      let(:invalid_email) { 'abc@xyz.' }

      it 'shows json error response' do
        post :authentication, params: { to: invalid_email }

        response_json = JSON.parse response.body

        expect(response.status).to be(200)
        expect(response_json['success']).to be_falsey
        expect(response_json['errors'].to_s).to include('This e-mail abc@xyz. is inválid')
      end
    end

    context 'when the to email is valid' do
      context 'user exists in Firebase'do
        context 'user is confirmed', vcr: { cassette_name: 'firebase/existing_confirmed_user' } do
          let(:confirm_email) { 'abc@example.com' }

          before do
            add_confirmed_user_to_firebase(confirm_email)
          end

          it 'redirects to authentication error page if a confirmed user tries to authenticate' do
            post :authentication, params: { to: confirm_email }

            expect(response).to redirect_to('http://www.freesendmails.com/authentication-user-error')
          end
        end

        context 'user is not confirmed', vcr: { cassette_name: 'firebase/existing_unconfirmed_user' } do
          let(:user_email) { 'xyz@example.com' }

          before do
            add_unconfirmed_user_to_firebase(user_email)
          end

          it 'adds the user to Firebase again' do
            post :authentication, params: { to: user_email }

            expect(firebase_user_emails.count{|x| x == user_email}).to be(2)
            expect(response).to redirect_to('http://www.freesendmails.com/authentication-user-success')
          end
        end
      end

      context 'user do not exist in firebase', vcr: { cassette_name: 'firebase/add_user' } do
        let(:new_email) { 'abcxyz@example.com' }

        it 'adds the user to Firebase and redirects to authentication success page' do
          post :authentication, params: { to: new_email }

          expect(firebase_user_emails).to include(new_email)
          expect(response).to redirect_to('http://www.freesendmails.com/authentication-user-success')
        end
      end
    end
  end

  describe 'user confirmation #authentication_url' do
    let(:user_email) { 'qwerty@example.com' }
    let(:user_token) { 'token1234' }

    it 'confirms user in Firebase', vcr: { cassette_name: 'firebase/confirm_user' } do
      add_unconfirmed_user_to_firebase(user_email, user_token)

      get :authentication_url, params: { token_authentication: user_token }

      firebase_user = firebase_find_users(user_email).first

      expect(firebase_user['confirmated']).to be_truthy
      expect(response).to redirect_to('http://www.freesendmails.com/authentication-user-success-authenticated')
    end
  end
end
