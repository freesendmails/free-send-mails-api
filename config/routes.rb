Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      post 'mails/(:to)', to: 'mails#create_mail', :constraints => { :to => /.+@.+\..*/ }

    end
  end
end
