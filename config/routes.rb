Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
     
      resources :mails do
        post 'mails', to: 'mails#create_mail'
      end

    end
  end
end
