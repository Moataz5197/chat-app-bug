class V1::ChatsController < ApplicationController

    def index
        if @application = Application.where(authentication_token:params[:application_authentication_token]).first
            @chats = Chat.all
            render json: @chats.as_json(only:[:chat_number,:authentication_token]), status: :ok
        else
            head(:unauthorized)
        end
    end

    def create
        if @application = Application.where(authentication_token:params[:application_authentication_token]).first
            if @application.chat_count
            else

                @chats = Chat.new()
                render json: @chats.as_json(only:[:chat_number,:authentication_token]), status: :ok
            end
        else
            head(:unauthorized)
        end

    end
    def destroy

    end
    def update
    end

    def show
    end

    # private 
    # def chat_params
    #     params.require(:chat).permit(:chat_number)
    # end

end