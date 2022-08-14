class ApplicationController < ActionController::API
    acts_as_token_authentication_handler_for Application, fallback: :none
end
