class Application < ApplicationRecord
    acts_as_token_authenticatable
    has_many :chats
end
