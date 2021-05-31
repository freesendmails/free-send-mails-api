require 'rails_helper'

RSpec.describe V1::MailService do
  include ActiveJob::TestHelper
  let(:valid_params) do
    {
      to_email: 'receive@mail.com',
      name: 'receive',
      email: 'sender@mail.com',
      message: 'message'
    }
  end

  let(:invalid_params) do
    {
      to_email: '',
      name: '',
      email: '',
      message: ''
    }
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
    ActiveJob::Base.queue_adapter = :sidekiq
  end

  describe '#send_and_redirect' do
    subject { mail_service.send(:send_and_redirect) }

    context 'when params is valid' do
      let(:mail_service) { V1::MailService.new(valid_params) }

      it 'return to success_url' do
        expect(subject).to eq 'http://www.freesendmails.com/test-mail-success'
      end

      it 'send mail and action mailer size increment 1' do
        ActiveJob::Base.queue_adapter = :test

        perform_enqueued_jobs do
          expect do
            subject
          end.to change { ActionMailer::Base.deliveries.size }.by(1)
        end
      end
    end

    context 'when params is invalid' do
      let(:mail_service) { V1::MailService.new(invalid_params) }

      it 'return to error_url' do
        expect(subject).to eq 'http://www.freesendmails.com/test-mail-error'
      end

      it 'not send mail and action mailer size is 0' do
        ActiveJob::Base.queue_adapter = :test

        perform_enqueued_jobs do
          expect do
            subject
          end.to change { ActionMailer::Base.deliveries.size }.by(0)
        end
      end
    end
  end

  describe '#validation_mail ' do
    subject { mail_service.send(:validation_mail) }
    context 'when params is valid' do
      let(:mail_service) { V1::MailService.new(valid_params) }

      it 'return false' do
        expect(subject).to eq false
      end
    end

    context 'when params is valid' do
      let(:mail_service) { V1::MailService.new(invalid_params) }

      it 'return false' do
        expect(subject).to eq true
      end
    end
  end

  describe '#redirect_to_success' do
    let(:valid_params) do
      {
        to_email: 'receive@mail.com',
        name: 'receive',
        email: 'sender@mail.com',
        message: 'message',
        url_success: 'custom success url'
      }
    end
    let(:mail_service) { V1::MailService.new(valid_params) }
    subject { mail_service.send(:send_and_redirect) }

    it 'return custom success url' do
      expect(subject).to eq valid_params[:url_success]
    end
  end
end
