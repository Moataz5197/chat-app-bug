Rails.application.routes.draw do
  namespace :v1 do
    resources :applications, param: :application_token do
      resources :chats, param: :chat_number do
        resources :messages
      end
    end
  end
end
