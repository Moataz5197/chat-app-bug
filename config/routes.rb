Rails.application.routes.draw do
  #devise_for :applications
  namespace :v1 do
    resources :applications, param: :authentication_token do
      resources :chats, param: :number do
        resources :messages
      end
    end
  end
end
