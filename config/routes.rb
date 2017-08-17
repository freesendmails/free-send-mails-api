Rails.application.routes.draw do
  namespace :v1 do
    post 'mails/(:to)', to: 'mails#create_mail', constraints: { to: /.+@.+\..*/ }
  end
end
